// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"errors"
	"fmt"
	"math"
	"mojom/mojom_parser/lexer"
	"strings"
)

/*
This file contains data structures and functions used to describe user-defined,
types (i.e. structs, unions, enums and interfaces) and user-defined values
(i.e. declared constants and enum values.) See the comments at the top of
types.go for a discussion of types vs type references and values vs
value references.
*/

// User-Defined Type Kinds
type UserDefinedTypeKind int

const (
	UserDefinedTypeKindStruct UserDefinedTypeKind = iota
	UserDefinedTypeKindInterface
	UserDefinedTypeKindEnum
	UserDefinedTypeKindUnion
)

func (k UserDefinedTypeKind) String() string {
	switch k {
	case UserDefinedTypeKindStruct:
		return "struct"
	case UserDefinedTypeKindInterface:
		return "interface"
	case UserDefinedTypeKindEnum:
		return "enum"
	case UserDefinedTypeKindUnion:
		return "union"
	default:
		panic(fmt.Sprintf("Unknown UserDefinedTypeKind: %d", k))
	}
}

// A DeclaredObject is anything that can be registered in a scope:
// A UserDefinedType, a UserDefinedValue, a method or a struct field.
type DeclaredObject interface {
	SimpleName() string
	NameToken() lexer.Token
	FullyQualifiedName() string
	KindString() string
	Scope() *Scope
	RegisterInScope(scope *Scope) DuplicateNameError
}

func FullLocationString(o DeclaredObject) string {
	return fmt.Sprintf("%s:%s", o.Scope().file.CanonicalFileName,
		o.NameToken().ShortLocationString())
}

/////////////////////////////////////////////////////////////
// The UserDefinedType interface. This is implemented by
// MojomStruct, MojomInterface, MojomEnum and MojomUnion
/////////////////////////////////////////////////////////////
type UserDefinedType interface {
	DeclaredObject
	Kind() UserDefinedTypeKind
	TypeKey() string
	IsAssignmentCompatibleWith(value LiteralValue) bool
}

// This struct is embedded in each of MojomStruct, MojomInterface
// MojomEnum and MojomUnion
type UserDefinedTypeBase struct {
	DeclarationData
	thisType UserDefinedType
	typeKey  string
}

// This method is invoked from the constructors for the containing types:
// NewMojomInterface, NewMojomStruct, NewMojomEnum, NewMojomUnion
func (b *UserDefinedTypeBase) Init(declData DeclarationData, thisType UserDefinedType) {
	b.thisType = thisType
	b.DeclarationData = declData
	b.DeclarationData.declaredObject = thisType
}

func (b *UserDefinedTypeBase) TypeKind() TypeKind {
	return TypeKindUserDefined
}

func (b *UserDefinedTypeBase) KindString() string {
	return b.thisType.Kind().String()
}

// Generates the fully-qualified name and the type Key and registers the
// type in the given |scope| and also with the associated MojomDescriptor.
//
// This method is invoked when a UserDefinedType is added to its container,
// which may be either a file or a different UserDefinedType.
func (b *UserDefinedTypeBase) RegisterInScope(scope *Scope) DuplicateNameError {
	if scope == nil {
		panic("scope is nil")
	}

	// Set the scope on b before invoking RegisterType().
	b.scope = scope
	if err := scope.RegisterType(b.thisType); err != nil {
		return err
	}

	b.fullyQualifiedName = buildDottedName(scope.fullyQualifiedName, b.simpleName)
	b.typeKey = computeTypeKey(b.fullyQualifiedName)
	scope.descriptor.TypesByKey[b.typeKey] = b.thisType
	return nil
}

func (b UserDefinedTypeBase) String() string {
	attributeString := ""
	if b.attributes != nil {
		attributeString = fmt.Sprintf("%s", b.attributes.List)
	}
	return fmt.Sprintf("(%s)%s%s", b.typeKey, attributeString, b.simpleName)
}

func (b *UserDefinedTypeBase) TypeKey() string {
	return b.typeKey
}

func (b UserDefinedTypeBase) Scope() *Scope {
	return b.scope
}

// Some user-defined types, namely interfaces and structs, may act as
// namespaced scopes for declarations of constants and enums.
type DeclarationContainer struct {
	containedScope *Scope
	Enums          []*MojomEnum
	Constants      []*UserDefinedConstant
	// DeclaredObjects lists the objects in this container in order of occurrence
	// in the source.
	// It includes all declared objects (for example methods and fields) not just
	// enums and constants.
	DeclaredObjects []DeclaredObject
}

