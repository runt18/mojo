// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/resource_def.h"

#include "base/logging.h"

namespace compositor {

SceneResourceDef::SceneResourceDef(SceneDef* referenced_scene)
    : referenced_scene_(referenced_scene) {}

SceneResourceDef::~SceneResourceDef() {}

ResourceDef::Type SceneResourceDef::type() const {
  return Type::kScene;
}

ImageResourceDef::ImageResourceDef(const std::shared_ptr<RenderImage>& image)
    : image_(image) {
  DCHECK(image);
}

ImageResourceDef::~ImageResourceDef() {}

ResourceDef::Type ImageResourceDef::type() const {
  return Type::kImage;
}

}  // namespace compositor
