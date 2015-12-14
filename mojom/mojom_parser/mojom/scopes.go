// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"fmt"
	"mojom/mojom_parser/lexer"
	"strings"
)

/*
This file contains data structures and functions used to describe scopes. A scope
is a named container in which named entities may be defined and in which the entity
corresponding to a name is looked up during the resolution phase of the parser.

The collection of all scopes form a tree in which each scope other than the
root scope is contained in a parent scope. Scopes are named using dotted
identifiers (like foo.bar.baz) and the name of a parent scope is always equal
to the name of the child scope minus the initial element. So the parent of
a scope named foo.bar.baz must be named bar.baz.

The lookup procedure for a name starts with a scope associated with the use of
the name and proceeds by searching up through the chain of parents until a
match is found. For details see the comments at RegisterType, RegisterValue,
LookupType and LookupValue.

There are two categories of scopes: lexical scopes and abstract module scopes.
Lexical scopes are associated with a lexical structure in a .mojom file. These
are the types of scopes in which a named entity may be defined. There
are four kinds of lexical scopes:
(1) A mojom file
(2) An interface
(3) A struct
(4) An enum

Not every type of named entity may be defined in every type of scope. For
example in an enum scope the only type of named entity allowed is an enum value.

An abstract module scope is not associated with any concrete lexical element of
a .mojom file but rather is used to represent the hierarchy of scopes that
exist implicitly becuase of the dotted names of mojom file modules. For example
if a .mojom file declares a module namespace of "foo.bar" this implicitly
creates three abstract module scopes named "foo.bar", "bar" and "". Abstract
module scopes are uniquely identified within a MojomDescriptor by their names.
The abstract module scope named "" is the unique root scope.
*/

type ScopeKind int

const (
	ScopeAbstractModule ScopeKind = iota
	ScopeEnum
	ScopeFileModule
	ScopeInterface
	ScopeStruct
)

func (k ScopeKind) String() string {
	switch k {
	case ScopeAbstractModule:
		return "abstract module"
	case ScopeEnum:
		return "enum"
	case ScopeFileModule:
		return "file module"
	case ScopeInterface:
		return "interface"
	case ScopeStruct:
		return "struct"
	default:
		panic(fmt.Sprintf("Unrecognized ScopeKind %d", k))
	}
}

type Scope struct {
	kind               ScopeKind
	shortName          string
	fullyQualifiedName string
	parentScope        *Scope
	typesByName        map[string]UserDefinedType
	valuesByName       map[string]UserDefinedValue
	// file is nil for abstract module scopes
	file *MojomFile
	// If this is an Interface or Struct scope then |containingType|
	// is the corresponding Interface or Struct.
	containingType UserDefinedType
	descriptor     *MojomDescriptor
}

func buildDottedName(prefix, suffix string) string {
	if len(prefix) == 0 {
		return suffix
	}
	return fmt.Sprintf("%s.%s", prefix, suffix)
}

// init is invoked by NewLexicalScope and NewAbstractModuleScope
func (scope *Scope) init(kind ScopeKind, shortName string,
	fullyQualifiedName string, parentScope *Scope, containingType UserDefinedType, descriptor *MojomDescriptor) {
	scope.kind = kind
	scope.shortName = shortName
	scope.fullyQualifiedName = fullyQualifiedName
	scope.parentScope = parentScope
	scope.typesByName = make(map[string]UserDefinedType)
	scope.valuesByName = make(map[string]UserDefinedValue)
	scope.containingType = containingType
	scope.descriptor = descriptor
}

