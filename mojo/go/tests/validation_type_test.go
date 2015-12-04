// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package tests

import (
	"reflect"
	"testing"

	"mojo/public/interfaces/bindings/mojom_types"
	"mojo/public/interfaces/bindings/service_describer"
	"mojo/public/interfaces/bindings/tests/test_included_unions"
	"mojo/public/interfaces/bindings/tests/test_unions"
	test "mojo/public/interfaces/bindings/tests/validation_test_interfaces"
)

var test_descriptor map[string]mojom_types.UserDefinedType
var test_unions_descriptor map[string]mojom_types.UserDefinedType

func init() {
	test_descriptor = test.GetAllMojomTypeDefinitions()
	test_unions_descriptor = test_unions.GetAllMojomTypeDefinitions()
}

// Perform a sanity check where we examine an MojomEnum's contents for correctness.
func TestEnumType(t *testing.T) {
	enumID := test.ID_validation_test_interfaces_BasicEnum__
	shortName := "BasicEnum"
	fullIdentifier := "mojo.test.BasicEnum"
	labelMap := map[string]int32{
		"A": 0,
		"B": 1,
		"C": 0,
		"D": -3,
		"E": 0xA,
	}

	// Extract *UserDefinedType from the validation test's Descriptor using enumID.
	udt := test_descriptor[enumID]
	if udt == nil {
		t.Fatalf("Descriptor did not contain %s", enumID)
	}

	// The *UserDefinedType must be a *UserDefinedTypeEnumType.
	udet, ok := udt.(*mojom_types.UserDefinedTypeEnumType)
	if !ok {
		t.Fatalf("*UserDefinedType for %s was not *UserDefinedTypeEnumType", enumID)
	}

	// The UserDefinedTypeEnumType has a MojomEnum inside.
	me := udet.Value

	// Check that the generator produced the short name.
	if me.DeclData == nil || me.DeclData.ShortName == nil {
		t.Fatalf("Declaration Data's ShortName for %s is missing", enumID)
	}
	if *me.DeclData.ShortName != shortName {
		t.Fatalf("Declaration Data's ShortName for %s was %s, expected %s", enumID, *me.DeclData.ShortName, shortName)
	}
	if me.DeclData.FullIdentifier == nil {
		t.Fatalf("Declaration Data's FullIdentifier for %s is missing", enumID)
	}
	if *me.DeclData.FullIdentifier != fullIdentifier {
		t.Fatalf("Declaration Data's FullIdentifier for %s was %s, expected %s", enumID, *me.DeclData.FullIdentifier, fullIdentifier)
	}

	// Verify that the number of entries matches the expected ones.
	if got, expected := len(me.Values), len(labelMap); got != expected {
		t.Fatalf("MojomEnum for %s had %d labels, but expected %d", enumID, got, expected)
	}

	// Go through each entry, verify type info and that the enum label matches the expected one.
	for _, label := range me.Values {
		// label is an EnumValue.
		// Check that the generator produced the field's short name.
		if label.DeclData == nil || label.DeclData.ShortName == nil {
			t.Fatalf("Declaration Data's ShortName for %s's label is missing", enumID)
		}
		if _, ok := labelMap[*label.DeclData.ShortName]; !ok {
			t.Fatalf("Declaration Data's ShortName for %s's label %s is unknown ", enumID, *label.DeclData.ShortName)
		}
		// label's EnumTypeKey must be correct.
		if label.EnumTypeKey != enumID {
			t.Fatalf("EnumTypeKey for Enum %s's label %s had wrong identifier %s", enumID,
				*label.DeclData.ShortName, label.EnumTypeKey)
		}

		// Check that the label's IntValue matches the expected one.
		if expectedOrdinal := labelMap[*label.DeclData.ShortName]; label.IntValue != expectedOrdinal {
			t.Fatalf("IntValue for Enum %s's label %s was %d but expected %d",
				enumID, *label.DeclData.ShortName, label.IntValue, expectedOrdinal)
		}
	}
}

