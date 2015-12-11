// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"math"
	"mojom/mojom_parser/lexer"
	"testing"
)

func TestConcreteTypeKind(t *testing.T) {
	cases := []struct {
		concreteType ConcreteType
		kind         TypeKind
	}{
		{SimpleTypeBool, TypeKindSimple},
		{SimpleTypeDouble, TypeKindSimple},
		{SimpleTypeFloat, TypeKindSimple},
		{SimpleTypeInt8, TypeKindSimple},
		{SimpleTypeInt16, TypeKindSimple},
		{SimpleTypeInt32, TypeKindSimple},
		{SimpleTypeInt64, TypeKindSimple},
		{SimpleTypeUInt8, TypeKindSimple},
		{SimpleTypeUInt16, TypeKindSimple},
		{SimpleTypeUInt32, TypeKindSimple},
		{SimpleTypeUInt64, TypeKindSimple},
		{StringLiteralType, TypeKindString},
		{NewMojomEnum(DeclTestData("")), TypeKindUserDefined},
		{BuiltInConstant, TypeKindUserDefined},
	}
	for _, c := range cases {
		got := c.concreteType.ConcreteTypeKind()
		if got != c.kind {
			t.Errorf("%v.ConcreteTypeKind() == %v, want %v", c.concreteType, got, c.kind)
		}
	}
}

func TestTypeRefKind(t *testing.T) {
	cases := []struct {
		typeRef TypeRef
		kind    TypeKind
	}{
		{SimpleTypeBool, TypeKindSimple},
		{SimpleTypeDouble, TypeKindSimple},
		{SimpleTypeFloat, TypeKindSimple},
		{SimpleTypeInt8, TypeKindSimple},
		{SimpleTypeInt16, TypeKindSimple},
		{SimpleTypeInt32, TypeKindSimple},
		{SimpleTypeInt64, TypeKindSimple},
		{SimpleTypeUInt8, TypeKindSimple},
		{SimpleTypeUInt16, TypeKindSimple},
		{SimpleTypeUInt32, TypeKindSimple},
		{SimpleTypeUInt64, TypeKindSimple},
		{StringType{}, TypeKindString},
		{NewArrayTypeRef(SimpleTypeInt32, 0, false), TypeKindArray},
		{NewMapTypeRef(SimpleTypeInt32, SimpleTypeInt64, false), TypeKindMap},
		{BuiltInType("handle"), TypeKindHandle},
		{NewUserTypeRef("foo", false, false, nil, lexer.Token{}), TypeKindUserDefined},
	}
	for _, c := range cases {
		got := c.typeRef.TypeRefKind()
		if got != c.kind {
			t.Errorf("%v.TypeRefKind() == %v, want %v", c.typeRef, got, c.kind)
		}
	}
}

func TestMarkUsedAsMapKey(t *testing.T) {
	userTypeRef := NewUserTypeRef("foo", false, false, nil, lexer.Token{})
	cases := []struct {
		typeRef TypeRef
		allowed bool
	}{
		{SimpleTypeBool, true},
		{SimpleTypeDouble, true},
		{SimpleTypeFloat, true},
		{SimpleTypeInt8, true},
		{SimpleTypeInt16, true},
		{SimpleTypeInt32, true},
		{SimpleTypeInt64, true},
		{SimpleTypeUInt8, true},
		{SimpleTypeUInt16, true},
		{SimpleTypeUInt32, true},
		{SimpleTypeUInt64, true},
		{StringType{}, true},
		{NewArrayTypeRef(SimpleTypeInt32, 0, false), false},
		{NewMapTypeRef(SimpleTypeInt32, SimpleTypeInt64, false), false},
		{BuiltInType("handle"), false},
		{userTypeRef, true},
	}
	for _, c := range cases {
		got := c.typeRef.MarkUsedAsMapKey()
		if got != c.allowed {
			t.Errorf("%v.MarkUsedAsMapKey() == %v, want %v", c.typeRef, got, c.allowed)
		}
	}
	if !userTypeRef.usedAsMapKey {
		t.Error("userTypeRef.usedAsMapKey is false.")
	}
}

