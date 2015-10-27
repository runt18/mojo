// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"fmt"
)

// This file contains the types MojomFile and MojomDescriptor. These are the
// structures that are generated during parsing and then serialized and
// passed on to the backend of the Mojom Compiler.

///////////////////////////////////////////////////////////////////////
/// Type MojomFile
/// //////////////////////////////////////////////////////////////////

// A MojomFile represents the result of parsing a single .mojom file.
type MojomFile struct {
	// The associated MojomDescriptor
	Descriptor *MojomDescriptor

	// The |CanonicalFileName| is the unique identifier for this module
	// within the |MojomFilesByName| field of |Descriptor|
	CanonicalFileName string

	// The module namespace is the identifier declared via the "module"
	// declaration in the .mojom file.
	ModuleNamespace string

	// Attributes declared in the Mojom file at the module level.
	Attributes *Attributes

	// The set of other MojomFiles imported by this one. The corresponding
	// MojomFile may be obtained from the |MojomFilesByName| field of
	// |Descriptor| using the |CanonicalFileName| field of ImportedFile.
	Imports []*ImportedFile

	// importsBySpecifiedName facilitates the lookup of an ImportedFile given its |SpecifiedName|
	importsBySpecifiedName map[string]*ImportedFile

	// The lexical scope corresponding to this file.
	FileScope *Scope

	// These are lists of *top-level* types  and constants defined in the file;
	// they do not include enums and constants defined within structs
	// and interfaces. The contained enums and constant may be found in the
	// |Enums| and |Constants|  fields of their containing object.
	Interfaces []*MojomInterface
	Structs    []*MojomStruct
	Unions     []*MojomUnion
	Enums      []*MojomEnum
	Constants  []*UserDefinedConstant
}

// An ImportedFile represents an element of the "import" list of a .mojom file.
type ImportedFile struct {
	// The name as specified in the import statement.
	SpecifiedName string

	// The canonical file name of the imported file. This string is the unique identifier for the
	// corresponding MojomFile object. Note that when a .mojom file is first parsed
	// only the |SpecifiedFileName| of each of its imports is populated because we don't yet know the
	// canonical file names of the imported files. It is only when an imported
	// file itself is processed that |CanonicalFileName| field is populated within each of the
	// importing MojomFiles.
	CanonicalFileName string
}

func NewMojomFile(fileName string, descriptor *MojomDescriptor) *MojomFile {
	mojomFile := new(MojomFile)
	mojomFile.CanonicalFileName = fileName
	mojomFile.Descriptor = descriptor
	mojomFile.ModuleNamespace = ""
	mojomFile.Imports = make([]*ImportedFile, 0)
	mojomFile.importsBySpecifiedName = make(map[string]*ImportedFile)
	mojomFile.Interfaces = make([]*MojomInterface, 0)
	mojomFile.Structs = make([]*MojomStruct, 0)
	mojomFile.Unions = make([]*MojomUnion, 0)
	mojomFile.Enums = make([]*MojomEnum, 0)
	mojomFile.Constants = make([]*UserDefinedConstant, 0)
	return mojomFile
}

func (f *MojomFile) String() string {
	s := fmt.Sprintf("file name: %s\n", f.CanonicalFileName)
	s += fmt.Sprintf("module: %s\n", f.ModuleNamespace)
	s += fmt.Sprintf("attributes: %s\n", f.Attributes)
	s += fmt.Sprintf("imports: %s\n", f.Imports)
	s += fmt.Sprintf("interfaces: %s\n", f.Interfaces)
	s += fmt.Sprintf("structs: %s\n", f.Structs)
	s += fmt.Sprintf("enums: %s\n", f.Enums)
	s += fmt.Sprintf("constants: %s\n", f.Constants)
	return s
}

func (f *MojomFile) SetModuleNamespace(namespace string) *Scope {
	f.ModuleNamespace = namespace
	f.FileScope = NewLexicalScope(ScopeFileModule, nil, namespace, f)
	return f.FileScope
}

func (f *MojomFile) AddImport(specifiedFileName string) {
	importedFile := new(ImportedFile)
	importedFile.SpecifiedName = specifiedFileName
	f.Imports = append(f.Imports, importedFile)
	f.importsBySpecifiedName[specifiedFileName] = importedFile
}

// SetCanonicalImportName sets the |CanonicalFileName| field of the |ImportedFile|
// with the given |SpecifiedName|. This method will usually be invoked later than
// the other methods in this file becuase it is only when the imported file itself
// is processed that we discover its canonical name.
func (f *MojomFile) SetCanonicalImportName(specifiedName, canoncialName string) {
	importedFile, ok := f.importsBySpecifiedName[specifiedName]
	if !ok {
		panic(fmt.Sprintf("There is no imported file with the specifiedName '%s'.", specifiedName))
	}
	importedFile.CanonicalFileName = canoncialName
}

