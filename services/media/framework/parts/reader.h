// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_PARTS_READER_H_
#define SERVICES_MEDIA_FRAMEWORK_PARTS_READER_H_

#include <memory>

#include "services/media/framework/result.h"
#include "url/gurl.h"

namespace mojo {
namespace media {

class Reader;

typedef std::shared_ptr<Reader> ReaderPtr;

// Abstract base class for objects that read raw data on behalf of demuxes.
// This model is synchronous, because that's how ffmpeg works.
class Reader {
 public:
  // Creates a Reader object for a given url.
  static Result Create(const GURL& gurl, ReaderPtr* reader_out);

  virtual ~Reader() {}

  // Initializes the reader.
  virtual Result Init(const GURL& gurl) = 0;

  // Reads the given number of bytes into the buffer and returns the number of
  // bytes read. Returns -1 if the operation fails.
  virtual size_t Read(uint8* buffer, int bytes_to_read) = 0;

  // Gets the current position or -1 if the operation fails.
  virtual int64_t GetPosition() const = 0;

  // Seeks to the given position and returns it. Returns -1 if the operation
  // fails.
  virtual int64_t SetPosition(int64 position) = 0;

  // Returns the file size. Returns -1 if the operation fails or the size isn't
  // known.
  virtual size_t GetSize() const = 0;

  // Returns true if this object supports seeking, false otherwise.
  virtual bool CanSeek() const = 0;
};

}  // namespace media
}  // namespace mojo

#endif // MOJO_SERVICES_MEDIA_READER_H_
