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
)

//////////////////////////////////////////////////
/// Mojom Descriptor Serialization
//////////////////////////////////////////////////

// This variable may be set to false in order to omit emitting line and
// column numbers.
var EmitLineAndColumnNumbers bool = true

// Serializes the MojomDescriptor into a binary form that is passed to the
// backend of the compiler in order to invoke the code generators.
// To do this we use Mojo serialization.
func Serialize(d *mojom.MojomDescriptor) (bytes []byte, err error) {
	fileGraph := translateDescriptor(d)
	encoder := bindings.NewEncoder()
	fileGraph.Encode(encoder)
	bytes, _, err = encoder.Data()
	return
}

// translateDescriptor translates from a mojom.MojomDescriptor (the pure Go
// representation used by the parser) to a mojom_files.MojomFileGraph (the
// Mojo Go representation used for serialization.)
func translateDescriptor(d *mojom.MojomDescriptor) *mojom_files.MojomFileGraph {
	fileGraph := mojom_files.MojomFileGraph{}

	// Add |files| field.
	fileGraph.Files = make(map[string]mojom_files.MojomFile)
	for name, file := range d.MojomFilesByName {
		fileGraph.Files[name] = translateMojomFile(file)
	}

	// Add |resolved_types| field.
	fileGraph.ResolvedTypes = make(map[string]mojom_types.UserDefinedType)
	for key, userDefinedType := range d.TypesByKey {
		fileGraph.ResolvedTypes[key] = translateUserDefinedType(userDefinedType)
	}

	// Add |resolved_values| field.
	fileGraph.ResolvedValues = make(map[string]mojom_types.UserDefinedValue)
	for key, userDefinedValue := range d.ValuesByKey {
		fileGraph.ResolvedValues[key] = translateUserDefinedValue(userDefinedValue)
	}

	return &fileGraph
}

// translateMojomFile translates from a mojom.MojomFile (the pure Go
// representation used by the parser) to a mojom_files.MojomFile (the
// Mojo Go representation used for serialization.)
func translateMojomFile(f *mojom.MojomFile) (file mojom_files.MojomFile) {
	// file_name field
	file.FileName = f.CanonicalFileName

	// module_namespace field
	file.ModuleNamespace = &f.ModuleNamespace

	// attributes field
	if f.Attributes != nil {
		file.Attributes = new([]mojom_types.Attribute)
		for _, attr := range f.Attributes.List {
			*(file.Attributes) = append(*(file.Attributes), translateMojomAttribute(&attr))
		}
	}

	// imports field
	if len(f.Imports) > 0 {
		file.Imports = new([]string)
		for _, importName := range f.Imports {
			*(file.Imports) = append(*(file.Imports), importName.CanonicalFileName)
		}
	}

	// declared_mojom_objects field...

	// Interfaces
	if f.Interfaces != nil && len(f.Interfaces) > 0 {
		file.DeclaredMojomObjects.Interfaces = new([]string)
		for _, intrfc := range f.Interfaces {
			*(file.DeclaredMojomObjects.Interfaces) = append(*(file.DeclaredMojomObjects.Interfaces), intrfc.TypeKey())
		}
	}

	// Structs
	if f.Structs != nil && len(f.Structs) > 0 {
		file.DeclaredMojomObjects.Structs = new([]string)
		for _, strct := range f.Structs {
			*(file.DeclaredMojomObjects.Structs) = append(*(file.DeclaredMojomObjects.Structs), strct.TypeKey())
		}
	}

	// Unions
	if f.Unions != nil && len(f.Unions) > 0 {
		file.DeclaredMojomObjects.Unions = new([]string)
		for _, union := range f.Unions {
			*(file.DeclaredMojomObjects.Unions) = append(*(file.DeclaredMojomObjects.Unions), union.TypeKey())
		}
	}

	// TopLevelEnums
	if f.Enums != nil && len(f.Enums) > 0 {
		file.DeclaredMojomObjects.TopLevelEnums = new([]string)
		for _, enum := range f.Enums {
			*(file.DeclaredMojomObjects.TopLevelEnums) = append(*(file.DeclaredMojomObjects.TopLevelEnums), enum.TypeKey())
		}
	}

	// TopLevelConstants
	if f.Constants != nil && len(f.Constants) > 0 {
		file.DeclaredMojomObjects.TopLevelConstants = new([]string)
		for _, constant := range f.Constants {
			*(file.DeclaredMojomObjects.TopLevelConstants) = append(*(file.DeclaredMojomObjects.TopLevelConstants), constant.ValueKey())
		}
	}

	// TODO(rudominer) Do we need the EmbeddedEnums and EmbeddedConstants
	// fields in KeysByType. It seems these fields are not currently being
	// used in mojom_translator.py.

	return
}