func (f *MojomFile) AddInterface(mojomInterface *MojomInterface) *DuplicateNameError {
	f.Interfaces = append(f.Interfaces, mojomInterface)
	return mojomInterface.RegisterInScope(f.FileScope)
}

func (f *MojomFile) AddStruct(mojomStruct *MojomStruct) *DuplicateNameError {
	f.Structs = append(f.Structs, mojomStruct)
	return mojomStruct.RegisterInScope(f.FileScope)
}

func (f *MojomFile) AddEnum(mojomEnum *MojomEnum) *DuplicateNameError {
	f.Enums = append(f.Enums, mojomEnum)
	return mojomEnum.RegisterInScope(f.FileScope)
}

func (f *MojomFile) AddUnion(mojomUnion *MojomUnion) *DuplicateNameError {
	f.Unions = append(f.Unions, mojomUnion)
	return mojomUnion.RegisterInScope(f.FileScope)
}

func (f *MojomFile) AddConstant(declaredConst *UserDefinedConstant) *DuplicateNameError {
	f.Constants = append(f.Constants, declaredConst)
	return declaredConst.RegisterInScope(f.FileScope)
}

//////////////////////////////////////////////////////////////////
/// type MojomDescriptor
/// //////////////////////////////////////////////////////////////

// A MojomDescriptor is the central object being populated by the frontend of
// the Mojom compiler. The same instance of MojomDescriptor is passed to each
// of the instances of Parser that are created by the ParseDriver while parsing
// a graph of Mojom files.  The output of ParserDriver.ParseFiles() is a
// ParseResult the main field of which is a MojomDescriptor. The MojomDescriptor
// is then serialized and passed to the backend of the Mojom compiler.
type MojomDescriptor struct {
	// All of the UserDefinedTypes keyed by type key
	TypesByKey map[string]UserDefinedType

	// All of the UserDefinedValues keyed by value key
	ValuesByKey map[string]UserDefinedValue

	// All of the MojomFiles in the order they were visited.
	mojomFiles []*MojomFile

	// All of the MojomFiles keyed by CanonicalFileName
	MojomFilesByName map[string]*MojomFile

	// The abstract module namespace scopes keyed by scope name. These are
	// the scopes that are not lexical scopes (i.e. files, structs, interfaces)
	// but rather the ancestor's of the file scopes that are implicit in the
	// dotted name of the file's module namespace. For example if a file's
	// module namespace is "foo.bar" then the chain of ancestors of the
	// file scope is as follows:
	// [file "foo.bar"] -> [module "foo.bar"] -> [module "foo"] -> [module ""]
	// The field |abstractScopesByName| will contain the last three of these
	// scopes but not the first. The last scope [module ""] is called the
	// global scope. The reason for both a [file "foo.bar"] and a
	// [module "foo.bar"] is that multiple files might have a module namespace
	// that is a descendent of [module "foo.bar"].
	abstractScopesByName map[string]*Scope

	// When new type and value references are encountered during parsing they
	// are added to these slices. After parsing completes the resolution
	// step attempts to resolve all of these references. If these slices are
	// not empty by the time ParserDriver.ParseFiles() completes it means that
	// there are unresolved references in the .mojom files.
	unresolvedTypeReferences  []*UserTypeRef
	unresolvedValueReferences []*UserValueRef
}

func NewMojomDescriptor() *MojomDescriptor {
	descriptor := new(MojomDescriptor)

	descriptor.TypesByKey = make(map[string]UserDefinedType)
	descriptor.ValuesByKey = make(map[string]UserDefinedValue)
	descriptor.mojomFiles = make([]*MojomFile, 0)
	descriptor.MojomFilesByName = make(map[string]*MojomFile)
	descriptor.abstractScopesByName = make(map[string]*Scope)
	// The global namespace scope.
	descriptor.abstractScopesByName[""] = NewAbstractModuleScope("", descriptor)

	descriptor.unresolvedTypeReferences = make([]*UserTypeRef, 0)
	descriptor.unresolvedValueReferences = make([]*UserValueRef, 0)
	return descriptor
}

func (d *MojomDescriptor) getAbstractModuleScope(fullyQualifiedName string) *Scope {
	if scope, ok := d.abstractScopesByName[fullyQualifiedName]; ok {
		return scope
	}
	scope := NewAbstractModuleScope(fullyQualifiedName, d)
	d.abstractScopesByName[fullyQualifiedName] = scope
	return scope
}