// Perform a sanity check where we examine a MojomStruct's contents for correctness.
func TestStructType(t *testing.T) {
	structID := test.ID_validation_test_interfaces_StructE__
	shortName := "StructE"
	fullIdentifier := "mojo.test.StructE"
	fields := map[int]string{
		0: "StructD",
		1: "DataPipeConsumer",
	}

	// Extract *UserDefinedType from the validation test's Descriptor using structID.
	udt := test_descriptor[structID]
	if udt == nil {
		t.Fatalf("Descriptor did not contain %s", structID)
	}

	// The *UserDefinedType must be a *UserDefinedTypeStructType.
	udst, ok := udt.(*mojom_types.UserDefinedTypeStructType)
	if !ok {
		t.Fatalf("*UserDefinedType for %s was not *UserDefinedTypeStructType", structID)
	}

	// The UserDefinedTypeStructType has a MojomStruct inside.
	ms := udst.Value

	// Check that the generator produced the short name.
	if ms.DeclData == nil || ms.DeclData.ShortName == nil {
		t.Fatalf("Declaration Data's ShortName for %s is missing", structID)
	}
	if *ms.DeclData.ShortName != shortName {
		t.Fatalf("Declaration Data's ShortName for %s was %s, expected %s", structID, *ms.DeclData.ShortName, shortName)
	}
	if ms.DeclData.FullIdentifier == nil {
		t.Fatalf("Declaration Data's FullIdentifier for %s is missing", structID)
	}
	if *ms.DeclData.FullIdentifier != fullIdentifier {
		t.Fatalf("Declaration Data's FullIdentifier for %s was %s, expected %s", structID, *ms.DeclData.FullIdentifier, fullIdentifier)
	}

	// Verify that the number of fields matches the expected ones.
	if got, expected := len(ms.Fields), len(fields); got != expected {
		t.Fatalf("MojomStruct for %s had %d fields, but expected %d", structID, got, expected)
	}

	// Go through each StructField, checking DeclData and the Type of each field.
	// Note that since ms.Fields is a slice, the "ordinal" is the index.
	for i, field := range ms.Fields {
		expectedFieldShortName := fields[i]
		// Check that the ShortName is correct.
		if field.DeclData == nil || field.DeclData.ShortName == nil || *field.DeclData.ShortName != expectedFieldShortName {
			t.Fatalf("StructField for %s at ordinal %d did not have ShortName %s", structID, i, expectedFieldShortName)
		}

		// Special case each field since we know what's inside.
		switch i {
		case 0:
			ttr, ok := field.Type.(*mojom_types.TypeTypeReference)
			if !ok {
				t.Fatalf("StructField %s's field 0 didn't have Type *TypeTypeReference", structID)
			}

			// TypeTypeReference.Value is a TypeReference
			expectedReferenceID := test.ID_validation_test_interfaces_StructD__
			if *ttr.Value.Identifier != expectedReferenceID {
				t.Fatalf("TypeReference Identifier got %s, but expected %s", *ttr.Value.Identifier, expectedReferenceID)
			}
			if *ttr.Value.TypeKey != expectedReferenceID {
				t.Fatalf("TypeReference TypeKey got %s, but expected %s", *ttr.Value.TypeKey, expectedReferenceID)
			}
		case 1:
			tht, ok := field.Type.(*mojom_types.TypeHandleType)
			if !ok {
				t.Fatalf("StructField %s's field 1 didn't have Type *TypeHandleType", structID)
			}

			// TypeHandleType.Value is a HandleType
			if tht.Value.Nullable {
				t.Fatalf("StructField %s's field 1 should have a non-nullable TypeHandle", structID)
			}
			if tht.Value.Kind != mojom_types.HandleType_Kind_DataPipeConsumer {
				t.Fatalf("StructField %s's field 1 has the wrong kind", structID)
			}
		default:
			t.Fatalf("There should not be a field %d for MojomStruct %s", i, structID)
		}
	}
}