// translateUserDefinedType translates from a mojom.UserDefinedType (the pure Go
// representation used by the parser) to a mojom_types.UserDefinedType (the
// Mojo Go representation used for serialization.)
func translateUserDefinedType(t mojom.UserDefinedType) mojom_types.UserDefinedType {
	switch p := t.(type) {
	case *mojom.MojomStruct:
		return &mojom_types.UserDefinedTypeStructType{translateMojomStruct(p)}
	case *mojom.MojomInterface:
		return translateMojomInterface(p)
	case *mojom.MojomEnum:
		return translateMojomEnum(p)
	case *mojom.MojomUnion:
		return translateMojomUnion(p)
	default:
		panic(fmt.Sprintf("Unexpected type: %T", t))

	}
}

func translateMojomStruct(s *mojom.MojomStruct) mojom_types.MojomStruct {
	mojomStruct := mojom_types.MojomStruct{}
	mojomStruct.DeclData = translateDeclarationData(&s.DeclarationData)
	mojomStruct.DeclData.ContainedDeclarations = translateContainedDeclarations(&s.DeclarationContainer)

	for _, field := range s.Fields {
		mojomStruct.Fields = append(mojomStruct.Fields, translateStructField(field))
	}

	// TODO(rudominer) Implement VersionInfo.
	//mojomStruct.Value.VersionInfo = new([]mojom_types.StructVersion)

	return mojomStruct
}

func translateStructField(f *mojom.StructField) (field mojom_types.StructField) {
	field.DeclData = translateDeclarationData(&f.DeclarationData)
	field.Type = translateTypeRef(f.FieldType)
	if f.DefaultValue != nil {
		field.DefaultValue = translateDefaultFieldValue(f.DefaultValue)
	}
	// TODO(rudominer) Implement field offsets.
	field.Offset = f.Offset
	return
}

func translateDefaultFieldValue(v mojom.ValueRef) mojom_types.DefaultFieldValue {
	switch v := v.(type) {
	case mojom.LiteralValue:
		if v.IsDefault() {
			return &mojom_types.DefaultFieldValueDefaultKeyword{mojom_types.DefaultKeyword{}}
		}
		return &mojom_types.DefaultFieldValueValue{translateLiteralValue(v)}
	case *mojom.UserValueRef:
		return &mojom_types.DefaultFieldValueValue{translateUserValueRef(v)}
	default:
		panic(fmt.Sprintf("Unexpected ValueRef type: %T", v))

	}
}

func translateMojomInterface(intrfc *mojom.MojomInterface) *mojom_types.UserDefinedTypeInterfaceType {
	mojomInterface := mojom_types.UserDefinedTypeInterfaceType{}

	mojomInterface.Value.DeclData = translateDeclarationData(&intrfc.DeclarationData)
	mojomInterface.Value.DeclData.ContainedDeclarations = translateContainedDeclarations(&intrfc.DeclarationContainer)

	// TODO(rudominer) The Interface name field need not be the name from the .mojom file.
	mojomInterface.Value.InterfaceName = intrfc.SimpleName()

	mojomInterface.Value.Methods = make(map[uint32]mojom_types.MojomMethod)
	for ordinal, method := range intrfc.MethodsByOrdinal {
		mojomInterface.Value.Methods[ordinal] = translateMojomMethod(method)
	}

	return &mojomInterface
}