// Adds an enum to the type associated with this DeclarationContainer,
// which must be an interface or struct.
func (c *DeclarationContainer) AddEnum(mojomEnum *MojomEnum) DuplicateNameError {
	c.DeclaredObjects = append(c.DeclaredObjects, mojomEnum)
	c.Enums = append(c.Enums, mojomEnum)
	return mojomEnum.RegisterInScope(c.containedScope)
}

// Adds a declared constant to this type, which must be an interface or struct.
func (c *DeclarationContainer) AddConstant(declaredConst *UserDefinedConstant) DuplicateNameError {
	c.DeclaredObjects = append(c.DeclaredObjects, declaredConst)
	c.Constants = append(c.Constants, declaredConst)
	if declaredConst == nil {
		panic("declaredConst is nil")
	}
	return declaredConst.RegisterInScope(c.containedScope)
}

/////////////////////////////////////////////////////////////
// Structs
/////////////////////////////////////////////////////////////

type StructType int

const (
	// A  regular struct.
	StructTypeRegular StructType = iota

	// A synthetic method request parameter struct. In this case the name
	/// of the struct will be the name of the method.
	StructTypeSyntheticRequest

	// A synthetic method response parameter struct. In this case the name
	// of the struct will be the name of the method.
	StructTypeSyntheticResponse
)

type MojomStruct struct {
	UserDefinedTypeBase
	DeclarationContainer

	structType StructType

	fieldsByName map[string]*StructField
	Fields       []*StructField

	// Used to form an error message in case of a duplicate field name.
	userFacingName string
}

func NewMojomStruct(declData DeclarationData) *MojomStruct {
	mojomStruct := new(MojomStruct)
	mojomStruct.fieldsByName = make(map[string]*StructField)
	mojomStruct.Fields = make([]*StructField, 0)
	mojomStruct.Init(declData, mojomStruct)
	mojomStruct.userFacingName = mojomStruct.simpleName
	return mojomStruct
}

const requestSuffix = "-request"
const responseSuffix = "-response"

func NewSyntheticRequestStruct(methodName string, nameToken lexer.Token, owningFile *MojomFile) *MojomStruct {
	mojomStruct := NewMojomStruct(DeclData(methodName+requestSuffix, owningFile, nameToken, nil))
	mojomStruct.structType = StructTypeSyntheticRequest
	mojomStruct.userFacingName = methodName
	return mojomStruct
}

func NewSyntheticResponseStruct(methodName string, nameToken lexer.Token, owningFile *MojomFile) *MojomStruct {
	mojomStruct := NewMojomStruct(DeclData(methodName+responseSuffix, owningFile, nameToken, nil))
	mojomStruct.structType = StructTypeSyntheticResponse
	mojomStruct.userFacingName = methodName
	return mojomStruct
}

func (s *MojomStruct) InitAsScope(parentScope *Scope) *Scope {
	s.containedScope = NewLexicalScope(ScopeStruct, parentScope, s.simpleName, parentScope.file, s)
	return s.containedScope
}

type DuplicateMemberNameError struct {
	DuplicateNameErrorBase
	duplicateObjectType, containerType, containerName string
}

func (e *DuplicateMemberNameError) Error() string {
	return UserErrorMessage(e.owningFile, e.nameToken,
		fmt.Sprintf("Duplicate definition of '%s'. "+
			"There is already a %s with that name in %s %s.",
			e.nameToken.Text, e.duplicateObjectType, e.containerType, e.containerName))
}

func (s *MojomStruct) AddField(field *StructField) DuplicateNameError {
	if field == nil {
		panic("field is nil")
	}
	if _, ok := s.fieldsByName[field.simpleName]; ok {
		var duplicateObjectType, containerType string
		switch s.structType {
		case StructTypeRegular:
			duplicateObjectType = "field"
			containerType = "struct"
		case StructTypeSyntheticRequest:
			duplicateObjectType = "request parameter"
			containerType = "method"
		case StructTypeSyntheticResponse:
			duplicateObjectType = "response parameter"
			containerType = "method"
		}
		return &DuplicateMemberNameError{
			DuplicateNameErrorBase{nameToken: field.NameToken(), owningFile: field.OwningFile()},
			duplicateObjectType, containerType, s.userFacingName}
	}
	if s.structType == StructTypeRegular {
		// Only a regular struct has a contained scope.
		if err := field.RegisterInScope(s.containedScope); err != nil {
			return err
		}
	}
	s.fieldsByName[field.simpleName] = field
	s.Fields = append(s.Fields, field)
	s.DeclaredObjects = append(s.DeclaredObjects, field)
	return nil
}

