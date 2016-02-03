// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/engine.h"

namespace mojo {
namespace media {

uint32_t Engine::Part::input_count() {
  DCHECK(stage_ != nullptr);
  return stage_->input_count();
}

Engine::Input Engine::Part::input(uint32_t index) {
  DCHECK(stage_ != nullptr && index < stage_->input_count());
  return Input(stage_, index);
}

Engine::Input Engine::Part::input() {
  DCHECK(stage_ != nullptr && stage_->input_count() == 1);
  return Input(stage_, 0);
}

uint32_t Engine::Part::output_count() {
  DCHECK(stage_ != nullptr);
  return stage_->output_count();
}

Engine::Output Engine::Part::output(uint32_t index) {
  DCHECK(stage_ != nullptr && index < stage_->output_count());
  return Output(stage_, index);
}

Engine::Output Engine::Part::output() {
  DCHECK(stage_ != nullptr && stage_->output_count() == 1);
  return Output(stage_, 0);
}

Engine::Part Engine::Part::upstream_part(uint32_t index) {
  DCHECK(stage_ != nullptr && index < stage_->input_count());
  return Part(stage_->input(index).upstream_stage());
}

Engine::Part Engine::Part::upstream_part() {
  DCHECK(stage_ != nullptr && stage_->input_count() == 1);
  return Part(stage_->input(0).upstream_stage());
}

Engine::Part Engine::Part::downstream_part(uint32_t index) {
  DCHECK(stage_ != nullptr && index < stage_->output_count());
  return Part(stage_->output(index).downstream_stage());
}

Engine::Part Engine::Part::downstream_part() {
  DCHECK(stage_ != nullptr && stage_->output_count() == 1);
  return Part(stage_->output(0).downstream_stage());
}

Engine::Engine() {
  update_function_ = [this](Stage* stage) {
    DCHECK(stage);
    base::AutoLock lock(lock_);
    UpdateUnsafe(stage);
    UpdateUnsafe();
  };
}

Engine::~Engine() {
  Reset();
}

void Engine::RemovePart(Part part) {
  DCHECK(part);
  base::AutoLock lock(lock_);
  RemoveUnsafe(part.stage_);
}

Engine::Part Engine::Connect(Output output, Input input) {
  DCHECK(output);
  DCHECK(input);

  base::AutoLock lock(lock_);

  if (output.connected()) {
    DisconnectOutputUnsafe(output.stage_, output.index_);
  }
  if (input.connected()) {
    DisconnectInputUnsafe(input.stage_, input.index_);
  }

  output.stage_output().connect(input.stage_, input.index_);
  input.stage_input().connect(output.stage_, output.index_);

  return input.part();
}

Engine::Part Engine::ConnectParts(Part upstream_part, Part downstream_part) {
  DCHECK(upstream_part);
  DCHECK(downstream_part);
  Connect(upstream_part.output(), downstream_part.input());
  return downstream_part;
}

Engine::Part Engine::ConnectOutputToPart(
    Output output,
    Part downstream_part) {
  DCHECK(output);
  DCHECK(downstream_part);
  Connect(output, downstream_part.input());
  return downstream_part;
}

Engine::Part Engine::ConnectPartToInput(Part upstream_part, Input input) {
  DCHECK(upstream_part);
  DCHECK(input);
  Connect(upstream_part.output(), input);
  return input.part();
}

void Engine::DisconnectOutput(Output output) {
  DCHECK(output);

  base::AutoLock lock(lock_);
  DisconnectOutputUnsafe(output.stage_, output.index_);
}

void Engine::DisconnectInput(Input input) {
  DCHECK(input);

  base::AutoLock lock(lock_);
  DisconnectInputUnsafe(input.stage_, input.index_);
}

void Engine::RemovePartsConnectedToPart(Part part) {
  DCHECK(part);

  base::AutoLock lock(lock_);

  std::deque<Part> to_remove { part };

  while (!to_remove.empty()) {
    Part part = to_remove.front();
    to_remove.pop_front();

    for (uint32_t i = 0; i < part.input_count(); ++i) {
      to_remove.push_back(part.upstream_part(i));
    }

    for (uint32_t i = 0; i < part.output_count(); ++i) {
      to_remove.push_back(part.downstream_part(i));
    }

    RemoveUnsafe(part.stage_);
  }
}

void Engine::RemovePartsConnectedToOutput(Output output) {
  DCHECK(output);

  if (!output.connected()) {
    return;
  }

  Part downstream_part = output.downstream_part();
  DisconnectOutput(output);
  RemovePartsConnectedToPart(downstream_part);
}

void Engine::RemovePartsConnectedToInput(Input input) {
  DCHECK(input);

  if (!input.connected()) {
    return;
  }

  Part upstream_part = input.upstream_part();
  DisconnectInput(input);
  RemovePartsConnectedToPart(upstream_part);
}

void Engine::Prepare() {
  base::AutoLock lock(lock_);
  for (Stage* sink : sinks_) {
    sink->Prepare(update_function_);
    sink->prepared_ = true;
    uint32_t input_count = sink->input_count();
    for (uint32_t input_index = 0; input_index < input_count; input_index++) {
      MaybePrepareUnsafe(sink->input(input_index).upstream_stage());
    }
  }
}

void Engine::Prepare(Part part) {
  DCHECK(part);
  base::AutoLock lock(lock_);
  MaybePrepareUnsafe(part.stage_);
}

void Engine::PrimeSinks() {
  lock_.Acquire();
  std::list<Stage*> sinks(sinks_);
  lock_.Release();

  // TODO(dalesat): Threading issue: these sinks may go away during priming.
  for (Stage* sink : sinks) {
    sink->Prime();
  }
}

void Engine::Reset() {
  base::AutoLock lock(lock_);
  while (!supply_backlog_.empty()) {
    supply_backlog_.pop();
  }
  while (!demand_backlog_.empty()) {
    demand_backlog_.pop();
  }
  sources_.clear();
  sinks_.clear();
  while (!stages_.empty()) {
    Stage* stage = stages_.front();
    stages_.pop_front();
    delete stage;
  }
}

void Engine::PushToSupplyBacklogUnsafe(Stage* stage) {
  lock_.AssertAcquired();

  DCHECK(stage);
  packets_produced_ = true;
  if (!stage->in_supply_backlog_) {
    supply_backlog_.push(stage);
    stage->in_supply_backlog_ = true;
  }
}

void Engine::PushToDemandBacklogUnsafe(Stage* stage) {
  lock_.AssertAcquired();

  DCHECK(stage);
  if (!stage->in_demand_backlog_) {
    demand_backlog_.push(stage);
    stage->in_demand_backlog_ = true;
  }
}

Engine::Part Engine::Add(Stage* stage) {
  base::AutoLock lock(lock_);

  stages_.push_back(stage);
  if (stage->input_count() == 0) {
    sources_.push_back(stage);
  }
  if (stage->output_count() == 0) {
    sinks_.push_back(stage);
  }
  return Part(stage);
}

void Engine::DisconnectOutputUnsafe(Stage* stage, uint32_t index) {
  DCHECK(stage);
  DCHECK(index < stage->output_count());

  lock_.AssertAcquired();

  StageOutput& stage_output = stage->output(index);

  if (stage_output.downstream_stage() == nullptr) {
    return;
  }

  stage_output.mate().disconnect();
  stage_output.disconnect();
}

void Engine::DisconnectInputUnsafe(Stage* stage, uint32_t index) {
  DCHECK(stage);
  DCHECK(index < stage->input_count());

  lock_.AssertAcquired();

  StageInput& stage_input = stage->input(index);

  if (stage_input.upstream_stage() == nullptr) {
    return;
  }

  stage_input.mate().disconnect();
  stage_input.disconnect();
}

void Engine::RemoveUnsafe(Stage* stage) {
  DCHECK(stage);

  lock_.AssertAcquired();

  uint32_t input_count = stage->input_count();
  for (uint32_t input_index = 0; input_index < input_count; input_index++) {
    if (stage->input(input_index).connected()) {
      DisconnectInputUnsafe(stage, input_index);
    }
  }

  uint32_t output_count = stage->output_count();
  for (uint32_t output_index = 0; output_index < output_count; output_index++) {
    if (stage->output(output_index).connected()) {
      DisconnectOutputUnsafe(stage, output_index);
    }
  }

  sources_.remove(stage);
  sinks_.remove(stage);
  stages_.remove(stage);
  delete stage;
}

// static
Stage* Engine::CreateStage(MultiStreamPacketSourcePtr source) {
  return new DistributorStage(source);
}

// static
Stage* Engine::CreateStage(PacketTransformPtr transform) {
  return new PacketTransformStage(transform);
}

// static
Stage* Engine::CreateStage(ActiveSourcePtr source) {
  return new ActiveSourceStage(source);
}

// static
Stage* Engine::CreateStage(ActiveSinkPtr sink) {
  return new ActiveSinkStage(sink);
}

// static
Stage* Engine::CreateStage(LpcmTransformPtr transform) {
  return new LpcmTransformStage(transform);
}

void Engine::MaybePrepareUnsafe(Stage* stage) {
  lock_.AssertAcquired();

  if (stage == nullptr || stage->prepared_) {
    return;
  }

  // Make sure all downstream stages have been prepared.
  uint32_t output_count = stage->output_count();
  for (uint32_t output_index = 0; output_index < output_count; output_index++) {
    StageOutput& output = stage->output(output_index);
    if (output.connected() && !output.downstream_stage()->prepared()) {
      return;
    }
  }

  stage->Prepare(update_function_);
  stage->prepared_ = true;

  // Prepare all upstream stages.
  uint32_t input_count = stage->input_count();
  for (uint32_t input_index = 0; input_index < input_count; input_index++) {
    MaybePrepareUnsafe(stage->input(input_index).upstream_stage());
  }
}

void Engine::UpdateUnsafe() {
  lock_.AssertAcquired();

  while (true) {
    Stage* stage = PopFromSupplyBacklogUnsafe();
    if (stage != nullptr) {
      UpdateUnsafe(stage);
      continue;
    }

    stage = PopFromDemandBacklogUnsafe();
    if (stage != nullptr) {
      UpdateUnsafe(stage);
      continue;
    }

    break;
  }
}

void Engine::UpdateUnsafe(Stage *stage) {
  lock_.AssertAcquired();

  DCHECK(stage);

  packets_produced_ = false;

  stage->Update(this);

  // If the stage produced packets, it may need to reevaluate demand later.
  if (packets_produced_) {
    PushToDemandBacklogUnsafe(stage);
  }
}

Stage* Engine::PopFromSupplyBacklogUnsafe() {
  lock_.AssertAcquired();

  if (supply_backlog_.empty()) {
    return nullptr;
  }

  Stage* stage = supply_backlog_.front();
  supply_backlog_.pop();
  DCHECK(stage->in_supply_backlog_);
  stage->in_supply_backlog_ = false;
  return stage;
}

Stage* Engine::PopFromDemandBacklogUnsafe() {
  lock_.AssertAcquired();

  if (demand_backlog_.empty()) {
    return nullptr;
  }

  Stage* stage = demand_backlog_.top();
  demand_backlog_.pop();
  DCHECK(stage->in_demand_backlog_);
  stage->in_demand_backlog_ = false;
  return stage;
}

}  // namespace media
}  // namespace mojo
