// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_H_

#include <list>
#include <queue>
#include <stack>

#include "base/synchronization/lock.h"
#include "services/media/framework/stages/active_sink_stage.h"
#include "services/media/framework/stages/active_source_stage.h"
#include "services/media/framework/stages/distributor_stage.h"
#include "services/media/framework/stages/lpcm_transform_stage.h"
#include "services/media/framework/stages/packet_transform_stage.h"
#include "services/media/framework/stages/stage.h"

namespace mojo {
namespace media {

//
// USAGE
//
// TODO(dalesat): Consider adding a suffix to Engine::Part/Input/Output to
// indicate that they're references.
// TODO(dalesat): Consider folding PrimeSinks into Prepare.
//
// Engine is a container for sources, sinks and transforms ('parts') connected
// in a graph. Engine::Part, Engine::Input and Engine::Output are all opaque
// references to parts and their inputs and outputs. Engine provides a variety
// of methods for adding and removing parts and for connecting inputs and
// outputs to form a graph.
//
// In addition to containing parts and representing their interconnection,
// Engine manages the coordinated operation of its constituent parts and
// transports media from part to part. The Prepare method prepares the graph
// for operation, and the PrimeSinks method tells the sinks in the graph to
// prime themselves. Any additional actions required to make the graph operate
// (such as manipulating a rate control interface) is out of scope.
//
// Parts added to the engine are referenced using shared pointers. The engine
// holds pointers to the parts it contains, and the application, in many cases,
// also holds pointers to the parts so it can call methods that are outside the
// engine's scope. When a part is added the Engine returns an Engine::Part
// object, which can be used to reference the part when the graph is modified.
// Engine::Part objects can be interrogated to retrieve inputs (as Engine::Input
// objects) and outputs (as Engine::Output objects).
//
// Some support is provided for modifying graphs that are operating. This
// capability isn't fully developed at the moment. Prepare(Part) is an example
// of a method provided for this purpose.
//
// Parts come in various flavors, defined by 'model' abstract classes. The
// current list of supported models is:
//
//  ActiveSink              - a sink that consumes packets asynchronously
//  ActiveSource            - a source that produces packets asynchronously
//  LpcmMixer               - a transform that mixes LPCM frames from multiple
//                            inputs and produces a single stream of LPCM frames
//                            via one output
//  LpcmSource              - a source that produces LPCM frames synchronously
//  LpcmTransform           - a synchronous transform with one LPCM input and
//                            one LPCM output
//  MultiStreamPacketSource - a source that produces multiple streams of packets
//                            synchronously
//  PacketTransform         - a synchronous transform that consumes and produces
//                            packets via one input and one output
//
// Other models will be defined in the future as needed.
//

//
// DESIGN
//
// The Engine is implemented as a system of cooperating objects. Of those
// objects, only the engine itself is of relevance to code that uses Engine and
// to part implementations. The other objects are:
//
// Stage
// A stage hosts a single part. There are many subclasses of Stage, one for
// each supported part model. The stage's job is to implement the contract
// represented by the model so the parts that conform to the model can
// participate in the operation of the engine. Stages are uniform with respect
// to how they interact with engine. Engine::Part references a stage.
//
// StageInput
// A stage possesses zero or more StageInput instances. StageInput objects
// implement the supply of media into the stage and demand for media signalled
// upstream. StageInputs receive media from StageOutputs in the form of packets
// (type Packet). LpcmStageInput is a subclass of StageInput that interoperates
// with LpcmStageInputs in a way that provides optimizations relavant to LPCM
// audio media. Engine::Input references a StageInput.
//
// StageOutput
// A stage possesses zero or more StageOutput instances. StageOutput objects
// implement the supply of media output of the stage to a downstream input and
// demand for media signalled from that input. LpcmStageOutput implements
// optimized LPCM flow. Engine::Output references a StageOutput.
//
// Engine uses a 'work list' algorithm to operate the contained graph. The
// engine has a backlog of stages that need to be updated. To advance the
// operation of the graph, the engine removes a stage from the backlog and calls
// the stage's Update method. The Stage::Update may cause stages to be added
// synchronously to the the backlog. This procedure continues until the backlog
// is empty.
//
// Stage::Update is the stage's opportunity to react to the supply of new media
// via its inputs and the signalling of new demand via its outputs. During
// Update, the stage does whatever work it can with the current supply and
// demand, possibly supplying media downstream through its outputs and/or
// signalling new demand via its inputs. When a stage supplies media through
// an output, the downstream stage is added to the backlog. When a stage updates
// its demand through an input, the upstream stage is added to the backlog.
//
// The process starts when a stage invokes an update callback supplied by the
// engine. Stages that implement synchronous models never do this. Other stages
// do this as directed by the parts they host in accordance with their
// respective models. When a stage is ready to supply media or update demand
// due to external events, it calls the update callback. The engine responds by
// adding the stage to the backlog and then burning down the backlog. The stage
// that called back is updated first, and then all the work that can be done
// synchronously as a result of the external event is completed. In this way,
// the operation of the graph is driven by external events signalled through
// update callbacks.
//
// Currently, Engine uses an opportunistic threading model that only allows
// one thread to drive the backlog processing at any given time. The engine
// runs the processing on whatever thread enters it via an update callback.
// An engine employs a single lock that protects manipulation of the graph and
// processing of the backlog. Stage update methods are invoked with that lock
// taken. This arrangement implies the following constraints:
//
// 1) An update callback cannot be called synchronously with a Stage::Update
//    call, because the lock is taken for the duration of Update, and the
//    callback will take the lock. Update callbacks may occur during Engine::
//    PrimeSinks, and they generally will.
// 2) A stage cannot update supply/demand on its inputs/outputs except during
//    Update. When an external event occurs, the stage and/or its hosted part
//    should update its internal state as required and invoke the callback.
//    During the subsequent Update, the stage and/or part can then update
//    supply and/or demand.
// 3) Threads used to call update callbacks must be suitable for operating the
//    engine. There is currently no affordance for processing other tasks on
//    a thread while the callback is running. A callback may run for a long
//    time, depending on how much work needs to be done.
// 4) Parts cannot rely on being called back on the same thread on which they
//    invoke update callbacks. This may require additional synchronization and
//    thread transitions inside the part.
// 5) If a part takes a lock of its own during Update, it should not also hold
//    that lock when calling the update callback. Doing so will result in
//    deadlock.
//
// NOTE: Allocators, not otherwise discussed here, are required to be thread-
// safe so that packets may be cleaned up on any thread.
//
// In the future, the threading model will be enhanced. Intended features
// include:
// 1) Support for multiple threads.
// 2) Marshalling update callbacks to a different thread.
//

// Host for a source, sink or transform.
class Engine {
 public:
  class Input;
  class Output;