func translateMojomMethod(method *mojom.MojomMethod) mojom_types.MojomMethod {
	mojomMethod := mojom_types.MojomMethod{}

	// decl_data
	mojomMethod.DeclData = translateDeclarationData(&method.DeclarationData)

	// parameters
	mojomMethod.Parameters = translateMojomStruct(method.Parameters)

	// response_params
	if method.ResponseParameters != nil {
		responseParams := translateMojomStruct(method.ResponseParameters)
		mojomMethod.ResponseParams = &responseParams
	}

	// ordinal
	mojomMethod.Ordinal = method.Ordinal
	return mojomMethod
}

func translateMojomEnum(enum *mojom.MojomEnum) *mojom_types.UserDefinedTypeEnumType {
	mojomEnum := mojom_types.UserDefinedTypeEnumType{}
	mojomEnum.Value.DeclData = translateDeclarationData(&enum.DeclarationData)
	for _, value := range enum.Values {
		mojomEnum.Value.Values = append(mojomEnum.Value.Values, translateEnumValue(value))
	}
	return &mojomEnum
}

func translateMojomUnion(union *mojom.MojomUnion) *mojom_types.UserDefinedTypeUnionType {
	mojomUnion := mojom_types.UserDefinedTypeUnionType{}
	mojomUnion.Value.DeclData = translateDeclarationData(&union.DeclarationData)
	for _, field := range union.Fields {
		mojomUnion.Value.Fields = append(mojomUnion.Value.Fields,
			translateUnionField(field))
	}
	return &mojomUnion
}

func translateUnionField(unionField mojom.UnionField) mojom_types.UnionField {
	outUnionField := mojom_types.UnionField{}
	outUnionField.DeclData = translateDeclarationData(&unionField.DeclarationData)
	outUnionField.Type = translateTypeRef(unionField.FieldType)
	outUnionField.Tag = unionField.Tag
	return outUnionField
}

// WARNING: Do not invoke this function on a UserDefinedValue of type BuiltInConstantValue because
// objects of those types do not have a type_key and do not correspond to a mojom_types.UserDefinedValue.
func translateUserDefinedValue(v mojom.UserDefinedValue) mojom_types.UserDefinedValue {
	switch t := v.(type) {
	case *mojom.UserDefinedConstant:
		return translateUserDefinedConstant(t)
	case *mojom.EnumValue:
		return &mojom_types.UserDefinedValueEnumValue{translateEnumValue(t)}
	case *mojom.BuiltInConstantValue:
		panic("Do not invoke translateUserDefinedValue on BuiltInConstantValue.")
	default:
		panic(fmt.Sprintf("Unexpected UserDefinedValue type %T", v))

	}
}

func translateUserDefinedConstant(t *mojom.UserDefinedConstant) *mojom_types.UserDefinedValueDeclaredConstant {
	declaredConstant := mojom_types.UserDefinedValueDeclaredConstant{}
	declaredConstant.Value.Type = translateTypeRef(t.DeclaredType())
	declaredConstant.Value.DeclData = *translateDeclarationData(&t.DeclarationData)
	declaredConstant.Value.Value = translateValueRef(t.ValueRef())
	// TODO(rudominer) implement UserDefinedValue.resolved_concrete_value.
	// declaredConstant.ResolvedConcreteValue =
	//     translateConcreteValue(t.ValueRef().ResolvedConcreteValue()))
	return &declaredConstant
}

func translateEnumValue(v *mojom.EnumValue) mojom_types.EnumValue {
	enumValue := mojom_types.EnumValue{}
	enumValue.DeclData = translateDeclarationData(&v.DeclarationData)
	enumValue.EnumTypeKey = v.EnumType().TypeKey()
	if v.ValueRef() != nil {
		enumValue.InitializerValue = translateValueRef(v.ValueRef())
	}
	enumValue.IntValue = v.ComputedIntValue
	return enumValue
}

