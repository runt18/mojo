// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/snapshot.h"

#include "base/logging.h"
#include "services/gfx/compositor/graph/scene_def.h"
#include "services/gfx/compositor/render/render_frame.h"
#include "services/gfx/compositor/render/render_layer.h"
#include "third_party/skia/include/core/SkRect.h"

namespace compositor {

Snapshot::Snapshot() {}

Snapshot::~Snapshot() {}

bool Snapshot::Invalidate() {
  if (valid_) {
    valid_ = false;
    dependencies_.clear();
    frame_.reset();
    return true;
  }
  return false;
}

bool Snapshot::InvalidateScene(SceneDef* scene_def) {
  DCHECK(scene_def);

  if (valid_ && dependencies_.find(scene_def) != dependencies_.end()) {
    return Invalidate();
  }
  return false;
}

SnapshotBuilder::SnapshotBuilder(std::ostream* block_log)
    : block_log_(block_log), snapshot_(new Snapshot()) {}

SnapshotBuilder::~SnapshotBuilder() {}

void SnapshotBuilder::AddSceneDependency(SceneDef* scene) {
  DCHECK(snapshot_);
  snapshot_->dependencies_.insert(scene);
}

std::unique_ptr<Snapshot> SnapshotBuilder::Build(
    SceneDef* root_scene,
    const mojo::Rect& viewport,
    const mojo::gfx::composition::FrameInfo& frame_info) {
  DCHECK(snapshot_);
  DCHECK(root_scene);

  SkRect sk_viewport =
      SkRect::MakeXYWH(viewport.x, viewport.y, viewport.width, viewport.height);
  RenderLayerBuilder layer_builder(&sk_viewport);
  if (root_scene->Snapshot(this, &layer_builder)) {
    snapshot_->frame_ =
        RenderFrame::Create(layer_builder.Build(), sk_viewport, frame_info);
  } else {
    snapshot_->valid_ = false;
  }
  return std::move(snapshot_);
}

}  // namespace compositor
