// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package parser

import (
	"mojom/mojom_parser/mojom"
	"reflect"
	"testing"
)

// FakeFileProvider implements FileProvider.
type FakeFileProvider struct {
	// This field records the names of the files whose contents were requested.
	requestedFileNames []string
}

// FakeFileProvider implements provideContents by recording the name of the file
// whose contents are being requested.
func (f *FakeFileProvider) provideContents(fileRef *FileReference) (contents string, fileReadError error) {
	f.requestedFileNames = append(f.requestedFileNames, fileRef.specifiedPath)
	return "", nil
}

// FakeFileProvider implements findFile by always succeeding to find the
// file and reporting that the |specifiedPath| is the |absolutePath|.
func (f *FakeFileProvider) findFile(fileRef *FileReference) error {
	fileRef.absolutePath = fileRef.specifiedPath
	return nil
}

// FakeFileExtractor implements FileExtractor
type FakeFileExtractor struct {
	// This field maps a file name to the set of import names that we want to
	// simulate the given file is importing.
	importNames map[string][]string
}

func makeFakeFileExtractor() FakeFileExtractor {
	extractor := FakeFileExtractor{}
	extractor.importNames = make(map[string][]string)
	return extractor
}

// Invoke this method to specify that FakeFileExtractor should simulate the fact
// that the file named |fileName| imports the files specified by |imports|.
func (f *FakeFileExtractor) appendImportsToFile(fileName string, imports ...string) {
	if imports != nil {
		f.importNames[fileName] = append(f.importNames[fileName], imports...)
	}
}

// FakeFileExtractor implements extractMojomFile() by returning an instance
// of MojomFile that has had imports added to it according to the values
// in the map |importNames|.
func (f *FakeFileExtractor) extractMojomFile(parser *Parser) *mojom.MojomFile {
	file := parser.GetMojomFile()
	for _, importName := range f.importNames[file.FileName] {
		file.AddImport(importName)
	}
	return file
}

// TestExpectedFilesParsed tests the logic in function ParseDriver.ParseFiles()
// for determining which files should be parsed.
func TestExpectedFilesParsed(t *testing.T) {
	// Construct our fake objects.
	fakeFileProvider := FakeFileProvider{}
	fakeFileExtractor := makeFakeFileExtractor()
	// Our fake file1 will import file3, file4, file5
	fakeFileExtractor.appendImportsToFile("file1", "file3", "file4", "file5")
	// Our fake file5 will import file1 and file5
	fakeFileExtractor.appendImportsToFile("file5", "file1", "file6")

	// Construct the driver under test
	driver := newDriver([]string{}, false, &fakeFileProvider, &fakeFileExtractor)

	// Invoke ParseFiles
	driver.ParseFiles([]string{"file1", "file2", "file3"})

	// Check that the correct files had their contents requested in the expected order.
	expectedFileRefs := []string{"file1", "file2", "file3", "file4", "file5", "file6"}
	if !reflect.DeepEqual(expectedFileRefs, fakeFileProvider.requestedFileNames) {
		t.Errorf("%v != %v", expectedFileRefs, fakeFileProvider.requestedFileNames)
	}
}