func (*MojomStruct) Kind() UserDefinedTypeKind {
	return UserDefinedTypeKindStruct
}

func (s *MojomStruct) StructType() StructType {
	return s.structType
}

func (MojomStruct) IsAssignmentCompatibleWith(value LiteralValue) bool {
	return value.IsDefault()
}

// This should be invoked some time after all of the fields have been added
// to the struct.
func (s *MojomStruct) ComputeFieldOrdinals() {
	// TODO(rudominer) Implement MojomStruct.ComputeFieldOrdinals()
}

func (m MojomStruct) String() string {
	s := fmt.Sprintf("\n---------struct--------------\n")
	s += fmt.Sprintf("%s\n", m.UserDefinedTypeBase)
	s += "     Fields\n"
	s += "     ------\n"
	for _, field := range m.Fields {
		s += fmt.Sprintf("     %s\n", field)
	}
	s += "     Enums\n"
	s += "     ------\n"
	for _, enum := range m.Enums {
		s += fmt.Sprintf(enum.toString(5))
	}
	s += "     Constants\n"
	s += "     --------"
	for _, constant := range m.Constants {
		s += fmt.Sprintf(constant.toString(5))
	}
	return s
}

// A debug string representing this struct in the case that this struct
// is being used to represent the parameters to a method.
func (s MojomStruct) ParameterString() string {
	str := ""
	for i, f := range s.Fields {
		if i > 0 {
			str += ", "
		}
		attributesString := ""
		if f.attributes != nil {
			attributesString = fmt.Sprintf("%s", f.attributes)
		}
		ordinalString := ""
		if f.declaredOrdinal >= 0 {
			ordinalString = fmt.Sprintf("@%d", f.declaredOrdinal)
		}
		str += fmt.Sprintf("%s%s %s%s", attributesString, f.FieldType,
			f.simpleName, ordinalString)
	}
	return str
}

type StructField struct {
	DeclarationData

	FieldType    TypeRef
	DefaultValue ValueRef
	// TODO(rudominer) Implement struct field offset computation.
	Offset int32
}

func NewStructField(declData DeclarationData, fieldType TypeRef, defaultValue ValueRef) *StructField {
	field := StructField{FieldType: fieldType, DefaultValue: defaultValue}
	declData.declaredObject = &field
	field.DeclarationData = declData
	return &field
}

func (f *StructField) ValidateDefaultValue() (ok bool) {
	if f.DefaultValue == nil {
		return true
	}
	if literalValue, ok := f.DefaultValue.(LiteralValue); ok {
		// The default value is a literal value. It is only this case we have to
		// handle now because if the default value were instead a reference then
		// it was already marked with the field type as it's assignee type and
		// it will be validated after resolution.
		assignment := LiteralAssignment{assignedValue: literalValue,
			variableName: f.SimpleName(), kind: LiteralAssignmentKindDefaultStructField}
		return f.FieldType.MarkTypeCompatible(assignment)
	}
	return true
}

func (f *StructField) RegisterInScope(scope *Scope) DuplicateNameError {
	// Set the scope on f before invoking RegisterValue().
	f.scope = scope
	if err := scope.RegisterStructField(f); err != nil {
		return err
	}

	if scope.kind != ScopeStruct {
		panic("A struct field  may only be registered within the scope of a struct.")
	}
	// Note that we give a struct field a fully-qualified name only for the purpose
	// of being able to refer to it in error messages. A struct field is not
	// a stand-alone entity: It may not be referred to in a .mojom file and it is
	// not given a type key.
	f.fullyQualifiedName = buildDottedName(scope.fullyQualifiedName, f.simpleName)
	return nil
}

func (f *StructField) Scope() *Scope {
	return f.scope
}

func (f *StructField) KindString() string {
	return "field"
}

func (f StructField) String() string {
	attributeString := ""
	if f.attributes != nil {
		attributeString = f.attributes.String()
	}
	defaultValueString := ""
	if f.DefaultValue != nil {
		defaultValueString = fmt.Sprintf(" = %s", f.DefaultValue)
	}
	ordinalString := ""
	if f.declaredOrdinal >= 0 {
		ordinalString = fmt.Sprintf("@%d", f.declaredOrdinal)
	}
	return fmt.Sprintf("%s%s %s%s%s", attributeString, f.FieldType, f.simpleName, ordinalString, defaultValueString)
}

/////////////////////////////////////////////////////////////
// Interfaces and Methods
/////////////////////////////////////////////////////////////

type MojomInterface struct {
	UserDefinedTypeBase
	DeclarationContainer

	MethodsByOrdinal map[uint32]*MojomMethod

	methodsByName map[string]*MojomMethod

	methodsByLexicalOrder []*MojomMethod
}

