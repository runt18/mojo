// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package parser

import "testing"

// TODO(rudominer) This dummy test is here in order to be able to test the
// go unit test infrastructure. It will eventually be replaced by a real test.
func TestDummyParserTest(t *testing.T) {
	if 5.1 > 2.1*3.1 {
		t.Fatalf("Something is wrong.")
	}
}
