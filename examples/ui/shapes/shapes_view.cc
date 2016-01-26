// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/ui/shapes/shapes_view.h"

#include "base/bind.h"
#include "base/logging.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkColor.h"
#include "third_party/skia/include/core/SkSurface.h"

namespace examples {

namespace {
constexpr uint32_t kContentImageResourceId = 1;
constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;
}  // namespace

ShapesView::ShapesView(
    mojo::ApplicationImpl* app_impl,
    const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback)
    : GaneshView(app_impl, "Shapes", create_view_callback) {}

ShapesView::~ShapesView() {}

void ShapesView::OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                          mojo::Array<uint32_t> children_needing_layout,
                          const OnLayoutCallback& callback) {
  size_.width = layout_params->constraints->max_width;
  size_.height = layout_params->constraints->max_height;

  // Submit the new layout information.
  auto info = mojo::ui::ViewLayoutResult::New();
  info->size = size_.Clone();
  callback.Run(info.Pass());

  // Draw!
  UpdateScene();
}

void ShapesView::UpdateScene() {
  mojo::Rect bounds;
  bounds.width = size_.width;
  bounds.height = size_.height;

  auto update = mojo::gfx::composition::SceneUpdate::New();

  // Draw the content of the view to a texture and include it as an
  // image resource in the scene.
  mojo::gfx::composition::ResourcePtr content_resource =
      ganesh_renderer()->DrawCanvas(
          size_, base::Bind(&ShapesView::DrawContent, base::Unretained(this)));
  DCHECK(content_resource);
  update->resources.insert(kContentImageResourceId, content_resource.Pass());

  // Add a root node to the scene graph to draw the image resource to
  // the screen such that it fills the entire view.
  auto root_node = mojo::gfx::composition::Node::New();
  root_node->op = mojo::gfx::composition::NodeOp::New();
  root_node->op->set_image(mojo::gfx::composition::ImageNodeOp::New());
  root_node->op->get_image()->content_rect = bounds.Clone();
  root_node->op->get_image()->image_resource_id = kContentImageResourceId;
  update->nodes.insert(kRootNodeId, root_node.Pass());

  // Submit the scene update then publish it to cause the changes to be
  // applied.
  scene()->Update(update.Pass());
  scene()->Publish(nullptr);
}

void ShapesView::DrawContent(SkCanvas* canvas) {
  canvas->clear(SK_ColorCYAN);

  SkPaint paint;
  paint.setColor(SK_ColorGREEN);
  SkRect rect = SkRect::MakeWH(size_.width, size_.height);
  rect.inset(10, 10);
  canvas->drawRect(rect, paint);

  paint.setColor(SK_ColorRED);
  paint.setFlags(SkPaint::kAntiAlias_Flag);
  canvas->drawCircle(50, 100, 100, paint);
}

}  // namespace examples