func NewMojomInterface(declData DeclarationData) *MojomInterface {
	mojomInterface := new(MojomInterface)
	mojomInterface.MethodsByOrdinal = make(map[uint32]*MojomMethod)
	mojomInterface.methodsByName = make(map[string]*MojomMethod)
	mojomInterface.Init(declData, mojomInterface)
	return mojomInterface
}

func (i *MojomInterface) InitAsScope(parentScope *Scope) *Scope {
	i.containedScope = NewLexicalScope(ScopeInterface, parentScope,
		i.simpleName, parentScope.file, i)
	return i.containedScope
}

func (i *MojomInterface) AddMethod(method *MojomMethod) DuplicateNameError {
	if err := method.RegisterInScope(i.containedScope); err != nil {
		return err
	}
	i.methodsByName[method.simpleName] = method
	i.methodsByLexicalOrder = append(i.methodsByLexicalOrder, method)
	i.DeclaredObjects = append(i.DeclaredObjects, method)
	return nil
}

func (MojomInterface) Kind() UserDefinedTypeKind {
	return UserDefinedTypeKindInterface
}

func (MojomInterface) IsAssignmentCompatibleWith(value LiteralValue) bool {
	return false
}

var ErrOrdinalRange = errors.New("ordinal value out of range")
var ErrOrdinalDuplicate = errors.New("duplicate ordinal value")

type MethodOrdinalError struct {
	Ord            int64        // The attemted ordinal
	InterfaceName  string       // The name of the interface in which the problem occurs.
	Method         *MojomMethod // The method with the attempted ordinal
	ExistingMethod *MojomMethod // Used if Err == ErrOrdinalDuplicate
	Err            error        // the type of error (ErrOrdinalRange, ErrOrdinalDuplicate)
}

// MethodOrdinalError implements error.
func (e *MethodOrdinalError) Error() string {
	var message string
	switch e.Err {
	case ErrOrdinalRange:
		message = fmt.Sprintf("Invalid method ordinal for method %s: %d. "+
			"A method ordinal must be a non-negative 32-bit integer value.",
			e.Method.SimpleName(), e.Ord)
	case ErrOrdinalDuplicate:
		message = fmt.Sprintf("Invalid method ordinal for method %s: %d. "+
			"There is already a method in interface %s with that ordinal: %s.",
			e.Method.SimpleName(), e.Ord, e.InterfaceName,
			e.ExistingMethod.SimpleName())
	default:
		panic(fmt.Sprintf("Unrecognized type of MethodOrdinalError %v", e.Err))
	}
	return UserErrorMessage(e.Method.OwningFile(), e.Method.NameToken(), message)
}

func (intrfc *MojomInterface) ComputeMethodOrdinals() error {
	nextOrdinal := uint32(0)
	for _, method := range intrfc.methodsByLexicalOrder {
		if method.declaredOrdinal < 0 {
			method.Ordinal = nextOrdinal
		} else {
			if method.declaredOrdinal >= math.MaxUint32 {
				return &MethodOrdinalError{Ord: method.declaredOrdinal,
					InterfaceName: intrfc.SimpleName(), Method: method,
					Err: ErrOrdinalRange}
			}
			method.Ordinal = uint32(method.declaredOrdinal)
		}
		if existingMethod, ok := intrfc.MethodsByOrdinal[method.Ordinal]; ok {
			return &MethodOrdinalError{Ord: int64(method.Ordinal),
				InterfaceName: intrfc.SimpleName(), Method: method,
				ExistingMethod: existingMethod, Err: ErrOrdinalDuplicate}
		}
		intrfc.MethodsByOrdinal[method.Ordinal] = method
		nextOrdinal = method.Ordinal + 1
	}
	return nil
}

func (m *MojomInterface) String() string {
	if m == nil {
		return "nil"
	}
	s := fmt.Sprintf("\n---------interface--------------\n")
	s += fmt.Sprintf("%s\n", m.UserDefinedTypeBase)
	s += "     Methods\n"
	s += "     -------\n"
	for _, method := range m.methodsByName {
		s += fmt.Sprintf("     %s\n", method)
	}
	return s
}

type MojomMethod struct {
	DeclarationData

	// The ordinal field differs from the declaredOrdinal field
	// in DeclarationData because every method eventually gets
	// assigned an ordinal whereas the declaredOrdinal is only set
	// if the user explicitly sets it in the .mojom file.
	Ordinal uint32

	Parameters *MojomStruct

	ResponseParameters *MojomStruct
}

