// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/message_loop/message_loop.h"
#include "mojo/gpu/gl_context.h"
#include "mojo/gpu/gl_texture.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_test_base.h"
#include "mojo/services/geometry/interfaces/geometry.mojom.h"
#include "mojo/services/gfx/composition/interfaces/resources.mojom.h"
#include "mojo/ui/gl_renderer.h"
#include "testing/gtest/include/gtest/gtest.h"

namespace {

static const base::TimeDelta kDefaultMessageDelay =
    base::TimeDelta::FromMilliseconds(20);

class GLRendererTest : public mojo::test::ApplicationTestBase {
 public:
  GLRendererTest() : weak_factory_(this) {}
  ~GLRendererTest() override {}

  void SetUp() override {
    mojo::test::ApplicationTestBase::SetUp();
    gl_context_ = mojo::GLContext::CreateOffscreen(
        mojo::MakeProxy(application_impl()->CreateApplicationConnector())
            .get());
    quit_message_loop_callback_ = base::Bind(
        &GLRendererTest::QuitMessageLoopCallback, weak_factory_.GetWeakPtr());
  }

  void QuitMessageLoopCallback() { base::MessageLoop::current()->Quit(); }

  void KickMessageLoop() {
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE, quit_message_loop_callback_, kDefaultMessageDelay);
    base::MessageLoop::current()->Run();
  }

 protected:
  base::WeakPtr<mojo::GLContext> gl_context_;
  base::Closure quit_message_loop_callback_;
  base::WeakPtrFactory<GLRendererTest> weak_factory_;

 private:
  DISALLOW_COPY_AND_ASSIGN(GLRendererTest);
};

TEST_F(GLRendererTest, GetTextureOnce) {
  mojo::ui::GLRenderer renderer(gl_context_);
  mojo::Size size;
  size.width = 100;
  size.height = 100;

  std::unique_ptr<mojo::GLTexture> texture = renderer.GetTexture(size);
  EXPECT_NE(texture.get(), nullptr);

  mojo::gfx::composition::ResourcePtr resource =
      renderer.BindTextureResource(std::move(texture));
  EXPECT_NE(resource.get(), nullptr);
  EXPECT_NE(resource->get_mailbox_texture().get(), nullptr);
  EXPECT_FALSE(resource->get_mailbox_texture()->mailbox_name.is_null());
  EXPECT_TRUE(resource->get_mailbox_texture()->size->Equals(size));
  EXPECT_NE(resource->get_mailbox_texture()->sync_point, 0u);
  EXPECT_NE(resource->get_mailbox_texture()->callback.get(), nullptr);
}

TEST_F(GLRendererTest, GetTextureTwiceSameSize) {
  mojo::ui::GLRenderer renderer(gl_context_);
  mojo::Size size;
  size.width = 100;
  size.height = 100;

  std::unique_ptr<mojo::GLTexture> texture1 = renderer.GetTexture(size);
  EXPECT_NE(texture1.get(), nullptr);

  std::unique_ptr<mojo::GLTexture> texture2 = renderer.GetTexture(size);
  EXPECT_NE(texture2.get(), nullptr);

  EXPECT_NE(texture2.get(), texture1.get());
  EXPECT_NE(texture2->texture_id(), texture1->texture_id());

  mojo::gfx::composition::ResourcePtr resource1 =
      renderer.BindTextureResource(std::move(texture1));
  EXPECT_NE(resource1.get(), nullptr);
  EXPECT_NE(resource1->get_mailbox_texture().get(), nullptr);
  EXPECT_FALSE(resource1->get_mailbox_texture()->mailbox_name.is_null());
  EXPECT_TRUE(resource1->get_mailbox_texture()->size->Equals(size));
  EXPECT_NE(resource1->get_mailbox_texture()->sync_point, 0u);
  EXPECT_NE(resource1->get_mailbox_texture()->callback.get(), nullptr);

  mojo::gfx::composition::ResourcePtr resource2 =
      renderer.BindTextureResource(std::move(texture2));
  EXPECT_NE(resource2.get(), nullptr);
  EXPECT_NE(resource2->get_mailbox_texture().get(), nullptr);
  EXPECT_FALSE(resource2->get_mailbox_texture()->mailbox_name.is_null());
  EXPECT_TRUE(resource2->get_mailbox_texture()->size->Equals(size));
  EXPECT_NE(resource2->get_mailbox_texture()->sync_point, 0u);
  EXPECT_NE(resource2->get_mailbox_texture()->callback.get(), nullptr);

  EXPECT_NE(resource2->get_mailbox_texture()->sync_point,
            resource1->get_mailbox_texture()->sync_point);
}