// Perform a sanity check where we examine a MojomUnion's contents for correctness.
func TestUnionType(t *testing.T) {
	unionID := test.ID_validation_test_interfaces_UnionB__
	shortName := "UnionB"
	fullIdentifier := "mojo.test.UnionB"
	fields := map[int]string{
		0: "A",
		1: "B",
		2: "C",
		3: "D",
	}

	// Extract *UserDefinedType from the validation test's Descriptor using unionID.
	udt := test_descriptor[unionID]
	if udt == nil {
		t.Fatalf("Descriptor did not contain %s", unionID)
	}

	// The *UserDefinedType must be a *UserDefinedTypeUnionType.
	udut, ok := udt.(*mojom_types.UserDefinedTypeUnionType)
	if !ok {
		t.Fatalf("*UserDefinedType for %s was not *UserDefinedTypeUnionType", unionID)
	}

	// The UserDefinedTypeUnionType has a MojomUnion inside.
	mu := udut.Value

	// Check that the generator produced the short name.
	if mu.DeclData == nil || mu.DeclData.ShortName == nil {
		t.Fatalf("Declaration Data's ShortName for %s was missing", unionID)
	}
	if *mu.DeclData.ShortName != shortName {
		t.Fatalf("Declaration Data's ShortName for %s was %s, expected %s", unionID, *mu.DeclData.ShortName, shortName)
	}
	if mu.DeclData.FullIdentifier == nil {
		t.Fatalf("Declaration Data's FullIdentifier for %s is missing", unionID)
	}
	if *mu.DeclData.FullIdentifier != fullIdentifier {
		t.Fatalf("Declaration Data's FullIdentifier for %s was %s, expected %s", unionID, *mu.DeclData.FullIdentifier, fullIdentifier)
	}

	// Verify that the number of fields matches the expected ones.
	if got, expected := len(mu.Fields), len(fields); got != expected {
		t.Fatalf("MojomUnion for %s had %d fields, but expected %d", unionID, got, expected)
	}

	// Go through each UnionField, checking DeclData and the Type of each field.
	// Note that UnionField's rely on their Tag to determine their ordinal.
	// It is NOT in definition order, like with MojomStruct's.
	for _, field := range mu.Fields {
		ordinal := field.Tag
		expectedFieldShortName := fields[int(ordinal)]
		// Check that the ShortName is correct.
		if field.DeclData == nil || field.DeclData.ShortName == nil || *field.DeclData.ShortName != expectedFieldShortName {
			t.Fatalf("UnionField for %s at ordinal %d did not have ShortName %s", unionID, ordinal, expectedFieldShortName)
		}

		// It turns out that regardless of field ordinal, this union has TypeSimpleType for the type.
		tst, ok := field.Type.(*mojom_types.TypeSimpleType)
		if !ok {
			t.Fatalf("UnionField %s's field %d didn't have Type *TypeSimpleType", unionID, ordinal)
		}

		// Special case each field since we know what's inside.
		switch ordinal {
		case 0:
			if tst.Value != mojom_types.SimpleType_UinT16 {
				t.Fatalf("UnionField %s's field %d's Type value was not SimpleType_UinT16", unionID, ordinal)
			}
		case 1:
		case 3:
			if tst.Value != mojom_types.SimpleType_UinT32 {
				t.Fatalf("UnionField %s's field %d's Type value was not SimpleType_UinT32", unionID, ordinal)
			}
		case 2:
			if tst.Value != mojom_types.SimpleType_UinT64 {
				t.Fatalf("UnionField %s's field %d's Type value was not SimpleType_UinT64", unionID, ordinal)
			}
		default:
			t.Fatalf("There should not be a field Tag %d for MojomStruct %s", ordinal, unionID)
		}
	}
}

// Perform a sanity check for a struct that imports a union from another file.
// The descriptor should still handle it.
func TestStructWithImportType(t *testing.T) {
	structID := test_unions.ID_test_unions_IncludingStruct__
	shortName := "IncludingStruct"
	fullIdentifier := "mojo.test.IncludingStruct"
	fields := map[int]string{
		0: "A",
	}

	// Extract *UserDefinedType from the validation test's Descriptor using structID.
	udt := test_unions_descriptor[structID]
	if udt == nil {
		t.Fatalf("Descriptor did not contain %s", structID)
	}

	// The *UserDefinedType must be a *UserDefinedTypeStructType.
	udst, ok := udt.(*mojom_types.UserDefinedTypeStructType)
	if !ok {
		t.Fatalf("*UserDefinedType for %s was not *UserDefinedTypeStructType", structID)
	}

	// The UserDefinedTypeStructType has a MojomStruct inside.
	ms := udst.Value

	// Check that the generator produced the short name.
	if ms.DeclData == nil || ms.DeclData.ShortName == nil {
		t.Fatalf("Declaration Data's ShortName for %s is missing", structID)
	}
	if *ms.DeclData.ShortName != shortName {
		t.Fatalf("Declaration Data's ShortName for %s was %s, expected %s", structID, *ms.DeclData.ShortName, shortName)
	}
	if ms.DeclData.FullIdentifier == nil {
		t.Fatalf("Declaration Data's FullIdentifier for %s is missing", structID)
	}
	if *ms.DeclData.FullIdentifier != fullIdentifier {
		t.Fatalf("Declaration Data's FullIdentifier for %s was %s, expected %s", structID, *ms.DeclData.FullIdentifier, fullIdentifier)
	}

	// Verify that the number of fields matches the expected ones.
	if got, expected := len(ms.Fields), len(fields); got != expected {
		t.Fatalf("MojomStruct for %s had %d fields, but expected %d", structID, got, expected)
	}

	// Go through each StructField, checking DeclData and the Type of each field.
	// Note that since ms.Fields is a slice, the "ordinal" is the index.
	for i, field := range ms.Fields {
		expectedFieldShortName := fields[i]
		// Check that the ShortName is correct.
		if field.DeclData == nil || field.DeclData.ShortName == nil || *field.DeclData.ShortName != expectedFieldShortName {
			t.Fatalf("StructField for %s at ordinal %d did not have ShortName %s", structID, i, expectedFieldShortName)
		}

		// Special case each field since we know what's inside.
		switch i {
		case 0:
			ttr, ok := field.Type.(*mojom_types.TypeTypeReference)
			if !ok {
				t.Fatalf("StructField %s's field 0 didn't have Type *TypeTypeReference", structID)
			}

			// TypeTypeReference.Value is a TypeReference, which must have reference equality to the imported unionID.
			unionIDRef := &test_included_unions.ID_test_included_unions_IncludedUnion__
			if ttr.Value.Identifier != unionIDRef {
				t.Fatalf("TypeReference Identifier got %s, but expected %s", *ttr.Value.Identifier, *unionIDRef)
			}
			if ttr.Value.TypeKey != unionIDRef {
				t.Fatalf("TypeReference TypeKey got %s, but expected %s", *ttr.Value.TypeKey, *unionIDRef)
			}
		default:
			t.Fatalf("There should not be a field %d for MojomStruct %s", i, structID)
		}
	}
}