// NewLexicalScope creates a new LexicalScope. The scopeKind must be
// one of the lexical kinds, not ScopeAbstractMoudle. The file must not be nil
// and it must not have a nil descriptor because the new scope will be
// embedded into the tree of scopes for that descriptor.
// The parent scope must be appropriate for the type of scope being created.
// When creating a ScopeFileModule parentScope should be nil: The
// parent scope will be set to an abstract module scope automatically.
//
// |containingType| must be non-nil just in case an Interface or Struct scope
// is being created and in that case it should be the Interface or Struct.
func NewLexicalScope(kind ScopeKind, parentScope *Scope, shortName string,
	file *MojomFile, containingType UserDefinedType) *Scope {
	scope := new(Scope)
	if file == nil {
		panic("The file must not be nil for a lexical scope.")
	}
	scope.file = file
	var fullyQualifiedName string

	switch kind {
	case ScopeFileModule:
		if parentScope != nil {
			panic("A file module lexical scope cannot have a parent lexical scope.")
		}
		if containingType != nil {
			panic("A file scope does not have a containing type.")
		}
		fullyQualifiedName = file.ModuleNamespace
		parentScope = file.Descriptor.getAbstractModuleScope(fullyQualifiedName)
	case ScopeInterface, ScopeStruct:
		if parentScope == nil || parentScope.kind != ScopeFileModule {
			panic("An interface or struct lexical scope must have a parent lexical scope of type FILE_MODULE.")
		}
		if containingType == nil {
			panic("An interface or struct scope must have a containing type.")
		}
		fullyQualifiedName = buildDottedName(parentScope.fullyQualifiedName, shortName)
	case ScopeEnum:
		if parentScope == nil || parentScope.kind == ScopeAbstractModule {
			panic("An enum lexical scope must have a parent lexical scope not an ABSTRACT_MODULE scope.")
		}
		if containingType == nil {
			panic("An enum scope must have a containing type.")
		}
		fullyQualifiedName = buildDottedName(parentScope.fullyQualifiedName, shortName)
	case ScopeAbstractModule:
		panic("The type of a lexical scope cannot be ABSTRACT_MODULE.")
	default:
		panic(fmt.Sprintf("Unrecognized ScopeKind %d", kind))
	}

	scope.init(kind, shortName, fullyQualifiedName, parentScope, containingType, file.Descriptor)

	return scope
}

// Creates a new abstract module scope. This is not invoked directly by the parsing
// code but rather is invoked by the methods of MojomDescriptor to lazily create
// abstract module scopes when they are needed.
func NewAbstractModuleScope(fullyQualifiedName string, descriptor *MojomDescriptor) *Scope {
	scope := new(Scope)
	var parentScope *Scope = nil
	shortName := fullyQualifiedName
	if len(fullyQualifiedName) > 0 {
		splitName := strings.Split(fullyQualifiedName, ".")
		numSegments := len(splitName)
		shortName = splitName[numSegments-1]

		if numSegments > 1 {
			parentFullyQualifiedName := strings.Join(splitName[0:numSegments-1], ".")
			parentScope = descriptor.getAbstractModuleScope(parentFullyQualifiedName)
		} else {
			parentScope = descriptor.getGlobalScobe()
		}
	}
	scope.init(ScopeAbstractModule, shortName, fullyQualifiedName, parentScope, nil, descriptor)
	return scope
}

func (s *Scope) Parent() *Scope {
	return s.parentScope
}

func (s *Scope) String() string {
	if s.fullyQualifiedName == "" {
		return "Global"
	}
	fileNameString := ""
	if s.file != nil {
		fileNameString = fmt.Sprintf(" in %s", s.file.CanonicalFileName)
	}
	return fmt.Sprintf("%s %s%s", s.kind, s.shortName, fileNameString)
}

type DuplicateNameError interface {
	error

	// NameToken() returns the token corresponding to the name of the
	// duplicate object.
	NameToken() lexer.Token

	// The MojomFile containing the duplicate definition.
	OwningFile() *MojomFile
}

type DuplicateNameErrorBase struct {
	nameToken  lexer.Token
	owningFile *MojomFile
}

func (e *DuplicateNameErrorBase) NameToken() lexer.Token {
	return e.nameToken
}

func (e *DuplicateNameErrorBase) OwningFile() *MojomFile {
	return e.owningFile
}

type DuplicateTypeNameError struct {
	DuplicateNameErrorBase
	existingType UserDefinedType
}

func (e *DuplicateTypeNameError) Error() string {
	message := fmt.Sprintf("Duplicate definition for name %q. "+
		"The fully-qualified name of this type would be the same as "+
		"an existing type definition: %s %s in %s.", e.nameToken.Text,
		e.existingType.Kind(), e.existingType.FullyQualifiedName(), e.existingType.Scope())
	return UserErrorMessage(e.owningFile, e.nameToken, message)
}

