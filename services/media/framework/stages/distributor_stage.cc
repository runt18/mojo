// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/stages/distributor_stage.h"

namespace mojo {
namespace media {

DistributorStage::DistributorStage(
    MultiStreamPacketSourcePtr packet_source) :
    packet_source_(packet_source),
    ended_streams_(0) {
  DCHECK(packet_source);
  outputs_.resize(packet_source->stream_count());
}

DistributorStage::~DistributorStage() {}

uint32_t DistributorStage::input_count() const {
  return 0;
};

StageInput& DistributorStage::input(uint32_t index) {
  NOTREACHED();
  static StageInput result;
  return result;
}

uint32_t DistributorStage::output_count() const {
  return outputs_.size();
}

StageOutput& DistributorStage::output(uint32_t index) {
  DCHECK(index < outputs_.size());
  return outputs_[index];
}

bool DistributorStage::Prepare(UpdateCallback update_callback) {
  for (StageOutput& output : outputs_) {
    output.Prepare(false);
  }
  return false;
}

void DistributorStage::Update(Engine* engine) {
  DCHECK(engine);

  bool has_positive_demand = false;
  for (StageOutput& output : outputs_) {
    if (output.demand() == Demand::kPositive) {
      has_positive_demand = true;
      break;
    }
  }

  while (true) {
    if (cached_packet_ && has_positive_demand) {
      DCHECK(cached_packet_output_index_ < outputs_.size());
      StageOutput& output = outputs_[cached_packet_output_index_];

      if (output.demand() != Demand::kNegative) {
        // cached_packet_ is intended for an output which will accept packets.
        output.SupplyPacket(std::move(cached_packet_), engine);
      } else {
      }
    }

    if (cached_packet_) {
      // There's still a cached packet. We're done for now.
      return;
    }

    if (ended_streams_ == outputs_.size()) {
      // We've seen end-of-stream for all streams. All done.
      return;
    }

    // Pull a packet from the source.
    cached_packet_ = packet_source_->PullPacket(&cached_packet_output_index_);
    DCHECK(cached_packet_);
    DCHECK(cached_packet_output_index_ < outputs_.size());

    if (cached_packet_->end_of_stream()) {
      ended_streams_++;
    }
  }
}

}  // namespace media
}  // namespace mojo
