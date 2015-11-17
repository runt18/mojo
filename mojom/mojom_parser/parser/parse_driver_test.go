// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package parser

import (
	"mojom/mojom_parser/mojom"
	"os"
	"path/filepath"
	"reflect"
	"strings"
	"testing"
)

// FakeFileProvider implements FileProvider.
type FakeFileProvider struct {
	// This field records the names of the files whose contents were requested.
	requestedFileNames []string
}

// FakeFileProvider implements provideContents by recording the name of the file
// whose contents are being requested and then returning the empty string.
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

type NoOpParseInvoker int

func (NoOpParseInvoker) invokeParse(parser *Parser) {}

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
	for _, importName := range f.importNames[file.CanonicalFileName] {
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
	// Our fake file5 will import file1 and file6
	fakeFileExtractor.appendImportsToFile("file5", "file1", "file6")

	// Construct the driver under test
	driver := newDriver([]string{}, false, &fakeFileProvider, &fakeFileExtractor, NoOpParseInvoker(0))

	// Invoke ParseFiles
	driver.ParseFiles([]string{"file1", "file2", "file3"})

	// Check that the correct files had their contents requested in the expected order.
	expectedFileRefs := []string{"file1", "file2", "file3", "file4", "file5", "file6"}
	if !reflect.DeepEqual(expectedFileRefs, fakeFileProvider.requestedFileNames) {
		t.Errorf("%v != %v", expectedFileRefs, fakeFileProvider.requestedFileNames)
	}
}

// TestOSFileProvider tests the function OSFileProvider.findFiles() and OSFileProvider.provideContents()
func TestOSFileProvider(t *testing.T) {
	// Top level files (not imported from anything) are found relative to the current directory.
	fileReferenceA := doOSFileProviderTest(t, "../test_data/a/testfile1", nil, nil, "mojom_parser/test_data/a")
	fileReferenceB := doOSFileProviderTest(t, "../test_data/b/testfile1", nil, nil, "mojom_parser/test_data/b")

	// A file imported from a file in directory 'a' should be found in directory 'a'
	doOSFileProviderTest(t, "testfile1", &fileReferenceA, nil, "mojom_parser/test_data/a")

	// A file imported from a file in directory 'b' should be found in directory 'a'
	doOSFileProviderTest(t, "testfile1", &fileReferenceB, nil, "mojom_parser/test_data/b")

	// A file imported from a file in directory 'a' should be found in directory 'b' if there is no file with the
	// specified name in directory 'a' and directory 'b' is in the search path.
	doOSFileProviderTest(t, "testfile2", &fileReferenceA, []string{"../test_data/b"}, "mojom_parser/test_data/b")

	// The file is imported from directory 'a' and directory 'b' is on the search path but there is no file with the
	// specified name in either directory and there is a file with the specified name in the current directory.
	// The file should be found in the current directory. Note that the last argument is a random string of digits that
	// we expect to find in the contents of the file parser_driver_test.go.
	doOSFileProviderTest(t, "parse_driver_test.go", &fileReferenceA, []string{"../test_data/b"}, "840274941330987490326243")
}

// doOSFileProviderTest is the workhorse for TestOSFileProvider.
func doOSFileProviderTest(t *testing.T, specifiedPath string, importedFrom *FileReference,
	globalImports []string, expectedContents string) FileReference {
	fileProvider := new(OSFileProvider)
	fileProvider.importDirs = globalImports
	fileReference := FileReference{specifiedPath: specifiedPath}
	fileReference.importedFrom = importedFrom

	// Invoke findFile()
	if err := fileProvider.findFile(&fileReference); err != nil {
		t.Fatalf(err.Error())
	}

	// Check that the absolutePath has been populated to the absolute path of a file.
	if fileReference.absolutePath == "" {
		t.Fatalf("absolutePath is not set for %s", fileReference.specifiedPath)
	}
	if !filepath.IsAbs(fileReference.absolutePath) {
		t.Fatalf("absolutePath is not absolute for %s: %s", fileReference.specifiedPath, fileReference.absolutePath)
	}
	info, err := os.Stat(fileReference.absolutePath)
	if err != nil {
		t.Fatalf("cannot stat absolutePath %s: %s", fileReference.absolutePath, err.Error())
	}
	if info.IsDir() {
		t.Fatalf("absolutePath refers to a directory: %s", fileReference.absolutePath)
	}

	// Check that the dirPath has been populated to the absolute path of a directory.
	if fileReference.directoryPath == "" {
		t.Fatalf("directoryPath is not set for %s", fileReference.specifiedPath)
	}
	if !filepath.IsAbs(fileReference.directoryPath) {
		t.Fatalf("directoryPath is not absolute for %s: %s", fileReference.specifiedPath, fileReference.directoryPath)
	}
	info, err = os.Stat(fileReference.directoryPath)
	if err != nil {
		t.Fatalf("cannot stat directoryPath %s: %s", fileReference.directoryPath, err.Error())
	}
	if !info.IsDir() {
		t.Fatalf("directoryPath does not refer to a directory: %s", fileReference.directoryPath)
	}
	if filepath.Dir(fileReference.absolutePath) != fileReference.directoryPath {
		t.Fatalf("wrong directoryPath expected parent of %s got %s", fileReference.absolutePath, fileReference.directoryPath)
	}

	contents, err := fileProvider.provideContents(&fileReference)
	if err != nil {
		t.Errorf("Error from provideContents for %v: %s", fileReference, err.Error())
	}
	if !strings.Contains(contents, expectedContents) {
		t.Errorf("Wrong file contents for %v. Expecting %s got %s.", fileReference, expectedContents, contents)
	}

	return fileReference
}
