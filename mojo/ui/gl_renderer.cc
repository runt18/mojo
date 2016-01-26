// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/gl_renderer.h"

#ifndef GL_GLEXT_PROTOTYPES
#define GL_GLEXT_PROTOTYPES
#endif
#include <GLES2/gl2.h>
#include <GLES2/gl2extmojo.h>

#include "mojo/gpu/gl_context.h"
#include "mojo/gpu/gl_texture.h"

namespace mojo {
namespace ui {

GLRenderer::GLRenderer(base::WeakPtr<mojo::GLContext> gl_context,
                       uint32_t max_recycled_textures)
    : gl_context_(gl_context),
      max_recycled_textures_(max_recycled_textures),
      weak_factory_(this) {}

GLRenderer::~GLRenderer() {}

std::unique_ptr<mojo::GLTexture> GLRenderer::GetTexture(
    const mojo::Size& requested_size) {
  if (!gl_context_) {
    recycled_textures_.clear();
    return nullptr;
  }

  while (!recycled_textures_.empty()) {
    GLRecycledTextureInfo texture_info(std::move(recycled_textures_.front()));
    recycled_textures_.pop_front();
    if (texture_info.first->size().Equals(requested_size)) {
      gl_context_->MakeCurrent();
      glWaitSyncPointCHROMIUM(texture_info.second);
      return std::move(texture_info.first);
    }
  }

  return std::unique_ptr<GLTexture>(new GLTexture(gl_context_, requested_size));
}

mojo::gfx::composition::ResourcePtr GLRenderer::BindTextureResource(
    std::unique_ptr<GLTexture> texture) {
  if (!gl_context_)
    return nullptr;

  // Produce the texture.
  gl_context_->MakeCurrent();
  glBindTexture(GL_TEXTURE_2D, texture->texture_id());
  GLbyte mailbox[GL_MAILBOX_SIZE_CHROMIUM];
  glGenMailboxCHROMIUM(mailbox);
  glProduceTextureCHROMIUM(GL_TEXTURE_2D, mailbox);
  glBindTexture(GL_TEXTURE_2D, 0);
  GLuint sync_point = glInsertSyncPointCHROMIUM();

  // Populate the resource description.
  auto resource = mojo::gfx::composition::Resource::New();
  resource->set_mailbox_texture(
      mojo::gfx::composition::MailboxTextureResource::New());
  resource->get_mailbox_texture()->mailbox_name.resize(sizeof(mailbox));
  memcpy(resource->get_mailbox_texture()->mailbox_name.data(), mailbox,
         sizeof(mailbox));
  resource->get_mailbox_texture()->sync_point = sync_point;
  resource->get_mailbox_texture()->size = texture->size().Clone();
  resource->get_mailbox_texture()->callback =
      (new GLTextureReleaser(
           weak_factory_.GetWeakPtr(),
           GLRecycledTextureInfo(std::move(texture), sync_point)))
          ->StrongBind()
          .Pass();

  bound_textures_++;
  DVLOG(2) << "bind: bound_textures=" << bound_textures_;
  return resource;
}

mojo::gfx::composition::ResourcePtr GLRenderer::DrawGL(
    const mojo::Size& size,
    bool with_depth,
    const DrawGLCallback& callback) {
  std::unique_ptr<mojo::GLTexture> texture = GetTexture(size);
  DCHECK(texture);

  GLuint fbo = 0u;
  glGenFramebuffers(1, &fbo);
  glBindFramebuffer(GL_FRAMEBUFFER, fbo);
  glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D,
                         texture->texture_id(), 0);

  GLuint depth_buffer = 0u;
  if (with_depth) {
    glGenRenderbuffers(1, &depth_buffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depth_buffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, size.width,
                          size.height);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT,
                              GL_RENDERBUFFER, depth_buffer);
  }

  DCHECK_EQ(static_cast<GLenum>(GL_FRAMEBUFFER_COMPLETE),
            glCheckFramebufferStatus(GL_FRAMEBUFFER));

  glViewport(0, 0, size.width, size.height);
  callback.Run();

  if (with_depth)
    glDeleteRenderbuffers(1, &depth_buffer);
  glDeleteFramebuffers(1, &fbo);

  return BindTextureResource(std::move(texture));
}

void GLRenderer::ReleaseTexture(GLRecycledTextureInfo texture_info,
                                bool recyclable) {
  DCHECK(bound_textures_);
  bound_textures_--;
  if (recyclable && recycled_textures_.size() < max_recycled_textures_) {
    recycled_textures_.emplace_back(std::move(texture_info));
  }
  DVLOG(2) << "release: bound_textures=" << bound_textures_
           << ", recycled_textures=" << recycled_textures_.size();
}

GLRenderer::GLTextureReleaser::GLTextureReleaser(
    const base::WeakPtr<GLRenderer>& provider,
    GLRecycledTextureInfo info)
    : provider_(provider), texture_info_(std::move(info)), binding_(this) {}

GLRenderer::GLTextureReleaser::~GLTextureReleaser() {
  // It's possible for the object to be destroyed due to a connection
  // error on the callback pipe.  When this happens we don't want to
  // recycle the texture since we have too little knowledge about its
  // state to confirm that it will be safe to do so.
  Release(false /*recyclable*/);
}

mojo::gfx::composition::MailboxTextureCallbackPtr
GLRenderer::GLTextureReleaser::StrongBind() {
  mojo::gfx::composition::MailboxTextureCallbackPtr callback;
  binding_.Bind(mojo::GetProxy(&callback));
  return callback;
}

void GLRenderer::GLTextureReleaser::OnMailboxTextureReleased() {
  Release(true /*recyclable*/);
}

void GLRenderer::GLTextureReleaser::Release(bool recyclable) {
  if (provider_) {
    provider_->ReleaseTexture(std::move(texture_info_), recyclable);
    provider_.reset();
  }
}

}  // namespace ui
}  // namespace mojo