func TestMarkUsedAsConstantType(t *testing.T) {
	userTypeRef := NewUserTypeRef("foo", false, false, nil, lexer.Token{})
	cases := []struct {
		typeRef TypeRef
		allowed bool
	}{
		{SimpleTypeBool, true},
		{SimpleTypeDouble, true},
		{SimpleTypeFloat, true},
		{SimpleTypeInt8, true},
		{SimpleTypeInt16, true},
		{SimpleTypeInt32, true},
		{SimpleTypeInt64, true},
		{SimpleTypeUInt8, true},
		{SimpleTypeUInt16, true},
		{SimpleTypeUInt32, true},
		{SimpleTypeUInt64, true},
		{StringType{}, true},
		{NewArrayTypeRef(SimpleTypeInt32, 0, false), false},
		{NewMapTypeRef(SimpleTypeInt32, SimpleTypeInt64, false), false},
		{BuiltInType("handle"), false},
		{userTypeRef, true},
	}
	for _, c := range cases {
		got := c.typeRef.MarkUsedAsConstantType()
		if got != c.allowed {
			t.Errorf("%v.MarkUsedAsConstantType() == %v, want %v", c.typeRef, got, c.allowed)
		}
	}
	if !userTypeRef.usedAsConstantType {
		t.Error("userTypeRef.usedAsConstantType is false.")
	}
}

func TestMarkTypeCompatible(t *testing.T) {
	userTypeRef := NewUserTypeRef("foo", false, false, nil, lexer.Token{})
	literalValues := []LiteralValue{
		MakeStringLiteralValue(""),
		MakeBoolLiteralValue(false),
		MakeInt8LiteralValue(0),
		MakeInt8LiteralValue(-1),
		MakeInt32LiteralValue(1),
		MakeUint32LiteralValue(1),
		MakeInt64LiteralValue(-(1 << 24)),
		MakeInt64LiteralValue(1 << 25),
		MakeInt64LiteralValue(1 << 53),
		MakeInt64LiteralValue(-(1 << 54)),
		MakeDoubleLiteralValue(0),
		MakeDefaultLiteral(),
	}
	cases := []struct {
		typeRef TypeRef
		allowed []bool
	}{
		{SimpleTypeBool, []bool{false, true, false, false, false, false, false, false, false, false, false, false}},
		{SimpleTypeDouble, []bool{false, false, true, true, true, true, true, true, true, false, true, false}},
		{SimpleTypeFloat, []bool{false, false, true, true, true, true, true, false, false, false, true, false}},
		{SimpleTypeInt8, []bool{false, false, true, true, false, false, false, false, false, false, false, false}},
		{SimpleTypeInt16, []bool{false, false, true, true, false, false, false, false, false, false, false, false}},
		{SimpleTypeInt32, []bool{false, false, true, true, true, false, false, false, false, false, false, false}},
		{SimpleTypeInt64, []bool{false, false, true, true, true, true, true, true, true, true, false, false}},
		{SimpleTypeUInt8, []bool{false, false, true, false, false, false, false, false, false, false, false, false}},
		{SimpleTypeUInt16, []bool{false, false, true, false, false, false, false, false, false, false, false, false}},
		{SimpleTypeUInt32, []bool{false, false, true, false, true, true, false, false, false, false, false, false}},
		{SimpleTypeUInt64, []bool{false, false, true, false, true, true, false, true, true, false, false, false}},
		{StringType{}, []bool{true, false, false, false, false, false, false, false, false, false, false, false}},
		{NewArrayTypeRef(SimpleTypeInt32, 0, false), []bool{false, false, false, false, false, false, false, false, false, false, false, false}},
		{NewMapTypeRef(SimpleTypeInt32, SimpleTypeInt64, false), []bool{false, false, false, false, false, false, false, false, false, false, false, false}},
		{BuiltInType("handle"), []bool{false, false, false, false, false, false, false, false, false, false, false, false}},
		// Assignments to UserTypeRefs are not validated at all during parsing.
		{userTypeRef, []bool{true, true, true, true, true, true, true, true, true, true, true, true}},
	}
	for _, c := range cases {
		for i, v := range literalValues {
			got := c.typeRef.MarkTypeCompatible(LiteralAssignment{assignedValue: v})
			if got != c.allowed[i] {
				t.Errorf("%v.MarkTypeCompatible(%d) == %v, want %v", c.typeRef, i, got, c.allowed[i])
			}
		}
	}
	if !userTypeRef.literalAssignment.assignedValue.IsDefault() {
		t.Error("userTypeRef.literalAssignment.assignedValue.IsDefault() is false.")
	}
}

