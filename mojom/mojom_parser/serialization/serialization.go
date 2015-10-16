// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package serialization

import (
	"mojom/mojom_parser/mojom"
)

//////////////////////////////////////////////////
/// Mojom Descriptor Serialization
//////////////////////////////////////////////////

// Serializes the MojomDescriptor into a binary form that is passed to the
// backend of the compiler in order to invoke the code generators.
// To do this we use Mojo serialization.
func Serialize(d *mojom.MojomDescriptor) (bytes []byte, err error) {
	// TODO(rudominer) This is a stub. It will be implemented in a later
	// CL.
	bytes = []byte("DummyOutput")
	return
}
