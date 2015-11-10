// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package serialization

import (
	"fmt"
	"mojo/public/go/bindings"
	"mojom/mojom_parser/generated/mojom_files"
	"mojom/mojom_parser/generated/mojom_types"
	"mojom/mojom_parser/mojom"
	"mojom/mojom_parser/parser"
	"reflect"
	"testing"
	myfmt "third_party/golang/src/fmt"
)

// singleFileTestCase stores the data for one serialization test case
// in which only a single file is added to the file graph.
type singleFileTestCase struct {
	fileName             string
	mojomContents        string
	lineAndcolumnNumbers bool
	expectedFile         *mojom_files.MojomFile
	expectedGraph        *mojom_files.MojomFileGraph
}

// singleFileTest contains a series of singleFileTestCase and a current
// testCaseNum.
type singleFileTest struct {
	cases       []singleFileTestCase
	testCaseNum int
}

// expectedFile() returns the expectedFile of the current test case.
func (t *singleFileTest) expectedFile() *mojom_files.MojomFile {
	return t.cases[t.testCaseNum].expectedFile
}

// expectedGraph() returns the expectedGraph of the current test case.
func (t *singleFileTest) expectedGraph() *mojom_files.MojomFileGraph {
	return t.cases[t.testCaseNum].expectedGraph
}

// fileName() returns the fileName of the current test case
func (t *singleFileTest) fileName() string {
	return t.cases[t.testCaseNum].fileName
}

// addTestCase() should be invoked at the start of a case in
// TestSingleFileSerialization.
func (test *singleFileTest) addTestCase(moduleNameSpace, contents string) {
	fileName := fmt.Sprintf("file%d", test.testCaseNum)
	test.cases = append(test.cases, singleFileTestCase{fileName, contents, false,
		new(mojom_files.MojomFile), new(mojom_files.MojomFileGraph)})

	test.expectedFile().FileName = fileName
	test.expectedFile().ModuleNamespace = newString(moduleNameSpace)

	test.expectedGraph().ResolvedTypes = make(map[string]mojom_types.UserDefinedType)
	test.expectedGraph().ResolvedValues = make(map[string]mojom_types.UserDefinedValue)
}

// endTestCase() should be invoked at the end of a case in
// TestSingleFileSerialization.
func (test *singleFileTest) endTestCase() {
	test.expectedGraph().Files = make(map[string]mojom_files.MojomFile)
	test.expectedGraph().Files[test.fileName()] = *test.expectedFile()
	test.testCaseNum += 1
}

// newDeclData constructs a new DeclarationData with the given data.
func (test *singleFileTest) newDeclData(shortName, fullIdentifier string) *mojom_types.DeclarationData {
	return &mojom_types.DeclarationData{
		ShortName:        newString(shortName),
		FullIdentifier:   newString(fullIdentifier),
		DeclaredOrdinal:  -1,
		DeclarationOrder: -1,
		SourceFileInfo: &mojom_types.SourceFileInfo{
			FileName: test.fileName(),
		}}
}