func translateTypeRef(typeRef mojom.TypeRef) mojom_types.Type {
	switch t := typeRef.(type) {
	case mojom.SimpleType:
		return translateSimpleType(t)
	case mojom.StringType:
		return translateStringType(t)
	case mojom.HandleTypeRef:
		return translateHandleType(t)
	case mojom.ArrayTypeRef:
		return translateArrayType(&t)
	case *mojom.ArrayTypeRef:
		return translateArrayType(t)
	case mojom.MapTypeRef:
		return translateMapType(&t)
	case *mojom.MapTypeRef:
		return translateMapType(t)
	case *mojom.UserTypeRef:
		return translateUserTypeRef(t)
	default:
		panic(fmt.Sprintf("Unexpected TypeRef type %T", t))
	}
}

func translateSimpleType(simpleType mojom.SimpleType) *mojom_types.TypeSimpleType {
	var value mojom_types.SimpleType
	switch simpleType {
	case mojom.SimpleTypeBool:
		value = mojom_types.SimpleType_Bool
	case mojom.SimpleTypeDouble:
		value = mojom_types.SimpleType_Double
	case mojom.SimpleTypeFloat:
		value = mojom_types.SimpleType_Float
	case mojom.SimpleTypeInt8:
		value = mojom_types.SimpleType_InT8
	case mojom.SimpleTypeInt16:
		value = mojom_types.SimpleType_InT16
	case mojom.SimpleTypeInt32:
		value = mojom_types.SimpleType_InT32
	case mojom.SimpleTypeInt64:
		value = mojom_types.SimpleType_InT64
	case mojom.SimpleTypeUInt8:
		value = mojom_types.SimpleType_UinT8
	case mojom.SimpleTypeUInt16:
		value = mojom_types.SimpleType_UinT16
	case mojom.SimpleTypeUInt32:
		value = mojom_types.SimpleType_UinT32
	case mojom.SimpleTypeUInt64:
		value = mojom_types.SimpleType_UinT64
	}
	return &mojom_types.TypeSimpleType{value}
}

func translateStringType(stringType mojom.StringType) *mojom_types.TypeStringType {
	return &mojom_types.TypeStringType{mojom_types.StringType{stringType.Nullable()}}
}

func translateHandleType(handleType mojom.HandleTypeRef) *mojom_types.TypeHandleType {
	var kind mojom_types.HandleType_Kind
	switch handleType.HandleKind() {
	case mojom.HandleKindUnspecified:
		kind = mojom_types.HandleType_Kind_Unspecified
	case mojom.HandleKindMessagePipe:
		kind = mojom_types.HandleType_Kind_MessagePipe
	case mojom.HandleKindDataPipeConsumer:
		kind = mojom_types.HandleType_Kind_DataPipeConsumer
	case mojom.HandleKindDataPipeProducer:
		kind = mojom_types.HandleType_Kind_DataPipeProducer
	case mojom.HandleKindSharedBuffer:
		kind = mojom_types.HandleType_Kind_SharedBuffer
	}
	return &mojom_types.TypeHandleType{mojom_types.HandleType{handleType.Nullable(), kind}}
}

func translateArrayType(arrayType *mojom.ArrayTypeRef) *mojom_types.TypeArrayType {
	return &mojom_types.TypeArrayType{mojom_types.ArrayType{
		Nullable:    arrayType.Nullable(),
		FixedLength: int32(arrayType.FixedLength()),
		ElementType: translateTypeRef(arrayType.ElementType())}}
}

func translateMapType(mapType *mojom.MapTypeRef) *mojom_types.TypeMapType {
	return &mojom_types.TypeMapType{mojom_types.MapType{
		Nullable:  mapType.Nullable(),
		KeyType:   translateTypeRef(mapType.KeyType()),
		ValueType: translateTypeRef(mapType.ValueType())}}
}