// Check that a MojomInterface has the right methods and the right struct definitions
// for its input and output. Further, its Interface_Request and Interface_Factory
// must expose a usable ServiceDescription.
func TestInterfaceType(t *testing.T) {
	// interface BoundsCheckTestInterface {
	//   Method0(uint8 param0) => (uint8 param0);
	//   Method1(uint8 param0);
	// };

	interfaceID := test.ID_validation_test_interfaces_BoundsCheckTestInterface__
	shortName := "BoundsCheckTestInterface"
	fullIdentifier := "mojo.test.BoundsCheckTestInterface"
	methodMap := map[uint32]string{
		0: "Method0",
		1: "Method1",
	}

	// Extract *UserDefinedType from the validation test's Descriptor using interfaceID.
	udt := test_descriptor[interfaceID]
	if udt == nil {
		t.Fatalf("Descriptor did not contain %s", interfaceID)
	}

	// The *UserDefinedType must be a *UserDefinedTypeInterfaceType.
	udit, ok := udt.(*mojom_types.UserDefinedTypeInterfaceType)
	if !ok {
		t.Fatalf("*UserDefinedType for %s was not *UserDefinedTypeInterfaceType", interfaceID)
	}

	// The UserDefinedTypeInterfaceType has a MojomInterface inside.
	mi := udit.Value
	checkMojomInterface(t, mi, interfaceID, shortName, fullIdentifier, methodMap)

	// Now, we must check the ServiceDescription(s) exposed by the autogenerated
	// ServiceRequest and ServiceFactory.
	var bcti_r test.BoundsCheckTestInterface_Request
	checkServiceDescription(t, bcti_r.ServiceDescription(), interfaceID, shortName, fullIdentifier, methodMap)

	var bcti_sf test.BoundsCheckTestInterface_ServiceFactory
	checkServiceDescription(t, bcti_sf.ServiceDescription(), interfaceID, shortName, fullIdentifier, methodMap)
}

func checkServiceDescription(t *testing.T, sd service_describer.ServiceDescription, interfaceID, shortName, fullIdentifier string, methodMap map[uint32]string) {
	// Check out the top level interface. This must pass checkMojomInterface.
	mi, err := sd.GetTopLevelInterface()
	if err != nil {
		t.Fatalf("Unexpected error %s", err)
	}
	checkMojomInterface(t, mi, interfaceID, shortName, fullIdentifier, methodMap)

	// Try out sd.GetTypeDefinition. Pass in the interfaceID to see if you can get it out.
	udt, err := sd.GetTypeDefinition(interfaceID)
	if err != nil {
		t.Fatalf("Unexpected error %s", err)
	}
	if udtit, ok := udt.(*mojom_types.UserDefinedTypeInterfaceType); !ok {
		t.Fatalf("This type should be a *UserDefinedTypeInterfaceType")
	} else {
		checkMojomInterface(t, udtit.Value, interfaceID, shortName, fullIdentifier, methodMap)
	}

	// Look at all the type definitions. Reflect-wise, all data inside should match the imported Descriptor.
	outDesc, err := sd.GetAllTypeDefinitions()
	if err != nil {
		t.Fatalf("Unexpected error %s", err)
	}
	if !reflect.DeepEqual(*outDesc, test_descriptor) {
		t.Fatalf("Descriptions did not match")
	}
}