func NewMojomMethod(declData DeclarationData, params, responseParams *MojomStruct) *MojomMethod {
	mojomMethod := new(MojomMethod)
	declData.declaredObject = mojomMethod
	mojomMethod.DeclarationData = declData
	mojomMethod.Parameters = params
	mojomMethod.ResponseParameters = responseParams
	return mojomMethod
}

func (m *MojomMethod) String() string {
	parameterString := m.Parameters.ParameterString()
	responseString := ""
	if m.ResponseParameters != nil {
		responseString = fmt.Sprintf(" => (%s)", m.ResponseParameters.ParameterString())
	}
	return fmt.Sprintf("%s(%s)%s", m.simpleName, parameterString, responseString)
}

func (m *MojomMethod) RegisterInScope(scope *Scope) DuplicateNameError {
	// Set the scope on m before invoking RegisterValue().
	m.scope = scope
	if err := scope.RegisterMethod(m); err != nil {
		return err
	}

	if scope.kind != ScopeInterface {
		panic("A method  may only be registered within the scope of an interface.")
	}
	m.fullyQualifiedName = buildDottedName(scope.fullyQualifiedName, m.simpleName)
	return nil
}

func (m *MojomMethod) Scope() *Scope {
	return m.scope
}

func (m *MojomMethod) KindString() string {
	return "method"
}

/////////////////////////////////////////////////////////////
// Unions
/////////////////////////////////////////////////////////////
type MojomUnion struct {
	UserDefinedTypeBase

	fieldsByName map[string]*UnionField
	Fields       []*UnionField
	// DeclaredObjects is the list of union fields maintained in order of
	// occurrence in the source.
	DeclaredObjects []DeclaredObject
}

func NewMojomUnion(declData DeclarationData) *MojomUnion {
	mojomUnion := new(MojomUnion)
	mojomUnion.fieldsByName = make(map[string]*UnionField)
	mojomUnion.Fields = make([]*UnionField, 0)
	mojomUnion.Init(declData, mojomUnion)
	return mojomUnion
}

// Adds a UnionField to this Union
func (u *MojomUnion) AddField(declData DeclarationData, FieldType TypeRef) DuplicateNameError {
	field := UnionField{FieldType: FieldType}
	declData.declaredObject = &field
	field.DeclarationData = declData
	if _, ok := u.fieldsByName[field.simpleName]; ok {
		return &DuplicateMemberNameError{
			DuplicateNameErrorBase{nameToken: field.NameToken(), owningFile: field.OwningFile()},
			"field", "union", u.simpleName}
	}
	u.fieldsByName[field.simpleName] = &field
	u.Fields = append(u.Fields, &field)
	u.DeclaredObjects = append(u.DeclaredObjects, &field)
	return nil
}

// This should be invoked some time after all of the fields have been added
// to the union.
func (u *MojomUnion) ComputeFieldTags() {
	// TODO(rudominer) Implement MojomUnion.ComputeFieldTags()
}

func (MojomUnion) Kind() UserDefinedTypeKind {
	return UserDefinedTypeKindUnion
}

func (MojomUnion) IsAssignmentCompatibleWith(value LiteralValue) bool {
	return false
}

type UnionField struct {
	DeclarationData

	FieldType TypeRef
	Tag       uint32
}

func (f *UnionField) RegisterInScope(scope *Scope) DuplicateNameError {
	// We currently have not reason to register a UnionField in a scope.
	panic("Not implemented.")
}

func (f *UnionField) Scope() *Scope {
	return f.scope
}

func (f *UnionField) KindString() string {
	return "union field"
}

/////////////////////////////////////////////////////////////
// Enums
/////////////////////////////////////////////////////////////
type MojomEnum struct {
	UserDefinedTypeBase

	Values []*EnumValue
	// DeclaredObjects is the list of enum values in order of occurrence in the source.
	DeclaredObjects []DeclaredObject
	scopeForValues  *Scope
}

func NewMojomEnum(declData DeclarationData) *MojomEnum {
	mojomEnum := new(MojomEnum)
	mojomEnum.Values = make([]*EnumValue, 0)
	mojomEnum.Init(declData, mojomEnum)
	return mojomEnum
}

// A MojoEnum is a ConcreteType
func (MojomEnum) ConcreteTypeKind() TypeKind {
	return TypeKindUserDefined
}

func (e MojomEnum) IsAssignmentCompatibleWith(value LiteralValue) bool {
	return false
}

func (MojomEnum) Kind() UserDefinedTypeKind {
	return UserDefinedTypeKindEnum
}