func (d *MojomDescriptor) getGlobalScobe() *Scope {
	return d.abstractScopesByName[""]
}

func (d *MojomDescriptor) AddMojomFile(fileName string) *MojomFile {
	mojomFile := NewMojomFile(fileName, d)
	mojomFile.Descriptor = d
	d.mojomFiles = append(d.mojomFiles, mojomFile)
	if _, ok := d.MojomFilesByName[mojomFile.CanonicalFileName]; ok {
		panic(fmt.Sprintf("The file %v has already been processed.", mojomFile.CanonicalFileName))
	}
	d.MojomFilesByName[mojomFile.CanonicalFileName] = mojomFile
	return mojomFile
}

func (d *MojomDescriptor) RegisterUnresolvedTypeReference(typeReference *UserTypeRef) {
	d.unresolvedTypeReferences = append(d.unresolvedTypeReferences, typeReference)
}

func (d *MojomDescriptor) RegisterUnresolvedValueReference(valueReference *UserValueRef) {
	d.unresolvedValueReferences = append(d.unresolvedValueReferences, valueReference)
}

func (d *MojomDescriptor) ContainsFile(fileName string) bool {
	_, ok := d.MojomFilesByName[fileName]
	return ok
}

/////////////////////////////////////////
/// Type and Value Resolution
////////////////////////////////////////

// Resolve() should be invoked after all of the parsing has been done. It
// attempts to resolve all of the entries in |d.unresolvedTypeReferences| and
// |d.unresolvedValueReferences|. Returns a non-nil error if there are any
// remaining unresolved references or if after resolution it was discovered
// that a type or value was used in an inappropriate way.
func (d *MojomDescriptor) Resolve() error {
	// Resolve the types
	unresolvedTypeReferences, err := d.resolveTypeReferences()
	if err != nil {
		// For one of the type references we discovered after resolution that
		// the resolved type was used in an inappropriate way.
		return err
	}
	numUnresolvedTypeReferences := len(unresolvedTypeReferences)

	// Resolve the values
	unresolvedValueReferences, err := d.resolveValueReferences()
	if err != nil {
		// For one of the value references we discovered after resolution that
		// the resolved value was used in an inappropriate way.
		return err
	}
	numUnresolvedValueReferences := len(unresolvedValueReferences)
	// Because values may be defined in terms of user-defined constants which
	// may themselves be defined in terms of other user-defined constants,
	// we may have to perform the value resolution step multiple times in
	// order to propogage concrete values to all declarations. To make sure that
	// this process terminates we keep iterating only as long as the number
	// of unresolved value references decreases.
	for numUnresolvedValueReferences > 0 {
		unresolvedValueReferences, _ = d.resolveValueReferences()
		if len(unresolvedValueReferences) < numUnresolvedValueReferences {
			numUnresolvedValueReferences = len(unresolvedValueReferences)
		} else {
			break
		}
	}

	d.unresolvedTypeReferences = unresolvedTypeReferences[0:numUnresolvedTypeReferences]
	d.unresolvedValueReferences = unresolvedValueReferences[0:numUnresolvedValueReferences]

	if numUnresolvedTypeReferences+numUnresolvedValueReferences == 0 {
		return nil
	}

	errorMessage := "There are still some unresolved references.\n"
	if numUnresolvedTypeReferences > 0 {
		errorMessage += "\nNo defintion found for the following types:\n"
		errorMessage += "-------------------------------------------------------\n"
		for _, ref := range d.unresolvedTypeReferences {
			errorMessage += fmt.Sprintf("%s\n", ref.LongString())
		}
	}
	if numUnresolvedValueReferences > 0 {
		errorMessage += "\nNo defintion found for the following values:\n"
		errorMessage += "-----------------------------------------------------------\n"
		for _, ref := range d.unresolvedValueReferences {
			errorMessage += fmt.Sprintf("%s\n", ref.LongString())
		}
	}

	return fmt.Errorf(errorMessage)
}

func (d *MojomDescriptor) resolveTypeReferences() (unresolvedReferences []*UserTypeRef, postResolutionValidationError error) {
	unresolvedReferences = make([]*UserTypeRef, len(d.unresolvedTypeReferences))
	numUnresolved := 0
	for _, ref := range d.unresolvedTypeReferences {
		if ref != nil {
			if !d.resolveTypeRef(ref) {
				unresolvedReferences[numUnresolved] = ref
				numUnresolved++
			} else {
				if postResolutionValidationError = ref.validateAfterResolution(); postResolutionValidationError != nil {
					break
				}
			}
		}
	}
	unresolvedReferences = unresolvedReferences[0:numUnresolved]
	return
}

