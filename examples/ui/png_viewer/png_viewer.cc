// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <string>

#include "base/bind.h"
#include "base/macros.h"
#include "base/memory/scoped_ptr.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/data_pipe_utils/data_pipe_utils.h"
#include "mojo/public/c/system/main.h"
#include "mojo/ui/content_viewer_app.h"
#include "mojo/ui/ganesh_view.h"
#include "third_party/skia/include/core/SkBitmap.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkImage.h"
#include "third_party/skia/include/core/SkSurface.h"
#include "ui/gfx/codec/png_codec.h"

namespace examples {

namespace {
constexpr uint32_t kContentImageResourceId = 1;
constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;
}  // namespace

class PNGView : public mojo::ui::GaneshView {
 public:
  PNGView(
      mojo::ApplicationImpl* app_impl,
      const skia::RefPtr<SkImage>& image,
      const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback)
      : GaneshView(app_impl, "PNGViewer", create_view_callback), image_(image) {
    DCHECK(image_);
  }

  ~PNGView() override {}

 private:
  // |GaneshView|:
  void OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                mojo::Array<uint32_t> children_needing_layout,
                const OnLayoutCallback& callback) override {
    size_.width = layout_params->constraints->max_width;
    size_.height = layout_params->constraints->max_height;

    auto info = mojo::ui::ViewLayoutResult::New();
    info->size = size_.Clone();
    callback.Run(info.Pass());

    UpdateScene();
  }

  void UpdateScene() {
    mojo::Rect bounds;
    bounds.width = size_.width;
    bounds.height = size_.height;

    auto update = mojo::gfx::composition::SceneUpdate::New();
    mojo::gfx::composition::ResourcePtr content_resource =
        ganesh_renderer()->DrawCanvas(
            size_, base::Bind(&PNGView::DrawContent, base::Unretained(this)));
    DCHECK(content_resource);
    update->resources.insert(kContentImageResourceId, content_resource.Pass());

    auto root_node = mojo::gfx::composition::Node::New();
    root_node->op = mojo::gfx::composition::NodeOp::New();
    root_node->op->set_image(mojo::gfx::composition::ImageNodeOp::New());
    root_node->op->get_image()->content_rect = bounds.Clone();
    root_node->op->get_image()->image_resource_id = kContentImageResourceId;
    update->nodes.insert(kRootNodeId, root_node.Pass());

    scene()->Update(update.Pass());
    scene()->Publish(nullptr);
  }

  void DrawContent(SkCanvas* canvas) {
    canvas->clear(SK_ColorBLACK);

    int32_t w, h;
    if (size_.width * image_->height() < size_.height * image_->width()) {
      w = size_.width;
      h = image_->height() * size_.width / image_->width();
    } else {
      w = image_->width() * size_.height / image_->height();
      h = size_.height;
    }
    canvas->drawImageRect(
        image_.get(), SkRect::MakeWH(image_->width(), image_->height()),
        SkRect::MakeXYWH((size_.width - w) / 2, (size_.height - h) / 2, w, h),
        nullptr);
  }

  skia::RefPtr<SkImage> image_;
  mojo::Size size_;

  DISALLOW_COPY_AND_ASSIGN(PNGView);
};

class PNGContentViewProviderApp : public mojo::ui::ViewProviderApp {
 public:
  PNGContentViewProviderApp(skia::RefPtr<SkImage> image) : image_(image) {
    DCHECK(image_);
  }

  ~PNGContentViewProviderApp() override {}

  bool CreateView(
      const std::string& connection_url,
      mojo::InterfaceRequest<mojo::ServiceProvider> services,
      mojo::ServiceProviderPtr exposed_services,
      const mojo::ui::ViewProvider::CreateViewCallback& callback) override {
    new PNGView(app_impl(), image_, callback);
    return true;
  }

 private:
  skia::RefPtr<SkImage> image_;

  DISALLOW_COPY_AND_ASSIGN(PNGContentViewProviderApp);
};

class PNGContentViewerApp : public mojo::ui::ContentViewerApp {
 public:
  PNGContentViewerApp() {}

  ~PNGContentViewerApp() override {}

  mojo::ui::ViewProviderApp* LoadContent(
      const std::string& content_handler_url,
      mojo::URLResponsePtr response) override {
    std::string data;
    mojo::common::BlockingCopyToString(response->body.Pass(), &data);
    SkBitmap bitmap;
    if (!::gfx::PNGCodec::Decode(
            reinterpret_cast<const unsigned char*>(data.data()), data.length(),
            &bitmap) ||
        bitmap.empty()) {
      LOG(ERROR) << "Could not decode PNG.";
      return nullptr;
    }

    return new PNGContentViewProviderApp(
        skia::AdoptRef(SkImage::NewFromBitmap(bitmap)));
  }

 private:
  DISALLOW_COPY_AND_ASSIGN(PNGContentViewerApp);
};

}  // namespace examples

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new examples::PNGContentViewerApp());
  return runner.Run(application_request);
}