func (e *MojomEnum) InitAsScope(parentScope *Scope) *Scope {
	e.scopeForValues = NewLexicalScope(ScopeEnum, parentScope,
		e.simpleName, parentScope.file, e)
	return e.scopeForValues
}

// Adds an EnumValue to this enum
func (e *MojomEnum) AddEnumValue(declData DeclarationData, valueRef ValueRef) DuplicateNameError {
	enumValue := new(EnumValue)
	enumValue.Init(declData, UserDefinedValueKindEnum, enumValue, valueRef)
	e.Values = append(e.Values, enumValue)
	e.DeclaredObjects = append(e.DeclaredObjects, enumValue)
	enumValue.enumType = e
	if e.scopeForValues == nil {
		return nil
	}
	return enumValue.RegisterInScope(e.scopeForValues)
}

func (e *MojomEnum) String() string {
	s := fmt.Sprintf("\n---------enum--------------\n")
	s += e.toString(0)
	return s
}

func (e *MojomEnum) toString(indentLevel int) string {
	indent := strings.Repeat(" ", indentLevel)
	s := fmt.Sprintf("%s%s\n", indent, e.UserDefinedTypeBase)
	s += indent + "     Values\n"
	s += indent + "     ------\n"
	for _, value := range e.Values {
		s += fmt.Sprintf(indent+"     %s", value)
	}
	return s
}

// An EnumValue is a ConcreteValue and a UserDefinedValue.
type EnumValue struct {
	UserDefinedValueBase

	enumType *MojomEnum

	// After all values in the MojomDescriptor have been resolved,
	// MojomDescriptor.ComputeEnumValueIntegers() should be invoked. This
	// computes |ComputedIntValue| for all EnumValues. The field
	// IntValueComputed is set to true to indicate the value has been
	// computed
	ComputedIntValue int32
	IntValueComputed bool
}

func (ev *EnumValue) EnumType() *MojomEnum {
	return ev.enumType
}

// EnumValue implements ConcreteValue
func (ev *EnumValue) ValueType() ConcreteType {
	return ev.enumType
}
func (ev *EnumValue) Value() interface{} {
	return *ev
}

func (ev *EnumValue) String() string {
	return fmt.Sprintf("%s\n", ev.UserDefinedValueBase)
}

/////////////////////////////////////////////////////////////
// Values
/////////////////////////////////////////////////////////////

// User-Defined Value Kinds
type UserDefinedValueKind int

const (
	UserDefinedValueKindEnum UserDefinedValueKind = iota
	UserDefinedValueKindDeclaredConst
	UserDefinedValueKindBuiltInConst
)

func (k UserDefinedValueKind) String() string {
	switch k {
	case UserDefinedValueKindEnum:
		return "enum value"
	case UserDefinedValueKindDeclaredConst:
		return "const"
	case UserDefinedValueKindBuiltInConst:
		return "built-in constant"
	default:
		panic(fmt.Sprintf("Unknown UserDefinedValueKind: %d", k))
	}
}

// A UserDefinedValue is a UserDefinedConstant an EnumValue, or a
// BuiltInConstantValue
type UserDefinedValue interface {
	DeclaredObject
	Kind() UserDefinedValueKind
	ValueKey() string
}

type UserDefinedValueBase struct {
	DeclarationData
	thisValue UserDefinedValue
	kind      UserDefinedValueKind
	valueKey  string
	// This is the value specified in the right-hand-side of the value
	// declaration. For an enum value it will be an integer literal. For
	// a constant declartion it may be a literal or it may be a reference.
	valueRef ValueRef
}

// This method is invoked from the constructors for the containing values:
// NewUserDefinedConstant and AddEnumValue
func (b *UserDefinedValueBase) Init(declData DeclarationData, kind UserDefinedValueKind,
	thisValue UserDefinedValue, valueRef ValueRef) {
	declData.declaredObject = thisValue
	b.DeclarationData = declData
	b.thisValue = thisValue
	b.kind = kind
	b.valueRef = valueRef
}

func (v *UserDefinedValueBase) RegisterInScope(scope *Scope) DuplicateNameError {
	// Set the scope on v before invoking RegisterValue().
	v.scope = scope
	if err := scope.RegisterValue(v.thisValue); err != nil {
		return err
	}

	if v.thisValue.Kind() == UserDefinedValueKindEnum {
		if scope.kind != ScopeEnum {
			panic("An enum value may only be registered within the scope of an enum.")
		}
	}

	v.fullyQualifiedName = buildDottedName(scope.fullyQualifiedName, v.simpleName)
	v.valueKey = computeTypeKey(v.fullyQualifiedName)
	scope.file.Descriptor.ValuesByKey[v.valueKey] = v.thisValue
	return nil
}