  // Opaque Stage pointer used for graph building.
  class Part {
   public:
    Part() : stage_(nullptr) {}

    uint32_t input_count();
    Input input(uint32_t index);
    Input input();
    uint32_t output_count();
    Output output(uint32_t index);
    Output output();
    Part upstream_part(uint32_t index);
    Part upstream_part();
    Part downstream_part(uint32_t index);
    Part downstream_part();

   private:
    explicit Part(Stage* stage) : stage_(stage) {}

    explicit operator bool() const { return stage_ != nullptr; }

    Stage* stage_;

    friend Engine;
    friend Input;
    friend Output;
  };

  // Opaque StageInput pointer used for graph building.
  class Input {
   public:
    Input() : stage_(nullptr), index_(0) {}

    explicit operator bool() const { return stage_ != nullptr; }

    Part part() { return Part(stage_); }

    bool connected() {
      DCHECK(stage_);
      return stage_input().upstream_stage() != nullptr;
    }

    Part upstream_part() {
      DCHECK(connected());
      return Part(stage_input().upstream_stage());
    }

   private:
    Input(Stage* stage, uint32_t index) :
        stage_(stage), index_(index) {
      DCHECK(stage_);
      DCHECK(index_ < stage_->input_count());
    }

    StageInput& stage_input() {
      DCHECK(stage_);
      return stage_->input(index_);
    }

    Stage* stage_;
    uint32_t index_;

    friend Engine;
    friend Part;
    friend Output;
  };

  // Opaque StageOutput pointer used for graph building.
  class Output {
   public:
    Output() : stage_(nullptr), index_(0) {}

    explicit operator bool() const { return stage_ != nullptr; }

    Part part() { return Part(stage_); }

    bool connected() {
      DCHECK(stage_);
      return stage_output().downstream_stage() != nullptr;
    }

    Part downstream_part() {
      DCHECK(connected());
      return Part(stage_output().downstream_stage());
    }

   private:
    Output(Stage* stage, uint32_t index) :
        stage_(stage), index_(index) {
      DCHECK(stage_);
      DCHECK(index_ < stage_->output_count());
    }

    StageOutput& stage_output() {
      DCHECK(stage_);
      return stage_->output(index_);
    }

    Stage* stage_;
    uint32_t index_;

    friend Engine;
    friend Part;
    friend Input;
  };

  Engine();

  ~Engine();

  // Adds a part to the engine.
  template<typename T, typename TBase>
  Part Add(SharedPtr<T, TBase> t) {
    DCHECK(t);
    return Add(CreateStage(std::shared_ptr<TBase>(t)));
  }

  // Removes a part from the engine after disconnecting it from other parts.
  void RemovePart(Part part);

