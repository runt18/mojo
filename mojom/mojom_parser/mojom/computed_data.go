// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

// ComputeEnumValueIntegers() should be invoked after Resolve() has completed
// successfully. It computes |ComputedIntValue| field of all EnumValues.
func (d *MojomDescriptor) ComputeEnumValueIntegers() error {
	// TODO(rudominer) Implement ComputeEnumValueIntegers().
	return nil
}

// ComputeDataForGenerators() should be invoked after Resolve() has completed
// successfully. It computes the field packing and version data that will
// be used by the code generators.
func (d *MojomDescriptor) ComputeDataForGenerators() error {
	// TODO(rudominer) Implement ComputeDataForGenerators().
	return nil
}
