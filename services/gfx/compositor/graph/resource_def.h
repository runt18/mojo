// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_GRAPH_RESOURCE_DEF_H_
#define SERVICES_GFX_COMPOSITOR_GRAPH_RESOURCE_DEF_H_

#include <memory>

#include "base/macros.h"
#include "mojo/services/gfx/composition/interfaces/resources.mojom.h"
#include "services/gfx/compositor/render/render_image.h"

namespace compositor {

class SceneDef;

// Abstract scene graph resource definition.
class ResourceDef {
 public:
  enum class Type { kScene, kImage };

  ResourceDef() = default;
  virtual ~ResourceDef() = default;

  // Gets the resource type.
  virtual Type type() const = 0;

 private:
  DISALLOW_COPY_AND_ASSIGN(ResourceDef);
};

// Reference to another scene expressed as a resource definition.
// The pointer may be null if the referenced scene has become unavailable.
class SceneResourceDef : public ResourceDef {
 public:
  explicit SceneResourceDef(SceneDef* referenced_scene);
  ~SceneResourceDef() override;

  Type type() const override;

  // The referenced scene, may be null if unavailable.
  SceneDef* referenced_scene() { return referenced_scene_; }

  // Clears the referenced scene.
  // This is called by |SceneDef::UnlinkReferencedScene| when the
  // referenced scene is no longer available.
  void clear_referenced_scene() { referenced_scene_ = nullptr; }

 private:
  SceneDef* referenced_scene_;

  DISALLOW_COPY_AND_ASSIGN(SceneResourceDef);
};

// Reference to an image expressed as a resource definition.
class ImageResourceDef : public ResourceDef {
 public:
  explicit ImageResourceDef(const std::shared_ptr<RenderImage>& image);
  ~ImageResourceDef() override;

  Type type() const override;

  // The referenced image, may be null if unavailable.
  const std::shared_ptr<RenderImage>& image() { return image_; }

 private:
  std::shared_ptr<RenderImage> image_;

  DISALLOW_COPY_AND_ASSIGN(ImageResourceDef);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_GRAPH_RESOURCE_DEF_H_