func (d *MojomDescriptor) resolveValueReferences() (unresolvedReferences []*UserValueRef, postResolutionValidationError error) {
	unresolvedReferences = make([]*UserValueRef, len(d.unresolvedValueReferences))
	numUnresolved := 0
	for _, ref := range d.unresolvedValueReferences {
		if ref != nil {
			if !d.resolveValueRef(ref) {
				unresolvedReferences[numUnresolved] = ref
				numUnresolved++
			} else {
				if postResolutionValidationError = ref.validateAfterResolution(); postResolutionValidationError != nil {
					break
				}
			}
		}
	}
	unresolvedReferences = unresolvedReferences[0:numUnresolved]
	return
}

func (d *MojomDescriptor) resolveTypeRef(ref *UserTypeRef) (success bool) {
	ref.resolvedType = ref.scope.LookupType(ref.identifier)
	return ref.resolvedType != nil
}

// There are two steps to resolving a value. First resolve the identifier to
// to a target declaration, then resolve the target declaration to a
// concrte value.
func (d *MojomDescriptor) resolveValueRef(ref *UserValueRef) (resolved bool) {
	// Step 1: Find resolvedDeclaredValue
	if ref.resolvedDeclaredValue == nil {
		userDefinedValue := ref.scope.LookupValue(ref.identifier, ref.assigneeType)
		if userDefinedValue == nil {
			lookupValue, ok := LookupBuiltInConstantValue(ref.identifier)
			if !ok {
				return false
			}
			userDefinedValue = lookupValue
		}
		ref.resolvedDeclaredValue = userDefinedValue
	}

	// Step 2: Find resolvedConcreteValue.
	switch value := ref.resolvedDeclaredValue.(type) {
	case *UserDefinedConstant:
		// The identifier resolved to a user-declared constant. We use
		// the (possibly nil) resolved value of that constant as
		// resolvedConcreteValue. Since this may be nil it is possible that
		// ref is still unresolved.
		ref.resolvedConcreteValue = value.valueRef.ResolvedConcreteValue()
	case *EnumValue:
		// The identifier resolved to an enum value. We use the enum value
		// itself (not the integer value of the enum value) as the
		// resolvedConcreteValue. Since this cannot be nil we know that
		// ref is now fully resolved.
		ref.resolvedConcreteValue = value
	case *BuiltInConstantValue:
		// The identifier resolved to a built-in. We use the built-in value
		// itself (not the integer value of the enum value) as the
		// resolvedConcreteValue. Since this cannot be nil we know that
		// ref is now fully resolved.
		ref.resolvedConcreteValue = value
	default:
		panic("ref.resolvedDeclaredValue is neither a DelcaredConstant, an EnumValue, nor a BuiltInConstantValue.")
	}

	return ref.resolvedConcreteValue != nil
}

//////////////////////////////////////
// Debug printing of a MojomDescriptor
//////////////////////////////////////

func (d *MojomDescriptor) debugPrintMojomFiles() (s string) {
	for _, f := range d.mojomFiles {
		s += fmt.Sprintf("\n%s\n", f)
	}
	return
}

func (d *MojomDescriptor) debugPrintUnresolvedTypeReference() (s string) {
	for _, r := range d.unresolvedTypeReferences {
		s += fmt.Sprintf("%s\n", r.LongString())
	}
	return
}

func debugPrintTypeMap(m map[string]UserDefinedType) (s string) {
	for key, value := range m {
		s += fmt.Sprintf("%s : %s %s\n", key, value.SimpleName(), value.Kind())
	}
	return
}

func debugPrintValueMap(m map[string]UserDefinedValue) (s string) {
	for key, value := range m {
		s += fmt.Sprintf("%s : %s\n", key, value.SimpleName())
	}
	return
}

func (d *MojomDescriptor) String() string {
	message :=
		`
TypesByKey:
----------------
%s
ValuesByKey:
----------------
%s
Files:
---------------
%s
`
	return fmt.Sprintf(message, debugPrintTypeMap(d.TypesByKey), debugPrintValueMap(d.ValuesByKey), d.debugPrintMojomFiles())
}

///////////////////////////////////////////////////////////////////////
/// Miscelleneous utilities
/// //////////////////////////////////////////////////////////////////

func computeTypeKey(fullyQualifiedName string) (typeKey string) {
	if typeKey, ok := fqnToTypeKey[fullyQualifiedName]; ok == true {
		return typeKey
	}
	typeKey = fmt.Sprintf("%d", nextKey)
	nextKey++
	fqnToTypeKey[fullyQualifiedName] = typeKey
	return
}

var fqnToTypeKey map[string]string
var nextKey int

func init() {
	fqnToTypeKey = make(map[string]string)
}