func translateUserTypeRef(userType *mojom.UserTypeRef) *mojom_types.TypeTypeReference {
	typeKey := stringPointer(userType.ResolvedType().TypeKey())
	identifier := stringPointer(userType.Identifier())
	return &mojom_types.TypeTypeReference{mojom_types.TypeReference{
		Nullable:           userType.Nullable(),
		IsInterfaceRequest: userType.IsInterfaceRequest(),
		Identifier:         identifier,
		TypeKey:            typeKey}}
}

func translateValueRef(valueRef mojom.ValueRef) mojom_types.Value {
	switch valueRef := valueRef.(type) {
	case mojom.LiteralValue:
		return translateLiteralValue(valueRef)
	case *mojom.UserValueRef:
		return translateUserValueRef(valueRef)
	default:
		panic(fmt.Sprintf("Unexpected ValueRef type %T", valueRef))
	}
}

func translateLiteralValue(v mojom.LiteralValue) *mojom_types.ValueLiteralValue {
	var lv mojom_types.LiteralValue
	switch v.ValueType() {
	case mojom.SimpleTypeBool:
		lv = &mojom_types.LiteralValueBoolValue{v.Value().(bool)}
	case mojom.SimpleTypeDouble:
		lv = &mojom_types.LiteralValueDoubleValue{v.Value().(float64)}
	case mojom.SimpleTypeFloat:
		lv = &mojom_types.LiteralValueFloatValue{v.Value().(float32)}
	case mojom.SimpleTypeInt8:
		lv = &mojom_types.LiteralValueInt8Value{v.Value().(int8)}
	case mojom.SimpleTypeInt16:
		lv = &mojom_types.LiteralValueInt16Value{v.Value().(int16)}
	case mojom.SimpleTypeInt32:
		lv = &mojom_types.LiteralValueInt32Value{v.Value().(int32)}
	case mojom.SimpleTypeInt64:
		lv = &mojom_types.LiteralValueInt64Value{v.Value().(int64)}
	case mojom.SimpleTypeUInt8:
		lv = &mojom_types.LiteralValueUint8Value{v.Value().(uint8)}
	case mojom.SimpleTypeUInt16:
		lv = &mojom_types.LiteralValueUint16Value{v.Value().(uint16)}
	case mojom.SimpleTypeUInt32:
		lv = &mojom_types.LiteralValueUint32Value{v.Value().(uint32)}
	case mojom.SimpleTypeUInt64:
		lv = &mojom_types.LiteralValueUint64Value{v.Value().(uint64)}
	case mojom.StringLiteralType:
		lv = &mojom_types.LiteralValueStringValue{v.Value().(string)}
	default:
		panic(fmt.Sprintf("Unexpected literal value type %d", v.ValueType()))
	}
	return &mojom_types.ValueLiteralValue{lv}
}

func translateBuiltInConstantValue(t mojom.BuiltInConstantValue) *mojom_types.ValueBuiltinValue {
	builtInValue := mojom_types.ValueBuiltinValue{}
	switch t {
	case mojom.SimpleTypeFloat_INFINITY:
		builtInValue.Value = mojom_types.BuiltinConstantValue_FloatInfinity
	case mojom.SimpleTypeFloat_NEGATIVE_INFINITY:
		builtInValue.Value = mojom_types.BuiltinConstantValue_FloatNegativeInfinity
	case mojom.SimpleTypeFloat_NAN:
		builtInValue.Value = mojom_types.BuiltinConstantValue_FloatNan
	case mojom.SimpleTypeDouble_INFINITY:
		builtInValue.Value = mojom_types.BuiltinConstantValue_DoubleInfinity
	case mojom.SimpleTypeDouble_NEGATIVE_INFINITY:
		builtInValue.Value = mojom_types.BuiltinConstantValue_DoubleNegativeInfinity
	case mojom.SimpleTypeDouble_NAN:
		builtInValue.Value = mojom_types.BuiltinConstantValue_DoubleNan
	default:
		panic(fmt.Sprintf("Unrecognized BuiltInConstantValue %v", t))
	}
	return &builtInValue
}