type DuplicateValueNameError struct {
	DuplicateNameErrorBase
	existingValue UserDefinedValue
}

func (e *DuplicateValueNameError) Error() string {
	message := fmt.Sprintf("Duplicate definition for name %q. "+
		"The fully-qualified name of this value would be the same as "+
		"an existing value definition: %s %s in %s.", e.nameToken.Text,
		e.existingValue.Kind(), e.existingValue.FullyQualifiedName(), e.existingValue.Scope())
	return UserErrorMessage(e.owningFile, e.nameToken, message)
}

// registerTypeWithNamePrefix is a recursive helper method used by RegisterType.
func (scope *Scope) registerTypeWithNamePrefix(userDefinedType UserDefinedType, namePrefix string) DuplicateNameError {
	if scope == nil {
		panic("scope is nil")
	}
	if scope.typesByName == nil {
		panic("Init() must be called for this Scope before this method may be invoked.")
	}
	registrationName := namePrefix + userDefinedType.SimpleName()
	if existingType := scope.typesByName[registrationName]; existingType != nil {
		return &DuplicateTypeNameError{
			DuplicateNameErrorBase{nameToken: userDefinedType.NameToken(), owningFile: scope.file},
			existingType}
	}
	scope.typesByName[registrationName] = userDefinedType
	if scope.parentScope != nil {
		if scope.kind == ScopeFileModule {
			if scope.parentScope.kind != ScopeAbstractModule {
				panic("The parent scope of a file module should always be an abstract module.")
			}

		} else {
			// We extend the name prefix by prepending the name of the current
			// scope. But notice that we do not do this in the special case that
			// the current scope is a ScopeFileModule. This is becuase the
			// parent scope of a file module scope is an abstract module
			// scope with the same name.
			namePrefix = buildDottedName(scope.shortName, namePrefix)
		}
		if err := scope.parentScope.registerTypeWithNamePrefix(userDefinedType,
			namePrefix); err != nil {
			return err
		}
	}
	return nil
}

// registerValueWithNamePrefix is a recursive helper method used by RegisterValue.
func (scope *Scope) registerValueWithNamePrefix(value UserDefinedValue, namePrefix string) DuplicateNameError {
	registrationName := namePrefix + value.SimpleName()
	if existingVal := scope.valuesByName[registrationName]; existingVal != nil {
		return &DuplicateValueNameError{
			DuplicateNameErrorBase{nameToken: value.NameToken(), owningFile: scope.file},
			existingVal}
	}
	scope.valuesByName[registrationName] = value
	if scope.parentScope != nil {
		if scope.kind == ScopeFileModule {
			if scope.parentScope.kind != ScopeAbstractModule {
				panic("The parent scope of a file module should always be an abstract module.")
			}

		} else {
			// We extend the name prefix by prepending the name of the current
			// scope. But notice that we do not do this in the special case that
			// the current scope is a ScopeFileModule. This is becuase the
			// parent scope of a file module scope is an abstract module
			// scope with the same name.
			namePrefix = buildDottedName(scope.shortName, namePrefix)
		}
		if err := scope.parentScope.registerValueWithNamePrefix(
			value, namePrefix); err != nil {
			return err
		}
	}
	return nil
}

// RegisterType registers a UserDefinedType in this scope and the chain of
// its ancestor scopes. This registration process is the key to our name
// resolution algorithm. The UserDefinedType is registered in this scope
// using its given short name, and then it is registered in the ancestor
// scopes using progressively longer qualified names obtained by prepending
// the simple name of the child scope. The UserDefinedType will be registered in
// the root scope using its fully qualified name.
//
// For example, suppose we are registering an EnumType named Joe in an interface
// named Baz in a module named foo.bar. The following chart describes the five
// scopes into which Joe will be registered and the names with which it
// will be registered in each of the scopes.
//
// root scope:              ""             registration name: foo.bar.Baz.Joe
// abstract module scope:   "foo"          registration name: bar.Baz.Joe
// abstract module scope:   "foo.bar"      registration name: Bazz.Joe
// file lexical scope:      "foo.bar"      registration name: Bazz.Joe
// interface lexical scope: "foo.bar.Baz"  registration name: Joe
func (scope *Scope) RegisterType(userDefinedType UserDefinedType) DuplicateNameError {
	if scope == nil {
		panic("scope is nil")
	}
	return scope.registerTypeWithNamePrefix(userDefinedType, "")
}

