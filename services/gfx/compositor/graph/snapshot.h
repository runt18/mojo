// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_GRAPH_SNAPSHOT_H_
#define SERVICES_GFX_COMPOSITOR_GRAPH_SNAPSHOT_H_

#include <iosfwd>
#include <memory>
#include <unordered_set>

#include "base/macros.h"
#include "mojo/services/geometry/interfaces/geometry.mojom.h"
#include "mojo/services/gfx/composition/interfaces/scheduling.mojom.h"

namespace compositor {

class SceneDef;
class RenderFrame;

// Describes a single frame snapshot of the scene graph, sufficient for
// rendering and hit testing.  When the snapshot is made, all predicated and
// blocked scene nodes are evaluated to produce a final description of
// the frame along with its dependencies.
//
// The snapshot holds a list of dependencies for the scenes whose state was
// originally used to produce it.  The snapshot must be invalidated whenever
// any of these scenes change.  Note that the snapshot will contain a list
// of dependencies even in the case where a frame could not be produced,
// in which case the dependencies express the set of scenes which, if updated,
// might allow composition to be unblocked and make progress on a subsequent
// frame.
//
// Snapshot objects are not thread-safe since they have direct references to
// the scene graph definition.  However, the snapshot's frame is thread-safe
// and is intended to be shared by other components.
class Snapshot {
 public:
  ~Snapshot();

  // Returns true if the snapshot is valid.
  bool valid() const { return valid_; }

  // Gets the frame produced from this snapshot, or null if none.
  //
  // This is always null if |valid()| is false but it may be null even
  // when |valid()| is true if composition was blocked and unable to produce
  // a frame during the snapshot operation.
  const std::shared_ptr<RenderFrame>& frame() const { return frame_; }

  // Unconditionally marks the snapshot as invalid.
  //
  // Returns true if the snapshot became invalid as a result of this operation,
  // or false if it was already invalid.
  bool Invalidate();

  // Invalidates the snapshot if it has a dependency on the specified scene.
  // When this occurs, the entire list of dependencies is flushed (we no longer
  // need them) in case the scene in question or its contents are about to
  // be destroyed.
  //
  // Returns true if the snapshot became invalid as a result of this operation,
  // or false if it was already invalid.
  bool InvalidateScene(SceneDef* scene_def);

 private:
  friend class SnapshotBuilder;

  Snapshot();

  std::unordered_set<SceneDef*> dependencies_;
  std::shared_ptr<RenderFrame> frame_;
  bool valid_ = true;

  DISALLOW_COPY_AND_ASSIGN(Snapshot);
};

// Builder for snapshots.
class SnapshotBuilder {
 public:
  // Creates a snapshot builder.
  //
  // |block_log|, if not null, the snapshotter will append information to
  // this stream describing the parts of the scene graph for which
  // composition was blocked.
  explicit SnapshotBuilder(std::ostream* block_log);
  ~SnapshotBuilder();

  // If not null, the snapshotter will append information to this stream
  // describing the parts of the scene graph for which composition was blocked.
  std::ostream* block_log() { return block_log_; }

  // Adds a scene dependency to the snapshot.
  void AddSceneDependency(SceneDef* scene);

  // Builds a snapshot rooted at the specified scene.
  std::unique_ptr<Snapshot> Build(
      SceneDef* root_scene,
      const mojo::Rect& viewport,
      const mojo::gfx::composition::FrameInfo& frame_info);

 private:
  std::ostream* const block_log_;
  std::unique_ptr<Snapshot> snapshot_;

  DISALLOW_COPY_AND_ASSIGN(SnapshotBuilder);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_GRAPH_SNAPSHOT_H_
