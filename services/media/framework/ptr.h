// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_PTR_H_
#define SERVICES_MEDIA_FRAMEWORK_PTR_H_

#include <memory>

namespace mojo {
namespace media {

// unique_ptr with Clone.
// TODO(dalesat): Remove in favor of unique_ptr and a Clone template function.
template<class T, class Deleter = std::default_delete<T>>
class UniquePtr : public std::unique_ptr<T, Deleter> {
 public:
  UniquePtr() : std::unique_ptr<T, Deleter>() {}

  UniquePtr(std::nullptr_t) : std::unique_ptr<T, Deleter>() {}

  explicit UniquePtr(T* ptr) : std::unique_ptr<T, Deleter>(ptr) {}

  UniquePtr(UniquePtr&& other) :
      std::unique_ptr<T, Deleter>(std::move(other)) {}

  UniquePtr& operator=(std::nullptr_t) {
    this->reset();
    return *this;
  }

  UniquePtr& operator=(UniquePtr&& other) {
    *static_cast<std::unique_ptr<T, Deleter>*>(this) = std::move(other);
    return *this;
  }

  UniquePtr Clone() const { return *this ? this->get()->Clone() : UniquePtr(); }
};

// shared_ptr with upcast to TBase.
// TODO(dalesat): Remove in favor of shared_ptr.
template<class T, typename TBase>
class SharedPtr : public std::shared_ptr<T> {
 public:
  SharedPtr() : std::shared_ptr<T>() {}

  SharedPtr(std::nullptr_t) : std::shared_ptr<T>() {}

  explicit SharedPtr(T* ptr) : std::shared_ptr<T>(ptr) {}

  SharedPtr& operator=(std::nullptr_t) {
    this->reset();
    return *this;
  }

  operator std::shared_ptr<TBase>() const {
    return std::shared_ptr<TBase>(*this, this->get());
  }
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_PTR_H_