func translateUserValueRef(r *mojom.UserValueRef) mojom_types.Value {
	switch t := r.ResolvedConcreteValue().(type) {
	case mojom.BuiltInConstantValue:
		return translateBuiltInConstantValue(t)
	default:
		valueKey := stringPointer(r.ResolvedDeclaredValue().ValueKey())
		return &mojom_types.ValueUserValueReference{mojom_types.UserValueReference{
			Identifier: r.Identifier(),
			ValueKey:   valueKey}}
		// We do not populate ResolvedConcreteValue because it is deprecated.
	}
}

func translateDeclarationData(d *mojom.DeclarationData) *mojom_types.DeclarationData {
	declData := mojom_types.DeclarationData{}

	// attributes field
	if d.Attributes() != nil {
		declData.Attributes = new([]mojom_types.Attribute)
		for _, attr := range d.Attributes().List {
			*(declData.Attributes) = append(*(declData.Attributes), translateMojomAttribute(&attr))
		}
	}

	// min_version field
	// TODO(rudominer) Eliminate the min_version field from struct DeclarationData

	// short_name field
	declData.ShortName = stringPointer(d.SimpleName())

	// full_identifier field
	declData.FullIdentifier = stringPointer(d.FullyQualifiedName())

	// declared_ordinal field
	if d.DeclaredOrdinal() < 0 {
		declData.DeclaredOrdinal = -1
	} else {
		declData.DeclaredOrdinal = int32(d.DeclaredOrdinal())
	}

	// declaration_order
	// TODO(rudominer) DeclarationOrder is currently not populated.
	declData.DeclarationOrder = -1

	// container_type_key
	containingType := d.ContainingType()
	if containingType != nil {
		switch containingType.(type) {
		case *mojom.MojomEnum:
			// We do not write the |container_type_key| field for an EnumValue
			// because the EnumValue already has the type_key of the Enum
			// in a different field.
			break
		default:
			declData.ContainerTypeKey = stringPointer(containingType.TypeKey())
		}
	}

	// source_file_info
	declData.SourceFileInfo = new(mojom_types.SourceFileInfo)
	declData.SourceFileInfo.FileName = d.OwningFile().CanonicalFileName
	if EmitLineAndColumnNumbers {
		declData.SourceFileInfo.LineNumber = d.LineNumber()
		declData.SourceFileInfo.ColumnNumber = d.ColumnNumber()
	}
	return &declData
}

// Returns nil if there are no contained declarations
func translateContainedDeclarations(container *mojom.DeclarationContainer) *mojom_types.ContainedDeclarations {
	if container.Enums == nil && container.Constants == nil {
		return nil
	}
	declarations := mojom_types.ContainedDeclarations{}
	if container.Enums != nil {
		declarations.Enums = new([]string)
		for _, enum := range container.Enums {
			*declarations.Enums = append(*declarations.Enums, enum.TypeKey())
		}
	}
	if container.Constants != nil {
		declarations.Constants = new([]string)
		for _, constant := range container.Constants {
			*declarations.Constants = append(*declarations.Constants, constant.ValueKey())
		}
	}
	return &declarations
}

func translateMojomAttribute(a *mojom.MojomAttribute) (attribute mojom_types.Attribute) {
	return mojom_types.Attribute{a.Key, translateLiteralValue(a.Value).Value}
}

// stringPointer is a convenience function for creating a pointer to a string whose value
// is the specified string. It may be used in situations where the compiler will
// not allow you to take the address of a string value directly, such as the
// return value of a function. It is necessary to create pointers to strings because
// that is how the Mojom type |string?| (i.e. nullable string) is represented in
// in the Mojom Go bindings.
func stringPointer(s string) *string {
	return &s
}
