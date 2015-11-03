// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"mojom/mojom_parser/lexer"
)

func NewTestFileScope(scopeName string) *Scope {
	return NewMojomDescriptor().AddMojomFile("test.mojom").InitializeFileScope(scopeName)
}

func NewResolvedUserRef(name string, resolvedType UserDefinedType, usedAsMapKey, usedForConstant bool, lv *LiteralValue) *UserTypeRef {
	userRef := NewUserTypeRef(name, false, false, nil, lexer.Token{})
	userRef.resolvedType = resolvedType
	if usedAsMapKey {
		userRef.MarkUsedAsMapKey()
	}
	if usedForConstant {
		userRef.MarkUsedAsConstantType()
	}
	if lv != nil {
		userRef.variableAssignment = &LiteralAssignment{*lv, "myVarialbe", LiteralAssignmentKindConstantDeclaration}
	}
	return userRef
}

func NewResolvedStructRef(usedAsMapKey, usedForConstant bool, lv *LiteralValue) *UserTypeRef {
	return NewResolvedUserRef("structRef", NewMojomStruct(
		DeclData("struct", nil, lexer.Token{}, nil)), usedAsMapKey, usedForConstant, lv)
}

func NewResolvedEnumRef(usedAsMapKey, usedForConstant bool, lv *LiteralValue) *UserTypeRef {
	return NewResolvedUserRef("enumRef", NewMojomEnum(
		DeclData("enum", nil, lexer.Token{}, nil)), usedAsMapKey, usedForConstant, lv)
}

func NewTestStruct(name string) *MojomStruct {
	return NewMojomStruct(DeclTestData(name))
}

func NewTestStructField(fieldType TypeRef, name string, defaultValue ValueRef) *StructField {
	return NewStructField(DeclTestData(name), fieldType, defaultValue)
}

func NewTestInterface(name string) *MojomInterface {
	return NewMojomInterface(DeclTestData(name))
}

func NewTestUnion(name string) *MojomUnion {
	return NewMojomUnion(DeclTestData(name))
}

func NewTestEnum(name string) *MojomEnum {
	return NewMojomEnum(DeclTestData(name))
}

func NewTestEnumValue(name string) *EnumValue {
	mojomEnum := NewMojomEnum(DeclData("foo", nil, lexer.Token{}, nil))
	mojomEnum.AddEnumValue(DeclData(name, nil, lexer.Token{}, nil), nil)
	return mojomEnum.Values[0]
}

func NewTestConstant(name string, value int64) *UserDefinedConstant {
	return NewUserDefinedConstant(DeclTestData(name), SimpleTypeInt64, MakeInt64LiteralValue(value))
}

func DeclTestData(name string) DeclarationData {
	return DeclData(name, nil, lexer.Token{}, nil)
}

func DeclTestDataA(name string, attributes *Attributes) DeclarationData {
	return DeclData(name, nil, lexer.Token{}, attributes)
}

func DeclTestDataWithOrdinal(name string, declaredOrdinal int64) DeclarationData {
	return DeclDataWithOrdinal(name, nil, lexer.Token{}, nil, declaredOrdinal)
}

func DeclTestDataAWithOrdinal(name string, attributes *Attributes, declaredOrdinal int64) DeclarationData {
	return DeclDataWithOrdinal(name, nil, lexer.Token{}, attributes, declaredOrdinal)
}
