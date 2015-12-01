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
	test.expectedFile().ModuleNamespace = &moduleNameSpace

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
	return test.newContainedDeclData(shortName, fullIdentifier, nil)
}

// newDeclDataA constructs a new DeclarationData with the given data, including attributes.
func (test *singleFileTest) newDeclDataA(shortName, fullIdentifier string,
	attributes *[]mojom_types.Attribute) *mojom_types.DeclarationData {
	return test.newContainedDeclDataA(shortName, fullIdentifier, nil, attributes)
}

// newContainedDeclData constructs a new DeclarationData with the given data.
func (test *singleFileTest) newContainedDeclData(shortName, fullIdentifier string, containerTypeKey *string) *mojom_types.DeclarationData {
	return test.newContainedDeclDataA(shortName, fullIdentifier, containerTypeKey, nil)
}

// newContainedDeclDataA constructs a new DeclarationData with the given data, including attributes.
func (test *singleFileTest) newContainedDeclDataA(shortName, fullIdentifier string,
	containerTypeKey *string, attributes *[]mojom_types.Attribute) *mojom_types.DeclarationData {
	return &mojom_types.DeclarationData{
		Attributes:       attributes,
		ShortName:        &shortName,
		FullIdentifier:   &fullIdentifier,
		DeclaredOrdinal:  -1,
		DeclarationOrder: -1,
		ContainerTypeKey: containerTypeKey,
		SourceFileInfo: &mojom_types.SourceFileInfo{
			FileName: test.fileName(),
		}}

}

