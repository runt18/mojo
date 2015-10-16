// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"fmt"
)

// This file contains the types MojomFile and MojomDescriptor. These are the
// structures that are generated during parsing and then serialized and
// passed on to the backend of the Mojom Compiler.

///////////////////////////////////////////////////////////////////////
/// Type MojomFile
/// //////////////////////////////////////////////////////////////////

// A MojomFile represents the result of parsing a single .mojom file.
type MojomFile struct {
	// The associated MojomDescriptor
	Descriptor *MojomDescriptor

	// The |FileName| is (derived from) the file name of the corresponding
	// .mojom file. It is the unique identifier for this module within the
	// |mojomFilesByName| field of |Descriptor|
	FileName string

	// The list of other MojomFiles imported by this one. The elements
	// of the array are the |FileName|s. The corresponding MojomFile may
	// be obtained from the |mojomFilesByName| field of |Descriptor|.
	Imports []string

	// TODO(rudominer) This struct is a stub. It will be fully implemented in a later CL.
}

func NewMojomFile(fileName string, descriptor *MojomDescriptor) *MojomFile {
	mojomFile := new(MojomFile)
	mojomFile.FileName = fileName
	mojomFile.Descriptor = descriptor
	mojomFile.Imports = make([]string, 0)

	// TODO(rudominer) This method is a stub. It will be fully implemented in a later CL.
	return mojomFile
}

func (f *MojomFile) String() string {
	// TODO(rudominer) This will be implemented in a later CL.
	return "MojomFile"
}

func (f *MojomFile) AddImport(fileName string) {
	f.Imports = append(f.Imports, fileName)
}

//////////////////////////////////////////////////////////////////
/// type MojomDescriptor
/// //////////////////////////////////////////////////////////////

// A MojomDescriptor is the central object being populated by the frontend of
// the Mojom compiler. The same instance of MojomDescriptor is passed to each
// of the instances of Parser that are created by the ParseDriver while parsing
// a graph of Mojom files.  The output of ParserDriver.ParseFiles() is a
// ParseResult the main field of which is a MojomDescriptor. The MojomDescriptor
// is then serialized and passed to the backend of the Mojom compiler.
type MojomDescriptor struct {

	// All of the MojomFiles in the order they were visited.
	mojomFiles []*MojomFile

	// All of the MojomFiles keyed by FileName
	mojomFilesByName map[string]*MojomFile

	// TODO(rudominer) This struct is a stub. It will be fully implemented in a later CL.
}

func NewMojomDescriptor() *MojomDescriptor {
	descriptor := new(MojomDescriptor)

	descriptor.mojomFiles = make([]*MojomFile, 0)
	descriptor.mojomFilesByName = make(map[string]*MojomFile)

	// TODO(rudominer) This method is a stub. It will be fully implemented in a later CL.

	return descriptor
}

func (d *MojomDescriptor) AddMojomFile(fileName string) *MojomFile {
	mojomFile := NewMojomFile(fileName, d)
	mojomFile.Descriptor = d
	d.mojomFiles = append(d.mojomFiles, mojomFile)
	if _, ok := d.mojomFilesByName[mojomFile.FileName]; ok {
		panic(fmt.Sprintf("The file %v has already been processed.", mojomFile.FileName))
	}
	d.mojomFilesByName[mojomFile.FileName] = mojomFile
	return mojomFile
}

func (d *MojomDescriptor) ContainsFile(fileName string) bool {
	_, ok := d.mojomFilesByName[fileName]
	return ok
}

func (d *MojomDescriptor) String() string {
	// TODO(rudominer) This will be implemented in a later CL.
	return "MojomDescriptor"
}
