// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"mojom/mojom_parser/lexer"
)

func NewTestFileScope(scopeName string) *Scope {
	return NewMojomDescriptor().AddMojomFile("test.mojom").SetModuleNamespace(scopeName)
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
	return NewResolvedUserRef("structRef", NewMojomStruct("struct", nil), usedAsMapKey, usedForConstant, lv)
}

func NewResolvedEnumRef(usedAsMapKey, usedForConstant bool, lv *LiteralValue) *UserTypeRef {
	return NewResolvedUserRef("enumRef", NewMojomEnum("enum", nil), usedAsMapKey, usedForConstant, lv)
}

func NewEnumValue(name string) *EnumValue {
	mojomEnum := NewMojomEnum("foo", nil)
	mojomEnum.AddEnumValue(name, nil, nil)
	return mojomEnum.values[0]
}