func checkMojomInterface(t *testing.T, mi mojom_types.MojomInterface, interfaceID, shortName, fullIdentifier string, methodMap map[uint32]string) {
	// Check that the generator produced the short name.
	if mi.DeclData == nil || mi.DeclData.ShortName == nil {
		t.Fatalf("Declaration Data's ShortName for %s was missing", interfaceID)
	}
	if *mi.DeclData.ShortName != shortName {
		t.Fatalf("Declaration Data's ShortName for %s was %s, expected %s", interfaceID, *mi.DeclData.ShortName, shortName)
	}
	if mi.DeclData.FullIdentifier == nil {
		t.Fatalf("Declaration Data's FullIdentifier for %s was missing", fullIdentifier)
	}
	if *mi.DeclData.FullIdentifier != fullIdentifier {
		t.Fatalf("Declaration Data's FullIdentifier for %s was %s, expcected %s", interfaceID, *mi.DeclData.FullIdentifier, fullIdentifier)
	}

	// Verify that the number of methods matches the expected ones.
	if got, expected := len(mi.Methods), len(methodMap); got != expected {
		t.Fatalf("MojomInterface for %s had %d methods, but expected %d", interfaceID, got, expected)
	}

	// Go through each MojomMethod, checking DeclData and the Type of each field.
	// Note that since mi.Methods is a map, the "ordinal" is the key.
	for ordinal, method := range mi.Methods {
		expectedMethodShortName := methodMap[ordinal]
		// Check that the ShortName is correct.
		if method.DeclData == nil || method.DeclData.ShortName == nil || *method.DeclData.ShortName != expectedMethodShortName {
			t.Fatalf("MojomMethod for %s at ordinal %d did not have ShortName %s", interfaceID, ordinal, expectedMethodShortName)
		}

		// Special case each field since we know what's inside.
		switch ordinal {
		case 0:
			// We expect 0 to be a MojomMethod with both request and response params.
			params := method.Parameters
			if len(params.Fields) != 1 {
				t.Fatalf("Method0 Request had %d arguments, but should have had 1", len(params.Fields))
			}
			if tst, ok := params.Fields[0].Type.(*mojom_types.TypeSimpleType); !ok {
				t.Fatalf("Method0 Request param 0's Type should be a *TypeSimpleType")
			} else if tst.Value != mojom_types.SimpleType_UinT8 {
				t.Fatalf("Method0 Request param 0's Type's Value should be a SimpleType_UinT8")
			}

			response := method.ResponseParams
			if response == nil {
				t.Fatalf("Method0 Response should not be nil")
			}
			if len(response.Fields) != 1 {
				t.Fatalf("Method0 Response had %d arguments, but should have had 1", len(response.Fields))
			}
			if tst, ok := response.Fields[0].Type.(*mojom_types.TypeSimpleType); !ok {
				t.Fatalf("Method0 Response param 0's Type should be a *TypeSimpleType")
			} else if tst.Value != mojom_types.SimpleType_UinT8 {
				t.Fatalf("Method0 Response param 0's Type's Value should be a SimpleType_UinT8")
			}
		case 1:
			// We expect 1 to be a MojomMethod with a request and nil response params.
			params := method.Parameters
			if len(params.Fields) != 1 {
				t.Fatalf("Method1 Request had %d arguments, but should have had 1", len(params.Fields))
			}
			if tst, ok := params.Fields[0].Type.(*mojom_types.TypeSimpleType); !ok {
				t.Fatalf("Method1 Request param 0's Type should be a *TypeSimpleType")
			} else if tst.Value != mojom_types.SimpleType_UinT8 {
				t.Fatalf("Method1 Request param 0's Type's Value should be a SimpleType_UinT8")
			}

			if method.ResponseParams != nil {
				t.Fatalf("MojomMethod %d had a Response but should not have", ordinal)
			}
		default:
			t.Fatalf("There should not be a method %d for MojomInterface %s", ordinal, interfaceID)
		}
	}
}