// TestSingleFileSerialization uses a series of test cases in which the text of a .mojom
// file is specified and the expected MojomFileGraph is specified using Go struct literals.
func TestSingleFileSerialization(t *testing.T) {
	test := singleFileTest{}

	////////////////////////////////////////////////////////////
	// Test Case: array of int32
	////////////////////////////////////////////////////////////
	{

		contents := `
	struct Foo{
	  array<int32> bar1;
	  array<int32, 7> bar2;
	  array<int32>? bar3;
	  array<int32, 8>? bar4;
	};`

		test.addTestCase("", contents)

		// DeclaredMojomObjects
		test.expectedFile().DeclaredMojomObjects.Structs = &[]string{"TYPE_KEY:Foo"}

		// ResolvedTypes

		// struct Foo
		test.expectedGraph().ResolvedTypes["TYPE_KEY:Foo"] = &mojom_types.UserDefinedTypeStructType{mojom_types.MojomStruct{
			DeclData: test.newDeclData("Foo", "Foo"),
			Fields: []mojom_types.StructField{
				// field bar1 is not nullable and not fixed length
				{
					DeclData: test.newDeclData("bar1", ""),
					Type: &mojom_types.TypeArrayType{mojom_types.ArrayType{
						false, -1, &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32}}},
				},
				// field bar2 is not nullable and fixed length of 7
				{
					DeclData: test.newDeclData("bar2", ""),
					Type: &mojom_types.TypeArrayType{mojom_types.ArrayType{
						false, 7, &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32}}},
				},
				// field bar3 is nullable and not fixed length
				{
					DeclData: test.newDeclData("bar3", ""),
					Type: &mojom_types.TypeArrayType{mojom_types.ArrayType{
						true, -1, &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32}}},
				},
				// field bar4 is nullable and fixed length of 8
				{
					DeclData: test.newDeclData("bar4", ""),
					Type: &mojom_types.TypeArrayType{mojom_types.ArrayType{
						true, 8, &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32}}},
				},
			},
		}}

		test.endTestCase()
	}

	////////////////////////////////////////////////////////////
	// Test Case: map string to int32
	////////////////////////////////////////////////////////////
	{

		contents := `
	struct Foo{
	  map<string,  int32>  bar1;
	  map<string?, int32>  bar2;
	  map<string,  int32>? bar3;
	  map<string?, int32>? bar4;
	};`

		test.addTestCase("", contents)

		// DeclaredMojomObjects
		test.expectedFile().DeclaredMojomObjects.Structs = &[]string{"TYPE_KEY:Foo"}

		// ResolvedTypes

		// struct Foo
		test.expectedGraph().ResolvedTypes["TYPE_KEY:Foo"] = &mojom_types.UserDefinedTypeStructType{mojom_types.MojomStruct{
			DeclData: test.newDeclData("Foo", "Foo"),
			Fields: []mojom_types.StructField{
				// field bar1 is non-nullable with a non-nullable key.
				{
					DeclData: test.newDeclData("bar1", ""),
					Type: &mojom_types.TypeMapType{mojom_types.MapType{
						false,
						&mojom_types.TypeStringType{mojom_types.StringType{false}},
						&mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32}}},
				},
				// field bar2 is non-nullable with a nullable key.
				{
					DeclData: test.newDeclData("bar2", ""),
					Type: &mojom_types.TypeMapType{mojom_types.MapType{
						false,
						&mojom_types.TypeStringType{mojom_types.StringType{true}},
						&mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32}}},
				},
				// field bar3 is nullable with a non-nullable key.
				{
					DeclData: test.newDeclData("bar3", ""),
					Type: &mojom_types.TypeMapType{mojom_types.MapType{
						true,
						&mojom_types.TypeStringType{mojom_types.StringType{false}},
						&mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32}}},
				},
				// field bar4 is nullable with a nullable key.
				{
					DeclData: test.newDeclData("bar4", ""),
					Type: &mojom_types.TypeMapType{mojom_types.MapType{
						true,
						&mojom_types.TypeStringType{mojom_types.StringType{true}},
						&mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32}}},
				},
			},
		}}

		test.endTestCase()
	}

	////////////////////////////////////////////////////////////
	// Test Case: enum value initializer
	////////////////////////////////////////////////////////////
	{

		contents := `
	enum Foo{
	  X0,
	  X1 = 42,
	  X2 = X1
	};`

		test.addTestCase("", contents)

		// DeclaredMojomObjects
		test.expectedFile().DeclaredMojomObjects.TopLevelEnums = &[]string{"TYPE_KEY:Foo"}

		// Resolved Values

		// Foo.X0
		test.expectedGraph().ResolvedValues["TYPE_KEY:Foo.X0"] = &mojom_types.UserDefinedValueEnumValue{mojom_types.EnumValue{
			DeclData:    test.newDeclData("X0", "Foo.X0"),
			EnumTypeKey: "TYPE_KEY:Foo",
			IntValue:    0,
		}}

		// Foo.X1
		test.expectedGraph().ResolvedValues["TYPE_KEY:Foo.X1"] = &mojom_types.UserDefinedValueEnumValue{mojom_types.EnumValue{
			DeclData:         test.newDeclData("X1", "Foo.X1"),
			EnumTypeKey:      "TYPE_KEY:Foo",
			InitializerValue: &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueInt8Value{42}},
			IntValue:         42,
		}}

		// Foo.X2
		test.expectedGraph().ResolvedValues["TYPE_KEY:Foo.X2"] = &mojom_types.UserDefinedValueEnumValue{mojom_types.EnumValue{
			DeclData:    test.newDeclData("X2", "Foo.X2"),
			EnumTypeKey: "TYPE_KEY:Foo",
			InitializerValue: &mojom_types.ValueUserValueReference{mojom_types.UserValueReference{
				Identifier: "X1",
				ValueKey:   stringPointer("TYPE_KEY:Foo.X1"),
			}},
			IntValue: 42,
		}}

		// ResolvedTypes

		// enum Foo
		test.expectedGraph().ResolvedTypes["TYPE_KEY:Foo"] = &mojom_types.UserDefinedTypeEnumType{mojom_types.MojomEnum{
			DeclData: test.newDeclData("Foo", "Foo"),
			Values: []mojom_types.EnumValue{
				// Note(rudominer) It is a bug that we need to copy the enum values here.
				// See https://github.com/domokit/mojo/issues/513.
				// value X1
				test.expectedGraph().ResolvedValues["TYPE_KEY:Foo.X0"].(*mojom_types.UserDefinedValueEnumValue).Value,
				// value X1
				test.expectedGraph().ResolvedValues["TYPE_KEY:Foo.X1"].(*mojom_types.UserDefinedValueEnumValue).Value,
				// value X2
				test.expectedGraph().ResolvedValues["TYPE_KEY:Foo.X2"].(*mojom_types.UserDefinedValueEnumValue).Value,
			},
		}}

		test.endTestCase()
	}

	////////////////////////////////////////////////////////////
	// Test Case: Integer constants
	////////////////////////////////////////////////////////////
	{

		contents := `
	const uint8 xu8 = 255;
	const int8 x8 = -127;
	const uint16 xu16 = 0xFFFF;
	const int16 x16 = -0x7FFF;
	const uint32 xu32 = 4294967295;
	const int32 x32 = -2147483647;
	const uint64 xu64 = 0xFFFFFFFFFFFFFFFF;
	const int64 x64 = -0x7FFFFFFFFFFFFFFF;
	`
		test.addTestCase("", contents)

		// DeclaredMojomObjects

		test.expectedFile().DeclaredMojomObjects.TopLevelConstants = &[]string{
			"TYPE_KEY:xu8", "TYPE_KEY:x8", "TYPE_KEY:xu16", "TYPE_KEY:x16",
			"TYPE_KEY:xu32", "TYPE_KEY:x32", "TYPE_KEY:xu64", "TYPE_KEY:x64"}

		// Resolved Values

		// xu8
		test.expectedGraph().ResolvedValues["TYPE_KEY:xu8"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("xu8", "xu8"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_UinT8},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueUint8Value{255}},
		}}

		// x8
		test.expectedGraph().ResolvedValues["TYPE_KEY:x8"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("x8", "x8"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT8},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueInt8Value{-127}},
		}}

		// xu16
		test.expectedGraph().ResolvedValues["TYPE_KEY:xu16"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("xu16", "xu16"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_UinT16},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueUint16Value{0xFFFF}},
		}}

		// x16
		test.expectedGraph().ResolvedValues["TYPE_KEY:x16"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("x16", "x16"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT16},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueInt16Value{-0x7FFF}},
		}}

		// xu32
		test.expectedGraph().ResolvedValues["TYPE_KEY:xu32"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("xu32", "xu32"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_UinT32},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueUint32Value{4294967295}},
		}}

		// x32
		test.expectedGraph().ResolvedValues["TYPE_KEY:x32"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("x32", "x32"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT32},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueInt32Value{-2147483647}},
		}}

		// xu64
		test.expectedGraph().ResolvedValues["TYPE_KEY:xu64"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("xu64", "xu64"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_UinT64},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueUint64Value{0xFFFFFFFFFFFFFFFF}},
		}}

		// x64
		test.expectedGraph().ResolvedValues["TYPE_KEY:x64"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("x64", "x64"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_InT64},
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueInt64Value{-0x7FFFFFFFFFFFFFFF}},
		}}

		test.endTestCase()
	}

	////////////////////////////////////////////////////////////
	// Test Case: Builtin Floating-Point Constants
	////////////////////////////////////////////////////////////
	{

		contents := `
	const float f1 = float.INFINITY;
	const float f2 = float.NEGATIVE_INFINITY;
	const float f3 = float.NAN;
	const double d1 = double.INFINITY;
	const double d2 = double.NEGATIVE_INFINITY;
	const double d3 = double.NAN;
	`
		test.addTestCase("", contents)

		// DeclaredMojomObjects

		test.expectedFile().DeclaredMojomObjects.TopLevelConstants = &[]string{
			"TYPE_KEY:f1", "TYPE_KEY:f2", "TYPE_KEY:f3", "TYPE_KEY:d1", "TYPE_KEY:d2", "TYPE_KEY:d3"}

		// Resolved Values

		// f1
		test.expectedGraph().ResolvedValues["TYPE_KEY:f1"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("f1", "f1"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_Float},
			Value:    &mojom_types.ValueBuiltinValue{mojom_types.BuiltinConstantValue_FloatInfinity},
		}}

		// f2
		test.expectedGraph().ResolvedValues["TYPE_KEY:f2"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("f2", "f2"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_Float},
			Value:    &mojom_types.ValueBuiltinValue{mojom_types.BuiltinConstantValue_FloatNegativeInfinity},
		}}

		// f3
		test.expectedGraph().ResolvedValues["TYPE_KEY:f3"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("f3", "f3"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_Float},
			Value:    &mojom_types.ValueBuiltinValue{mojom_types.BuiltinConstantValue_FloatNan},
		}}

		// d1
		test.expectedGraph().ResolvedValues["TYPE_KEY:d1"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("d1", "d1"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_Double},
			Value:    &mojom_types.ValueBuiltinValue{mojom_types.BuiltinConstantValue_DoubleInfinity},
		}}

		// d2
		test.expectedGraph().ResolvedValues["TYPE_KEY:d2"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("d2", "d2"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_Double},
			Value:    &mojom_types.ValueBuiltinValue{mojom_types.BuiltinConstantValue_DoubleNegativeInfinity},
		}}

		// d3
		test.expectedGraph().ResolvedValues["TYPE_KEY:d3"] = &mojom_types.UserDefinedValueDeclaredConstant{mojom_types.DeclaredConstant{
			DeclData: *test.newDeclData("d3", "d3"),
			Type:     &mojom_types.TypeSimpleType{mojom_types.SimpleType_Double},
			Value:    &mojom_types.ValueBuiltinValue{mojom_types.BuiltinConstantValue_DoubleNan},
		}}

		test.endTestCase()
	}

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
		[min_version=2]
		string y = "hello";
		string? z;

		enum Hats {
			TOP,
			COWBOY = NUM_MAGI,
			HARD,
		};
	};`

		test.addTestCase("mojom.test", contents)

		// Attributes
		test.expectedFile().Attributes = &[]mojom_types.Attribute{
			{"go_namespace", &mojom_types.LiteralValueStringValue{"go.test"}},
			{"lucky", &mojom_types.LiteralValueBoolValue{true}},
			{"planet", &mojom_types.LiteralValueStringValue{"EARTH"}},
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
			Value:    &mojom_types.ValueLiteralValue{&mojom_types.LiteralValueInt8Value{3}},
		}}

		// Hats.TOP
		test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.TOP"] = &mojom_types.UserDefinedValueEnumValue{mojom_types.EnumValue{
			DeclData:    test.newDeclData("TOP", "mojom.test.Foo.Hats.TOP"),
			EnumTypeKey: "TYPE_KEY:mojom.test.Foo.Hats",
			IntValue:    0,
		}}

		// Hats.COWBOY
		test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.COWBOY"] = &mojom_types.UserDefinedValueEnumValue{mojom_types.EnumValue{
			DeclData:    test.newDeclData("COWBOY", "mojom.test.Foo.Hats.COWBOY"),
			EnumTypeKey: "TYPE_KEY:mojom.test.Foo.Hats",
			IntValue:    3,
			InitializerValue: &mojom_types.ValueUserValueReference{mojom_types.UserValueReference{
				Identifier: "NUM_MAGI",
				ValueKey:   stringPointer("TYPE_KEY:mojom.test.NUM_MAGI"),
			}},
		}}

		// Hats.HARD
		test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.HARD"] = &mojom_types.UserDefinedValueEnumValue{mojom_types.EnumValue{
			DeclData:    test.newDeclData("HARD", "mojom.test.Foo.Hats.HARD"),
			EnumTypeKey: "TYPE_KEY:mojom.test.Foo.Hats",
			IntValue:    4,
		}}

		// ResolvedTypes

		// struct Foo
		test.expectedGraph().ResolvedTypes["TYPE_KEY:mojom.test.Foo"] = &mojom_types.UserDefinedTypeStructType{mojom_types.MojomStruct{
			DeclData: &mojom_types.DeclarationData{
				ShortName:        stringPointer("Foo"),
				FullIdentifier:   stringPointer("mojom.test.Foo"),
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
					DeclData:     test.newDeclDataA("y", "", &[]mojom_types.Attribute{{"min_version", &mojom_types.LiteralValueInt8Value{2}}}),
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
			DeclData: test.newContainedDeclData("Hats", "mojom.test.Foo.Hats", stringPointer("TYPE_KEY:mojom.test.Foo")),
			Values: []mojom_types.EnumValue{
				// Note(rudominer) It is a bug that we need to copy the enum values here.
				// See https://github.com/domokit/mojo/issues/513.
				// value TOP
				test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.TOP"].(*mojom_types.UserDefinedValueEnumValue).Value,
				// value COWBOY
				test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.COWBOY"].(*mojom_types.UserDefinedValueEnumValue).Value,
				// value HARD
				test.expectedGraph().ResolvedValues["TYPE_KEY:mojom.test.Foo.Hats.HARD"].(*mojom_types.UserDefinedValueEnumValue).Value,
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
		parser := parser.MakeParser(c.fileName, c.mojomContents, descriptor, nil)
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
		bytes, _, err := Serialize(descriptor, false)
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
		if expectedString == actualString {
			// The "#v" format is Go-syntax representation of the value and
			// uses the type names. We may need this extra detail to discern
			// the difference between expected and actual.
			expectedString = myfmt.Sprintf("%#v", expected)
			actualString = myfmt.Sprintf("%#v", actual)
		}
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