func (b UserDefinedValueBase) String() string {
	attributeString := ""
	if b.attributes != nil {
		attributeString = fmt.Sprintf("%s", b.attributes.List)
	}
	valueRefString := ""
	if b.valueRef != nil {
		valueRefString = fmt.Sprintf(" = %s", b.valueRef)
	}
	return fmt.Sprintf("(%s)%s%s%s", b.valueKey, attributeString, b.simpleName, valueRefString)
}

func (b *UserDefinedValueBase) Kind() UserDefinedValueKind {
	return b.kind
}

func (b UserDefinedValueBase) Scope() *Scope {
	return b.scope
}

func (b UserDefinedValueBase) ValueKey() string {
	return b.valueKey
}

func (b UserDefinedValueBase) ValueRef() ValueRef {
	return b.valueRef
}

func (b *UserDefinedValueBase) KindString() string {
	return b.thisValue.Kind().String()
}

/////////////////////////////////////////////////////////////
//Declared Constants
/////////////////////////////////////////////////////////////

// This represents a Mojom constant declaration.
type UserDefinedConstant struct {
	UserDefinedValueBase

	declaredType TypeRef
}

func NewUserDefinedConstant(declData DeclarationData, declaredType TypeRef, value ValueRef) *UserDefinedConstant {
	constant := new(UserDefinedConstant)
	constant.Init(declData, UserDefinedValueKindDeclaredConst, constant, value)
	constant.declaredType = declaredType
	return constant
}

func (b *UserDefinedConstant) String() string {
	return b.toString(0)
}

func (b *UserDefinedConstant) DeclaredType() TypeRef {
	return b.declaredType
}

func (b *UserDefinedConstant) toString(indentLevel int) string {
	indent := strings.Repeat(" ", indentLevel)
	return fmt.Sprintf("\n%sconst %s %s", indent, b.declaredType, b.UserDefinedValueBase)
}

func (c *UserDefinedConstant) ValidateValue() (ok bool) {
	if literalValue, ok := c.valueRef.(LiteralValue); ok {
		// The value is a literal value. It is only this case we have to
		// handle now because if the  value were instead a reference then
		// it was already marked with the constants declared type as it's
		// assignee type and it will be validated after resolution.
		assignment := LiteralAssignment{assignedValue: literalValue,
			variableName: c.simpleName, kind: LiteralAssignmentKindConstantDeclaration}
		return c.declaredType.MarkTypeCompatible(assignment)
	}
	return true
}

/////////////////////////////////////////////////////////////
// BuiltIn Types and Values
/////////////////////////////////////////////////////////////

// BuiltInConstantType implements ConcreteType.
type BuiltInConstantType int

const (
	BuiltInConstant BuiltInConstantType = 0
)

func (b BuiltInConstantType) String() string {
	if b == BuiltInConstant {
		return "built-in constant"
	} else {
		panic("BuiltInConstant is the only BuiltInConstantType.")
	}
}

func (b BuiltInConstantType) ConcreteTypeKind() TypeKind {
	return TypeKindUserDefined
}

// BuiltInConstantValue implements ConcreteValue and UserDefinedValue.
type BuiltInConstantValue int

const (
	FloatInfinity BuiltInConstantValue = iota
	FloatNegativeInfinity
	FloatNAN
	DoubleInfinity
	DoubleNegativeInfinity
	DoubleNAN
)

func LookupBuiltInConstantValue(identifier string) (val BuiltInConstantValue, ok bool) {
	val, ok = builtInConstantValues[identifier]
	return
}

var allBuiltInConstantValues = []BuiltInConstantValue{FloatInfinity, FloatNegativeInfinity,
	FloatNAN, DoubleInfinity, DoubleNegativeInfinity, DoubleNAN}

var builtInConstantValues map[string]BuiltInConstantValue

func init() {
	builtInConstantValues = make(map[string]BuiltInConstantValue, len(allBuiltInConstantValues))
	for _, b := range allBuiltInConstantValues {
		builtInConstantValues[b.String()] = b
	}
}

func (b BuiltInConstantValue) String() string {
	switch b {
	case FloatInfinity:
		return "float.INFINITY"
	case FloatNegativeInfinity:
		return "float.NEGATIVE_INFINITY"
	case FloatNAN:
		return "float.NAN"
	case DoubleInfinity:
		return "double.INFINITY"
	case DoubleNegativeInfinity:
		return "double.NEGATIVE_INFINITY"
	case DoubleNAN:
		return "double.NAN"
	default:
		panic(fmt.Sprintf("Unknown BuiltInConstantValue %d", b))
	}
}

