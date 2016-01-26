// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_GL_RENDERER_H_
#define MOJO_UI_GL_RENDERER_H_

#include <deque>
#include <memory>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/services/gfx/composition/interfaces/resources.mojom.h"

namespace mojo {

class GLContext;
class GLTexture;
class Size;

namespace ui {

// Provides support for rendering GL commands into a pool of textures
// and producing scene resources for them.
class GLRenderer {
 public:
  // Called with an active GL context to draw into the framebuffer.
  using DrawGLCallback = base::Closure;

  GLRenderer(base::WeakPtr<mojo::GLContext> gl_context,
             uint32_t max_recycled_textures = 3u);
  ~GLRenderer();

  // Gets the GL context, or null if none.
  const base::WeakPtr<mojo::GLContext>& gl_context() const {
    return gl_context_;
  }

  // Obtains a texture of the specified size.
  // Returns a nullptr if the GLContext was destroyed.
  std::unique_ptr<mojo::GLTexture> GetTexture(const mojo::Size& requested_size);

  // Takes ownership of the specified texture, issues GL commands to
  // produce a mailbox texture, and returns its resource pointer.
  // The caller should add the resource to its scene.
  // Returns a nullptr if the GLContext was destroyed.
  mojo::gfx::composition::ResourcePtr BindTextureResource(
      std::unique_ptr<GLTexture> texture);

  // Allocates a GL texture, binds it to a framebuffer, invokes the
  // provided function, then returns the resulting resource.
  // If |with_depth| is true, provides a depth buffer attachment.
  mojo::gfx::composition::ResourcePtr DrawGL(const mojo::Size& size,
                                             bool with_depth,
                                             const DrawGLCallback& callback);

 private:
  using GLRecycledTextureInfo =
      std::pair<std::unique_ptr<mojo::GLTexture>, uint32_t>;

  // TODO(jeffbrown): Avoid creating new callbacks each time, perhaps by
  // migrating to image pipes.
  class GLTextureReleaser : mojo::gfx::composition::MailboxTextureCallback {
   public:
    GLTextureReleaser(const base::WeakPtr<GLRenderer>& provider,
                      GLRecycledTextureInfo info);
    ~GLTextureReleaser() override;

    mojo::gfx::composition::MailboxTextureCallbackPtr StrongBind();

   private:
    void OnMailboxTextureReleased() override;
    void Release(bool recyclable);

    base::WeakPtr<GLRenderer> provider_;
    GLRecycledTextureInfo texture_info_;
    mojo::StrongBinding<mojo::gfx::composition::MailboxTextureCallback>
        binding_;
  };

  void ReleaseTexture(GLRecycledTextureInfo texture_info, bool recyclable);

  const base::WeakPtr<mojo::GLContext> gl_context_;
  const uint32_t max_recycled_textures_;

  std::deque<GLRecycledTextureInfo> recycled_textures_;
  uint32_t bound_textures_ = 0u;

  base::WeakPtrFactory<mojo::ui::GLRenderer> weak_factory_;

  DISALLOW_COPY_AND_ASSIGN(GLRenderer);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_GL_RENDERER_H_