func TestBuiltInType(t *testing.T) {
	expectedBuiltInTypeNames := []string{
		"bool", "double", "float", "int8", "int16", "int32", "int64",
		"uint8", "uint16", "uint32", "uint64", "string", "string?",
		"handle", "handle<message_pipe>", "handle<data_pipe_producer>",
		"handle<data_pipe_consumer>", "handle<shared_buffer>",
		"handle?", "handle<message_pipe>?", "handle<data_pipe_producer>?",
		"handle<data_pipe_consumer>?", "handle<shared_buffer>?"}

	for _, name := range expectedBuiltInTypeNames {
		if BuiltInType(name) == nil {
			t.Errorf("BuiltInType(%q) not found.", name)
		} else if BuiltInType(name).String() != name {
			t.Errorf("BuiltInType(%q).String() != %q", name, name)
		}
	}
}

func TestMarkUsedAsEnumValueInitializer(t *testing.T) {
	userTypeRef := NewUserTypeRef("foo", false, false, nil, lexer.Token{})
	assigneeSpec := AssigneeSpec{
		"assignee",
		userTypeRef,
	}
	userValueRef := NewUserValueRef(assigneeSpec, "foo", nil, lexer.Token{})
	cases := []struct {
		valueRef ValueRef
		allowed  bool
	}{
		{MakeStringLiteralValue(""), false},
		{MakeBoolLiteralValue(false), false},
		{MakeUint8LiteralValue(0), true},
		{MakeInt8LiteralValue(-1), true},
		{MakeInt64LiteralValue(math.MaxInt32), true},
		{MakeInt64LiteralValue(math.MaxInt32 + 1), false},
		{MakeInt64LiteralValue(math.MinInt32), true},
		{MakeInt64LiteralValue(math.MinInt32 - 1), false},
		{MakeDoubleLiteralValue(3.14), false},
		{MakeDefaultLiteral(), false},
		{userValueRef, true},
	}
	for _, c := range cases {
		got := c.valueRef.MarkUsedAsEnumValueInitializer()
		if got != c.allowed {
			t.Errorf("%v.MarkUsedAsEnumValueInitializer() == %v, want %v", c.valueRef, got, c.allowed)
		}
	}
	if !userValueRef.usedAsEnumValueInitializer {
		t.Error("userValueRef.usedAsEnumValueInitializer is false.")
	}
}

func TestResolvedConcreteValue(t *testing.T) {
	userTypeRef := NewUserTypeRef("foo", false, false, nil, lexer.Token{})
	assigneeSpec := AssigneeSpec{
		"assignee",
		userTypeRef,
	}
	userValueRef := NewUserValueRef(assigneeSpec, "foo", nil, lexer.Token{})
	cases := []struct {
		valueRef      ValueRef
		concreteValue ConcreteValue
	}{
		{MakeStringLiteralValue("foo"), MakeStringLiteralValue("foo")},
		{MakeBoolLiteralValue(false), MakeBoolLiteralValue(false)},
		{MakeInt64LiteralValue(42), MakeInt64LiteralValue(42)},
		{MakeDoubleLiteralValue(3.14), MakeDoubleLiteralValue(3.14)},
		{MakeDefaultLiteral(), MakeDefaultLiteral()},
		{userValueRef, nil},
	}
	for _, c := range cases {
		got := c.valueRef.ResolvedConcreteValue()
		if got != c.concreteValue {
			t.Errorf("%v.ResolvedConcreteValue() == %v, want %v", c.valueRef, got, c.concreteValue)
		}
	}
}