TEST_F(GLRendererTest, GetTextureAfterRecycleSameSize) {
  mojo::ui::GLRenderer renderer(gl_context_);
  mojo::Size size;
  size.width = 100;
  size.height = 100;

  std::unique_ptr<mojo::GLTexture> texture1 = renderer.GetTexture(size);
  EXPECT_NE(texture1.get(), nullptr);
  mojo::GLTexture* original_texture = texture1.get();

  // Return the texture.
  mojo::gfx::composition::ResourcePtr resource1 =
      renderer.BindTextureResource(std::move(texture1));
  EXPECT_NE(resource1.get(), nullptr);
  resource1->get_mailbox_texture()->callback->OnMailboxTextureReleased();

  KickMessageLoop();

  // Get a texture of the same size, it should be the same one as before.
  std::unique_ptr<mojo::GLTexture> texture2 = renderer.GetTexture(size);
  EXPECT_EQ(texture2.get(), original_texture);
}

TEST_F(GLRendererTest, GetTextureAfterRecycleDifferentSize) {
  mojo::ui::GLRenderer renderer(gl_context_);
  mojo::Size size1;
  size1.width = 100;
  size1.height = 100;
  std::unique_ptr<mojo::GLTexture> texture1 = renderer.GetTexture(size1);
  EXPECT_NE(texture1.get(), nullptr);
  EXPECT_TRUE(texture1->size().Equals(size1));

  // Return the texture.
  mojo::gfx::composition::ResourcePtr resource1 =
      renderer.BindTextureResource(std::move(texture1));
  EXPECT_NE(resource1.get(), nullptr);
  resource1->get_mailbox_texture()->callback->OnMailboxTextureReleased();

  KickMessageLoop();

  // Get a texture of the a different size, it should be a new one
  // with the new size.
  mojo::Size size2;
  size2.width = size1.width - 1;
  size2.height = size1.height - 1;
  std::unique_ptr<mojo::GLTexture> texture2 = renderer.GetTexture(size2);
  EXPECT_NE(texture2.get(), nullptr);
  EXPECT_TRUE(texture2->size().Equals(size2));
}

TEST_F(GLRendererTest, GetTextureReleasedGlContext) {
  gl_context_->Destroy();

  mojo::ui::GLRenderer renderer(gl_context_);
  mojo::Size size;
  size.width = 100;
  size.height = 100;

  std::unique_ptr<mojo::GLTexture> texture = renderer.GetTexture(size);
  EXPECT_EQ(texture.get(), nullptr);
}

TEST_F(GLRendererTest, BindTextureResourceReleasedGlContext) {
  mojo::ui::GLRenderer renderer(gl_context_);
  mojo::Size size;
  size.width = 100;
  size.height = 100;

  std::unique_ptr<mojo::GLTexture> texture = renderer.GetTexture(size);
  EXPECT_NE(texture.get(), nullptr);

  gl_context_->Destroy();

  mojo::gfx::composition::ResourcePtr resource =
      renderer.BindTextureResource(std::move(texture));
  EXPECT_EQ(resource.get(), nullptr);
}

TEST_F(GLRendererTest, RecycledAfterReleasedGlContext) {
  mojo::ui::GLRenderer renderer(gl_context_);
  mojo::Size size;
  size.width = 100;
  size.height = 100;

  std::unique_ptr<mojo::GLTexture> texture1 = renderer.GetTexture(size);
  EXPECT_NE(texture1.get(), nullptr);

  mojo::gfx::composition::ResourcePtr resource1 =
      renderer.BindTextureResource(std::move(texture1));
  EXPECT_NE(resource1.get(), nullptr);

  gl_context_->Destroy();
  resource1->get_mailbox_texture()->callback->OnMailboxTextureReleased();

  KickMessageLoop();

  // Get a texture of the same size, should be null due to the released context.
  std::unique_ptr<mojo::GLTexture> texture2 = renderer.GetTexture(size);
  EXPECT_EQ(texture2.get(), nullptr);
}

}  // namespace