  // Connects an output connector to an input connector. Returns the dowstream
  // part.
  Part Connect(Output output, Input input);

  // Connects a part with exactly one output to a part with exactly one input.
  // Returns the downstream part.
  Part ConnectParts(Part upstream_part, Part downstream_part);

  // Connects an output connector to a part that has exactly one input. Returns
  // the downstream part.
  Part ConnectOutputToPart(Output output, Part downstream_part);

  // Connects a part with exactly one output to an input connector. Returns the
  // downstream part.
  Part ConnectPartToInput(Part upstream_part, Input input);

  // Disconnects an output connector and the input connector to which it's
  // connected.
  void DisconnectOutput(Output output);

  // Disconnects an input connector and the output connector to which it's
  // connected.
  void DisconnectInput(Input input);

  // Disconnects and removes part and everything connected to it.
  void RemovePartsConnectedToPart(Part part);

  // Disconnects and removes everything connected to output.
  void RemovePartsConnectedToOutput(Output output);

  // Disconnects and removes everything connected to input.
  void RemovePartsConnectedToInput(Input input);

  // Adds all the parts in t (which must all have one input and one output) and
  // connects them in sequence to the output connector. Returns the output
  // connector of the last part or the output parameter if it is empty.
  template<typename T>
  Output AddAndConnectAll(
      Output output,
      const T& t) {
    for (auto& element : t) {
      Part part = Add(CreateStage(element));
      Connect(output, part.input());
      output = part.output();
    }
    return output;
  }

  // Prepares the engine.
  void Prepare();

  // Prepares the part and everything upstream of it. This method is used to
  // prepare subgraphs added when the rest of the graph is already prepared.
  void Prepare(Part part);

  // Primes all the sinks in the graph.
  void PrimeSinks();

  // Removes all parts from the engine.
  void Reset();

 private:
  // Adds a stage to the engine.
  Part Add(Stage* stage);

  // Disconnects an output.
  void DisconnectOutputUnsafe(Stage* stage, uint32_t index);

  // Disconnects an input.
  void DisconnectInputUnsafe(Stage* stage, uint32_t index);

  // Removes a stage.
  void RemoveUnsafe(Stage* stage);

  // Creates a stage from a source, sink or transform. A specialization of this
  // template is defined for each type of source, sink or transform that can be
  // added to the engine.
  template<typename T>
  static Stage* CreateStage(std::shared_ptr<T> t);

  // CreateStage template specialization for MultiStreamPacketSource.
  static Stage* CreateStage(MultiStreamPacketSourcePtr source);

  // CreateStage template specialization for PacketTransform.
  static Stage* CreateStage(PacketTransformPtr transform);

  // CreateStage template specialization for ActiveSource.
  static Stage* CreateStage(ActiveSourcePtr source);

  // CreateStage template specialization for ActiveSink.
  static Stage* CreateStage(ActiveSinkPtr sink);

  // CreateStage template specialization for LpcmTransform.
  static Stage* CreateStage(LpcmTransformPtr transform);

  // Prepares a stage if all its downstream stages are prepared.
  void MaybePrepareUnsafe(Stage* stage);

  // Processes the entire backlog.
  void UpdateUnsafe();

  // Performs processing for a single stage, updating the backlog accordingly.
  void UpdateUnsafe(Stage *stage);

  // Pushes the stage to the supply backlog if it isn't already there.
  void PushToSupplyBacklogUnsafe(Stage* stage);

  // Pushes the stage to the demand backlog if it isn't already there.
  void PushToDemandBacklogUnsafe(Stage* stage);

  // Pops a stage from the supply backlog and returns it or returns nullptr if
  // the supply backlog is empty.
  Stage* PopFromSupplyBacklogUnsafe();

  // Pops a stage from the demand backlog and returns it or returns nullptr if
  // the demand backlog is empty.
  Stage* PopFromDemandBacklogUnsafe();

  mutable base::Lock lock_;
  std::list<Stage*> stages_;
  std::list<Stage*> sources_;
  std::list<Stage*> sinks_;
  // supply_backlog_ contains pointers to all the stages that have been supplied
  // (packets or frames) but have not been updated since. demand_backlog_ does
  // the same for demand. The use of queue vs stack here is a guess as to what
  // will yield the best results. It's possible that only a single backlog is
  // required.
  // TODO(dalesat): Determine the best ordering and implement it.
  std::queue<Stage*> supply_backlog_;
  std::stack<Stage*> demand_backlog_;
  Stage::UpdateCallback update_function_;
  bool packets_produced_;

  friend class StageInput;
  friend class StageOutput;
  friend class LpcmStageInput;
  friend class LpcmStageOutput;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_ENGINE_H_