func TestValueType(t *testing.T) {
	mojomEnum := NewTestEnum("foo")
	mojomEnum.AddEnumValue(DeclTestData("bar"), nil)
	cases := []struct {
		concreteValue ConcreteValue
		concreteType  ConcreteType
	}{
		{MakeStringLiteralValue("foo"), StringLiteralType},
		{MakeBoolLiteralValue(false), SimpleTypeBool},
		{MakeInt64LiteralValue(42), SimpleTypeInt64},
		{MakeDoubleLiteralValue(3.14), SimpleTypeDouble},
		{MakeDefaultLiteral(), StringLiteralType},
		{mojomEnum.Values[0], mojomEnum},
		{FloatInfinity, BuiltInConstant},
	}
	for _, c := range cases {
		got := c.concreteValue.ValueType()
		if got != c.concreteType {
			t.Errorf("%v.ValueType() == %v, want %v", c.concreteValue, got, c.concreteType)
		}
	}
}

func TestValue(t *testing.T) {
	enumValue := NewTestEnumValue("foo")
	cases := []struct {
		concreteValue ConcreteValue
		value         interface{}
	}{
		{MakeStringLiteralValue("foo"), "foo"},
		{MakeBoolLiteralValue(false), false},
		{MakeInt64LiteralValue(42), int64(42)},
		{MakeDoubleLiteralValue(3.14), 3.14},
		{MakeDefaultLiteral(), "default"},
		{enumValue, *enumValue},
		{FloatInfinity, FloatInfinity},
	}
	for _, c := range cases {
		got := c.concreteValue.Value()
		if got != c.value {
			t.Errorf("%v.Value() == %v, want %v", c.concreteValue, got, c.value)
		}
	}
}

func TestValidateAfterResolution(t *testing.T) {
	stringLiteral := MakeStringLiteralValue("foo")
	intLiteral := MakeInt64LiteralValue(42)
	floatLiteral := MakeDoubleLiteralValue(3.14)
	defaultLiteral := MakeDefaultLiteral()
	cases := []struct {
		typeRef       *UserTypeRef
		expectSuccess bool
	}{
		// The bool arguments to NewResolvedStructRef() and
		// NewResolvedEnumRef are: (usedAsMapKey, usedForConstant)
		{NewResolvedStructRef(false, false, nil), true},
		// A struct may not be the type of a constant.
		{NewResolvedStructRef(false, true, nil), false},
		// A struct may not be used as a map key.
		{NewResolvedStructRef(true, false, nil), false},
		// A struct variable may not be assigned a literal other than "default".
		{NewResolvedStructRef(false, false, &stringLiteral), false},
		{NewResolvedStructRef(false, false, &intLiteral), false},
		{NewResolvedStructRef(false, false, &floatLiteral), false},
		{NewResolvedStructRef(false, false, &defaultLiteral), true},

		{NewResolvedEnumRef(false, false, nil), true},
		// An enum type may be the type of a constant
		{NewResolvedEnumRef(false, true, nil), true},
		// An enum type may be the type of a map key
		{NewResolvedEnumRef(true, false, nil), true},
		{NewResolvedEnumRef(false, false, &stringLiteral), false},
		// Enums may not be assigned an integer literal
		{NewResolvedEnumRef(false, false, &intLiteral), false},
		{NewResolvedEnumRef(false, false, &floatLiteral), false},
		{NewResolvedEnumRef(false, false, &defaultLiteral), false},
	}
	for i, c := range cases {
		success := nil == c.typeRef.validateAfterResolution()
		if success != c.expectSuccess {
			t.Errorf("case %d: %v: success=%v", i, c.typeRef, success)
		}
	}
}
