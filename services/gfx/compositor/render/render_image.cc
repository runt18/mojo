// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/render/render_image.h"

#include "base/bind.h"
#include "base/location.h"
#include "base/logging.h"
#include "mojo/skia/ganesh_image_factory.h"
#include "third_party/skia/include/core/SkImage.h"

namespace compositor {

class RenderImage::Releaser {
 public:
  Releaser(const scoped_refptr<base::TaskRunner>& task_runner,
           const base::Closure& release_task)
      : task_runner_(task_runner), release_task_(release_task) {
    DCHECK(task_runner_);
  }

  ~Releaser() { task_runner_->PostTask(FROM_HERE, release_task_); }

 private:
  scoped_refptr<base::TaskRunner> const task_runner_;
  base::Closure const release_task_;
};

class RenderImage::Generator : public mojo::skia::MailboxTextureImageGenerator {
 public:
  Generator(const std::shared_ptr<Releaser>& releaser,
            const GLbyte mailbox_name[GL_MAILBOX_SIZE_CHROMIUM],
            GLuint sync_point,
            uint32_t width,
            uint32_t height)
      : MailboxTextureImageGenerator(mailbox_name, sync_point, width, height),
        releaser_(releaser) {
    DCHECK(releaser_);
  }

  ~Generator() override {}

 private:
  std::shared_ptr<Releaser> releaser_;
};

RenderImage::RenderImage(const skia::RefPtr<SkImage>& image,
                         const std::shared_ptr<Releaser>& releaser)
    : image_(image), releaser_(releaser) {
  DCHECK(image_);
  DCHECK(releaser_);
}

RenderImage::~RenderImage() {}

std::shared_ptr<RenderImage> RenderImage::CreateFromMailboxTexture(
    const GLbyte mailbox_name[GL_MAILBOX_SIZE_CHROMIUM],
    GLuint sync_point,
    uint32_t width,
    uint32_t height,
    const scoped_refptr<base::TaskRunner>& task_runner,
    const base::Closure& release_task) {
  std::shared_ptr<Releaser> releaser =
      std::make_shared<Releaser>(task_runner, release_task);
  skia::RefPtr<SkImage> image = skia::AdoptRef(SkImage::NewFromGenerator(
      new Generator(releaser, mailbox_name, sync_point, width, height)));
  if (!image)
    return nullptr;

  return std::make_shared<RenderImage>(image, releaser);
}

}  // namespace compositor