// TestSingleFileSerialization uses a series of test cases in which the text of a .mojom
// file is specified and the expected MojomFileGraph is specified using Go struct literals.
func TestSingleFileSerialization(t *testing.T) {
	test := singleFileTest{}

	////////////////////////////////////////////////////////////
	// Test Case
	////////////////////////////////////////////////////////////
	{

		contents := `
	[go_namespace="go.test",
	lucky=true,
	planet=EARTH]
	module mojom.test;

	import "another.file";
	import "and.another.file";

	const uint16 NUM_MAGI = 3;

	struct Foo{
		int32 x;
		string y = "hello";
		string? z;

		enum Hats {
			TOP,
			COWBOY = NUM_MAGI
		};
	};`

		test.addTestCase("mojom.test", contents)

		// Attributes
		test.expectedFile().Attributes = &[]mojom_types.Attribute{
			{"go_namespace", "go.test"}, {"lucky", "true"}, {"planet", "EARTH"},
		}

		// Imports
		test.expectedFile().Imports = &[]string{
			"another.file.canonical", "and.another.file.canonical",
		}

		// DeclaredMojomObjects
		test.expectedFile().DeclaredMojomObjects.Structs = &[]string{"TYPE_KEY:mojom.test.Foo"}
		test.expectedFile().DeclaredMojomObjects.TopLevelConstants = &[]string{"TYPE_KEY:mojom.test.NUM_MAGI"}

		// Resolved Values

		// NUM_MAGI
		test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.NUM_MAGI"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("NUM_MAGI", "mojom.test.NUM_MAGI"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_UinT16},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueInt64Value{3}},
		}}

		// Hats.TOP
		test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.TOP"] = &mojom_types.UserDefinedValueEnumValue{mojom_types.EnumValue{
			DeclData:    test.newDeclData("TOP", "mojom.test.Foo.Hats.TOP"),
			EnumTypeKey: "TYPE_KEY:mojom.test.Foo.Hats",
			IntValue:    -1,
		}}

		// Hats.COWBOY
		test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.COWBOY"] = &mojom_types.UserDefinedValueEnumValue{mojom_types.EnumValue{
			DeclData:    test.newDeclData("COWBOY", "mojom.test.Foo.Hats.COWBOY"),
			EnumTypeKey: "TYPE_KEY:mojom.test.Foo.Hats",
			IntValue:    3,
			InitializerValue: &mojom_types.ValueUserValueReference{mojom_types.UserValueReference{
				Identifier:            "NUM_MAGI",
				ValueKey:              newString("TYPE_KEY:mojom.test.NUM_MAGI"),
				ResolvedConcreteValue: &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueInt64Value{3}},
			}},
		}}

		// ResolvedTypes

		// struct Foo
		test.expectedGraph().ResolvedTypes["TYPE_KEY:mojom.test.Foo"] = &mojom_types.UserDefinedTypeStructType{mojom_types.MojomStruct{
			DeclData: &mojom_types.DeclarationData{
				ShortName:        newString("Foo"),
				FullIdentifier:   newString("mojom.test.Foo"),
				DeclaredOrdinal:  -1,
				DeclarationOrder: -1,
				SourceFileInfo: &mojom_types.SourceFileInfo{
					FileName: test.fileName(),
				},
				ContainedDeclarations: &mojom_types.ContainedDeclarations{
					Enums: &[]string{"TYPE_KEY:mojom.test.Foo.Hats"}},
			},
			Fields: []mojom_types.StructField{
				// field x
				{
					DeclData: test.newDeclData("x", ""),
					Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32},
				},
				// field y
				{
					DeclData:     test.newDeclData("y", ""),
					Type:         &mojom_types.TypeStringType{mojom_types.StringType{false}},
					DefaultValue: &mojom_types.DefaultFieldValueValue{&mojom_types.ValueLiteralValue{&mojom_types.LiteralValueStringValue{"hello"}}},
				},
				// field z
				{
					DeclData: test.newDeclData("z", ""),
					Type:     &mojom_types.TypeStringType{mojom_types.StringType{true}},
				},
			},
		}}

		// enum Hats
		test.expectedGraph().ResolvedTypes["TYPE_KEY:mojom.test.Foo.Hats"] = &mojom_types.UserDefinedTypeEnumType{mojom_types.MojomEnum{
			DeclData: test.newDeclData("Hats", "mojom.test.Foo.Hats"),
			Values: []mojom_types.EnumValue{
				// Note(rudominer) It is a bug that we need to copy the enum values here.
				// See https://github.com/domokit/mojo/issues/513.
				// value TOP
				test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.TOP"].(*mojom_types.UserDefinedValueEnumValue).Value,
				// value COWBOY
				test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.COWBOY"].(*mojom_types.UserDefinedValueEnumValue).Value,
			},
		}}

		test.endTestCase()
	}

	////////////////////////////////////////////////////////////
	// Execute all of the test cases.
	////////////////////////////////////////////////////////////
	for _, c := range test.cases {
		// Parse and resolve the mojom input.
		descriptor := mojom.NewMojomDescriptor()
		parser := parser.MakeParser(c.fileName, c.mojomContents, descriptor)
		parser.Parse()
		if !parser.OK() {
			t.Errorf("Parsing error for %s: %s", c.fileName, parser.GetError().Error())
			continue
		}
		if err := descriptor.Resolve(); err != nil {
			t.Errorf("Resolve error for %s: %s", c.fileName, err.Error())
			continue
		}
		if err := descriptor.ComputeEnumValueIntegers(); err != nil {
			t.Errorf("ComputeEnumValueIntegers error for %s: %s", c.fileName, err.Error())
			continue
		}
		if err := descriptor.ComputeDataForGenerators(); err != nil {
			t.Errorf("ComputeDataForGenerators error for %s: %s", c.fileName, err.Error())
			continue
		}

		// Simulate setting the canonical file name for the imported files. In real operation
		// this step is done in parser_driver.go when each of the imported files are parsed.
		mojomFile := parser.GetMojomFile()
		if mojomFile.Imports != nil {
			for _, imp := range mojomFile.Imports {
				imp.CanonicalFileName = fmt.Sprintf("%s.canonical", imp.SpecifiedName)
			}
		}

		// Serialize
		EmitLineAndColumnNumbers = c.lineAndcolumnNumbers
		bytes, err := Serialize(descriptor)
		if err != nil {
			t.Errorf("Serialization error for %s: %s", c.fileName, err.Error())
			continue
		}

		// Deserialize
		decoder := bindings.NewDecoder(bytes, nil)
		fileGraph := mojom_files.MojomFileGraph{}
		fileGraph.Decode(decoder)

		// Compare
		if err := compareFileGraphs(c.expectedGraph, &fileGraph); err != nil {
			t.Errorf("%s:\n%s", c.fileName, err.Error())
			continue
		}
	}
}

// compareFileGraphs compares |expected| and |actual| and returns a non-nil
// error if they are not deeply equal. The error message contains a human-readable
// string containing a deep-print of expected and actual along with the substrings
// starting from the first character where they differ.
func compareFileGraphs(expected *mojom_files.MojomFileGraph, actual *mojom_files.MojomFileGraph) error {
	if !reflect.DeepEqual(expected, actual) {
		// Note(rudominer) The myfmt package is a local modification of the fmt package
		// that does a deep printing that follows pointers for up to 50 levels.
		// Thus expectedString and actualString should contain enough information to
		// precisely capture the structure of expected and actual.
		expectedString := myfmt.Sprintf("%+v", expected)
		actualString := myfmt.Sprintf("%+v", actual)
		if expectedString != actualString {
			diffPos := -1
			for i := 0; i < len(expectedString) && i < len(actualString); i++ {
				if expectedString[i] != actualString[i] {
					diffPos = i
					break
				}
			}
			mismatchExpected := ""
			mismatchActual := ""
			if diffPos > -1 {
				mismatchExpected = expectedString[diffPos:]
				mismatchActual = actualString[diffPos:]
			}
			return fmt.Errorf("*****\nexpected=\n*****\n%q\n*****\nactual=\n*****\n%q\n*****\n"+
				"match failed at position %d: expected=\n*****\n%s\n******\nactual=\n*****\n%s\n******\n",
				expectedString, actualString, diffPos, mismatchExpected, mismatchActual)
		} else {
			return fmt.Errorf("expected != actual but the two printed equal.")
		}
	}
	return nil
}