// From interface ConcreteValue
func (BuiltInConstantValue) ValueType() ConcreteType {
	return BuiltInConstant
}

func (b BuiltInConstantValue) Value() interface{} {
	return b
}

// From interface UserDefinedValue

func (b BuiltInConstantValue) SimpleName() string {
	return b.String()
}

func (b BuiltInConstantValue) NameToken() lexer.Token {
	panic("Do not ask for the NameToken of a BuiltInConstantValue.")
}

func (b BuiltInConstantValue) FullyQualifiedName() string {
	return b.String()
}

func (b BuiltInConstantValue) Kind() UserDefinedValueKind {
	return UserDefinedValueKindBuiltInConst
}

func (b BuiltInConstantValue) KindString() string {
	return "built-in constant"
}

func (b BuiltInConstantValue) Scope() *Scope {
	return nil
}

func (b BuiltInConstantValue) ValueKey() string {
	return "built-in-value:" + b.String()
}

func (b BuiltInConstantValue) RegisterInScope(scope *Scope) DuplicateNameError {
	panic("Do not register a BuiltInConstantValue in a scope.")
}

/////////////////////////////////////////////////////////////
// Declaration Data
/////////////////////////////////////////////////////////////

// This struct is embedded in UserDefinedTypeBase, UserDefinedValueBase,
// StructField, UnionField and MojomMethod.
type DeclarationData struct {
	// A pointer to the DeclaredObject to which this DeclarationData belongs.
	declaredObject DeclaredObject

	attributes         *Attributes
	simpleName         string
	fullyQualifiedName string

	owningFile *MojomFile
	nameToken  lexer.Token

	// If not nil, this field points to the LexicalScope of the declaration
	// corresponding to this data. This will be nil for some embedees
	// of DeclarationData which do not keep track of their scopes.
	scope *Scope

	// We use int64 here because valid ordinals are uint32 and we want to
	// be able to represent an unset value as -1.
	declaredOrdinal int64
}

func DeclData(name string, owningFile *MojomFile, nameToken lexer.Token, attributes *Attributes) DeclarationData {
	return DeclDataWithOrdinal(name, owningFile, nameToken, attributes, -1)
}

func DeclDataWithOrdinal(name string, owningFile *MojomFile, nameToken lexer.Token,
	attributes *Attributes, declaredOrdinal int64) DeclarationData {
	return DeclarationData{simpleName: name, owningFile: owningFile, nameToken: nameToken,
		attributes: attributes, declaredOrdinal: declaredOrdinal}
}

func (d *DeclarationData) SimpleName() string {
	return d.simpleName
}

func (d *DeclarationData) NameToken() lexer.Token {
	return d.nameToken
}

func (d *DeclarationData) LineNumber() uint32 {
	return uint32(d.nameToken.LineNo)
}

func (d *DeclarationData) ColumnNumber() uint32 {
	return uint32(d.nameToken.LinePos)
}

func (d *DeclarationData) FullyQualifiedName() string {
	return d.fullyQualifiedName
}

func (d *DeclarationData) Attributes() *Attributes {
	return d.attributes
}

func (d *DeclarationData) DeclaredOrdinal() int64 {
	return d.declaredOrdinal
}

func (d *DeclarationData) OwningFile() *MojomFile {
	return d.owningFile
}

func (d *DeclarationData) ContainingType() UserDefinedType {
	if d.scope == nil {
		return nil
	}
	return d.scope.containingType
}

func (d *DeclarationData) DeclaredObject() DeclaredObject {
	return d.declaredObject
}

type Attributes struct {
	// The attributes are listed in order of occurrence in the source.
	List []MojomAttribute
}

func (a *Attributes) String() string {
	if a == nil {
		return "nil"
	}
	return fmt.Sprintf("%s", a.List)
}

func NewAttributes() *Attributes {
	attributes := new(Attributes)
	attributes.List = make([]MojomAttribute, 0)
	return attributes
}

type MojomAttribute struct {
	Key string
	// TODO(rudominer) Decide if we support attribute values as Names.
	// See https://github.com/domokit/mojo/issues/561.
	Value    LiteralValue
	KeyToken *lexer.Token
}

func (ma MojomAttribute) String() string {
	return fmt.Sprintf("%s=%s ", ma.Key, ma.Value)
}

func NewMojomAttribute(keyToken *lexer.Token, value LiteralValue) (mojomAttribute MojomAttribute) {
	mojomAttribute.KeyToken = keyToken
	mojomAttribute.Key = keyToken.Text
	mojomAttribute.Value = value
	return
}