// RegisterValue registers a UserDefinedValue in this scope and the chain of
// its ancestor scopes. This registration process is the key to our name
// resolution algorithm. The UserDefinedValue is registered in this scope
// using its given short name, and then it is registered in the ancestor
// scopes using progressively longer qualified names obtained by prepending
// the simple name of the child scope. The UserDefinedValue will be registered in
// the root scope using its fully qualified name.
//
// For example, suppose we are registering an EnumValue named FROG in an Enum
// named Joe in an interface named Baz in a module named foo.bar. The following
// chart describes the six scopes into which FROG will be registered and the
// names with which it will be registered in each of the scopes.
//
// root scope:              ""                 registration name: foo.bar.Baz.Joe.FROG
// abstract module scope:   "foo"              registration name: bar.Baz.Joe.FROG
// abstract module scope:   "foo.bar"          registration name: Bazz.Joe.FROG
// file lexical scope:      "foo.bar"          registration name: Bazz.Joe.FROG
// interface lexical scope: "foo.bar.Baz"      registration name: Joe.FROG
// enum lexical scope:      "foo.bar.Baz.Joe"  registration name: FROG
func (scope *Scope) RegisterValue(value UserDefinedValue) DuplicateNameError {
	return scope.registerValueWithNamePrefix(value, "")
}

// LookupType searches for a UserDefinedType registered in this scope with the
// given name and then succesively in the chain of the ancestor scopes of this
// scope until a UserDefinedType registered with the given name is found.
// Returns nil if the lookp fails.
func (scope *Scope) LookupType(name string) UserDefinedType {
	if userDefinedType, ok := scope.typesByName[name]; ok {
		return userDefinedType
	}
	if scope.parentScope == nil {
		return nil
	}
	return scope.parentScope.LookupType(name)
}

// LookupValue searches for a UserDefinedValue registered in this scope  with the
// given name and then succesively in the chain of the ancestor scopes of this
// scope until a UserDefinedValue registered with the given name is found.
//
// If the lookup described above does not succeed and it is possible that the
// lookup is attempting to lookup an enum value then a second attempt is made
// to find the enum value using a fully qualified name. More precisely, if
// the given name is a simple name and the given assigneeType has resolved
// to an EnumType then LookupValue is invoked again using the name formed
// by concatenating the fully-qualified name of the EnumType with the given
// simple name. This procedure allows an enum value to be referenced using
// only its simple name when it is clear from context to which enum the value
// belongs.
//
// Returns nil if the lookp fails.
func (scope *Scope) LookupValue(name string, assigneeType TypeRef) UserDefinedValue {
	if userDefinedValue, ok := scope.valuesByName[name]; ok {

		return userDefinedValue
	}
	if scope.parentScope == nil {
		return nil
	}
	resolvedValue := scope.parentScope.LookupValue(name, nil)

	// If we have been unable to resolve a value reference we try a different strategy.
	// If the assigneeType is an enum and the name is a simple name then we will try to
	// interpret the name as the name of an enum value from the assigneeType enum.
	if resolvedValue == nil && assigneeType != nil && assigneeType.TypeRefKind() == TypeKindUserDefined {
		userTypeRef, ok := assigneeType.(*UserTypeRef)
		if !ok {
			panic(fmt.Sprintf("Type of assigneeType is %T", assigneeType))
		}
		if userTypeRef.ResolvedType() != nil && userTypeRef.ResolvedType().Kind() == UserDefinedTypeKindEnum {
			if !strings.ContainsRune(name, '.') {
				name = userTypeRef.ResolvedType().FullyQualifiedName() + "." + name
				return scope.LookupValue(name, nil)
			}
		}
	}
	return resolvedValue
}
