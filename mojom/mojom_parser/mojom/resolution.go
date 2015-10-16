// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

/////////////////////////////////////////
/// Type and Value Resolution
////////////////////////////////////////

// Resolve() should be invoked after all of the parsing has been done. It
// attempts to resolve all of the entries in |d.unresolvedTypeReferences| and
// |d.unresolvedValueReferences|. Returns a non-nil error if there are any
// remaining unresolved references or if after resolution it was discovered
// that a type or value was used in an inappropriate way.
func (d *MojomDescriptor) Resolve() error {
	// TODO(rudominer) This is a stub. It will be implemented in a later CL.
	return nil
}
