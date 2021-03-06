// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is autogenerated by:
//     mojo/public/tools/bindings/mojom_bindings_generator.py
// For:
//     mojo/public/interfaces/bindings/mojom_files.mojom
//

package mojom_files

import (
	fmt "fmt"
	bindings "mojo/public/go/bindings"
	mojom_types "mojom/mojom_parser/generated/mojom_types"
	sort "sort"
)

// These IDs are the Mojom Identifiers / Type Keys.
// Mojom libraries importing this one will use these identifiers when building
// TypeReference objects.
var ID_mojom_files_MojomFile__ string = "mojom_files_MojomFile__"
var ID_mojom_files_MojomFileGraph__ string = "mojom_files_MojomFileGraph__"
var ID_mojom_files_KeysByType__ string = "mojom_files_KeysByType__"

var mojom_filesDesc__ = make(map[string]mojom_types.UserDefinedType)

func init() {
	mojom_filesDesc__["mojom_files_MojomFile__"] = &mojom_types.UserDefinedTypeStructType{
		Value: mojom_files_MojomFile__(),
	}
	mojom_filesDesc__["mojom_files_MojomFileGraph__"] = &mojom_types.UserDefinedTypeStructType{
		Value: mojom_files_MojomFileGraph__(),
	}
	mojom_filesDesc__["mojom_files_KeysByType__"] = &mojom_types.UserDefinedTypeStructType{
		Value: mojom_files_KeysByType__(),
	}

}
func GetAllMojomTypeDefinitions() map[string]mojom_types.UserDefinedType {
	return mojom_filesDesc__
}

type MojomFile struct {
	FileName             string
	SpecifiedFileName    *string
	ModuleNamespace      *string
	Attributes           *[]mojom_types.Attribute
	Imports              *[]string
	DeclaredMojomObjects KeysByType
}

func (s *MojomFile) Encode(encoder *bindings.Encoder) error {
	encoder.StartStruct(48, 0)
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	if err := encoder.WriteString(s.FileName); err != nil {
		return err
	}
	if s.SpecifiedFileName == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		if err := encoder.WriteString((*s.SpecifiedFileName)); err != nil {
			return err
		}
	}
	if s.ModuleNamespace == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		if err := encoder.WriteString((*s.ModuleNamespace)); err != nil {
			return err
		}
	}
	if s.Attributes == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.Attributes))), 64)
		for _, elem0 := range *s.Attributes {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := elem0.Encode(encoder); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if s.Imports == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.Imports))), 64)
		for _, elem0 := range *s.Imports {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem0); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	if err := s.DeclaredMojomObjects.Encode(encoder); err != nil {
		return err
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
	return nil
}

var mojomFile_Versions []bindings.DataHeader = []bindings.DataHeader{
	bindings.DataHeader{56, 0},
}

func (s *MojomFile) Decode(decoder *bindings.Decoder) error {
	header, err := decoder.StartStruct()
	if err != nil {
		return err
	}
	index := sort.Search(len(mojomFile_Versions), func(i int) bool {
		return mojomFile_Versions[i].ElementsOrVersion >= header.ElementsOrVersion
	})
	if index < len(mojomFile_Versions) {
		if mojomFile_Versions[index].ElementsOrVersion > header.ElementsOrVersion {
			index--
		}
		expectedSize := mojomFile_Versions[index].Size
		if expectedSize != header.Size {
			return &bindings.ValidationError{bindings.UnexpectedStructHeader,
				fmt.Sprintf("invalid struct header size: should be %d, but was %d", expectedSize, header.Size),
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
		} else {
			value0, err := decoder.ReadString()
			if err != nil {
				return err
			}
			s.FileName = value0
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.SpecifiedFileName = nil
		} else {
			s.SpecifiedFileName = new(string)
			value0, err := decoder.ReadString()
			if err != nil {
				return err
			}
			(*s.SpecifiedFileName) = value0
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.ModuleNamespace = nil
		} else {
			s.ModuleNamespace = new(string)
			value0, err := decoder.ReadString()
			if err != nil {
				return err
			}
			(*s.ModuleNamespace) = value0
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.Attributes = nil
		} else {
			s.Attributes = new([]mojom_types.Attribute)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.Attributes) = make([]mojom_types.Attribute, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					if err := (*s.Attributes)[i0].Decode(decoder); err != nil {
						return err
					}
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.Imports = nil
		} else {
			s.Imports = new([]string)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.Imports) = make([]string, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					value1, err := decoder.ReadString()
					if err != nil {
						return err
					}
					(*s.Imports)[i0] = value1
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
		} else {
			if err := s.DeclaredMojomObjects.Decode(decoder); err != nil {
				return err
			}
		}
	}
	if err := decoder.Finish(); err != nil {
		return err
	}
	return nil
}

// String names and labels used by the MojomStruct types.
var (
	structName_MojomFile                           = "MojomFile"
	structFullIdentifier_MojomFile                 = "mojo.bindings.types.MojomFile"
	structFieldName_MojomFile_FileName             = "FileName"
	structFieldName_MojomFile_SpecifiedFileName    = "SpecifiedFileName"
	structFieldName_MojomFile_ModuleNamespace      = "ModuleNamespace"
	structFieldName_MojomFile_Attributes           = "Attributes"
	structFieldName_MojomFile_Imports              = "Imports"
	structFieldName_MojomFile_DeclaredMojomObjects = "DeclaredMojomObjects"
)

func mojom_files_MojomFile__() mojom_types.MojomStruct {
	return mojom_types.MojomStruct{
		DeclData: &mojom_types.DeclarationData{
			ShortName:      &structName_MojomFile,
			FullIdentifier: &structFullIdentifier_MojomFile,
		}, Fields: []mojom_types.StructField{mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFile_FileName,
			},
			Type: &mojom_types.TypeStringType{mojom_types.StringType{false}},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFile_SpecifiedFileName,
			},
			Type: &mojom_types.TypeStringType{mojom_types.StringType{true}},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFile_ModuleNamespace,
			},
			Type: &mojom_types.TypeStringType{mojom_types.StringType{true}},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFile_Attributes,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeTypeReference{
					Value: mojom_types.TypeReference{Identifier: &mojom_types.ID_mojom_types_Attribute__,
						TypeKey: &mojom_types.ID_mojom_types_Attribute__},
				},
				},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFile_Imports,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeStringType{mojom_types.StringType{false}}},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFile_DeclaredMojomObjects,
			},
			Type: &mojom_types.TypeTypeReference{
				Value: mojom_types.TypeReference{Identifier: &ID_mojom_files_KeysByType__,
					TypeKey: &ID_mojom_files_KeysByType__},
			},
		}},
	}
}

type MojomFileGraph struct {
	Files          map[string]MojomFile
	ResolvedTypes  map[string]mojom_types.UserDefinedType
	ResolvedValues map[string]mojom_types.UserDefinedValue
}

func (s *MojomFileGraph) Encode(encoder *bindings.Encoder) error {
	encoder.StartStruct(24, 0)
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	encoder.StartMap()
	{
		var keys0 []string
		var values0 []MojomFile
		for key0, value0 := range s.Files {
			keys0 = append(keys0, key0)
			values0 = append(values0, value0)
		}
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len(keys0)), 64)
		for _, elem1 := range keys0 {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem1); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len(values0)), 64)
		for _, elem1 := range values0 {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := elem1.Encode(encoder); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	encoder.StartMap()
	{
		var keys0 []string
		var values0 []mojom_types.UserDefinedType
		for key0, value0 := range s.ResolvedTypes {
			keys0 = append(keys0, key0)
			values0 = append(values0, value0)
		}
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len(keys0)), 64)
		for _, elem1 := range keys0 {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem1); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len(values0)), 128)
		for _, elem1 := range values0 {
			if elem1 == nil {
				return &bindings.ValidationError{bindings.UnexpectedNullUnion, "unexpected null union"}
			}
			if err := elem1.Encode(encoder); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	encoder.StartMap()
	{
		var keys0 []string
		var values0 []mojom_types.UserDefinedValue
		for key0, value0 := range s.ResolvedValues {
			keys0 = append(keys0, key0)
			values0 = append(values0, value0)
		}
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len(keys0)), 64)
		for _, elem1 := range keys0 {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem1); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len(values0)), 128)
		for _, elem1 := range values0 {
			if elem1 == nil {
				return &bindings.ValidationError{bindings.UnexpectedNullUnion, "unexpected null union"}
			}
			if err := elem1.Encode(encoder); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
	return nil
}

var mojomFileGraph_Versions []bindings.DataHeader = []bindings.DataHeader{
	bindings.DataHeader{32, 0},
}

func (s *MojomFileGraph) Decode(decoder *bindings.Decoder) error {
	header, err := decoder.StartStruct()
	if err != nil {
		return err
	}
	index := sort.Search(len(mojomFileGraph_Versions), func(i int) bool {
		return mojomFileGraph_Versions[i].ElementsOrVersion >= header.ElementsOrVersion
	})
	if index < len(mojomFileGraph_Versions) {
		if mojomFileGraph_Versions[index].ElementsOrVersion > header.ElementsOrVersion {
			index--
		}
		expectedSize := mojomFileGraph_Versions[index].Size
		if expectedSize != header.Size {
			return &bindings.ValidationError{bindings.UnexpectedStructHeader,
				fmt.Sprintf("invalid struct header size: should be %d, but was %d", expectedSize, header.Size),
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
		} else {
			if err := decoder.StartMap(); err != nil {
				return err
			}
			var keys0 []string
			{
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					len1, err := decoder.StartArray(64)
					if err != nil {
						return err
					}
					keys0 = make([]string, len1)
					for i1 := uint32(0); i1 < len1; i1++ {
						pointer2, err := decoder.ReadPointer()
						if err != nil {
							return err
						}
						if pointer2 == 0 {
							return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
						} else {
							value2, err := decoder.ReadString()
							if err != nil {
								return err
							}
							keys0[i1] = value2
						}
					}
					if err := decoder.Finish(); err != nil {
						return err
					}
				}
			}
			var values0 []MojomFile
			{
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					len1, err := decoder.StartArray(64)
					if err != nil {
						return err
					}
					values0 = make([]MojomFile, len1)
					for i1 := uint32(0); i1 < len1; i1++ {
						pointer2, err := decoder.ReadPointer()
						if err != nil {
							return err
						}
						if pointer2 == 0 {
							return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
						} else {
							if err := values0[i1].Decode(decoder); err != nil {
								return err
							}
						}
					}
					if err := decoder.Finish(); err != nil {
						return err
					}
				}
			}
			if len(keys0) != len(values0) {
				return &bindings.ValidationError{bindings.DifferentSizedArraysInMap,
					fmt.Sprintf("Number of keys %d is different from number of values %d", len(keys0), len(values0)),
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
			len0 := len(keys0)
			map0 := make(map[string]MojomFile)
			for i0 := 0; i0 < len0; i0++ {
				map0[keys0[i0]] = values0[i0]
			}
			s.Files = map0
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
		} else {
			if err := decoder.StartMap(); err != nil {
				return err
			}
			var keys0 []string
			{
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					len1, err := decoder.StartArray(64)
					if err != nil {
						return err
					}
					keys0 = make([]string, len1)
					for i1 := uint32(0); i1 < len1; i1++ {
						pointer2, err := decoder.ReadPointer()
						if err != nil {
							return err
						}
						if pointer2 == 0 {
							return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
						} else {
							value2, err := decoder.ReadString()
							if err != nil {
								return err
							}
							keys0[i1] = value2
						}
					}
					if err := decoder.Finish(); err != nil {
						return err
					}
				}
			}
			var values0 []mojom_types.UserDefinedType
			{
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					len1, err := decoder.StartArray(128)
					if err != nil {
						return err
					}
					values0 = make([]mojom_types.UserDefinedType, len1)
					for i1 := uint32(0); i1 < len1; i1++ {
						var err error
						values0[i1], err = mojom_types.DecodeUserDefinedType(decoder)
						if err != nil {
							return err
						}
						if values0[i1] == nil {
							return &bindings.ValidationError{bindings.UnexpectedNullUnion, "unexpected null union"}
						}
					}
					if err := decoder.Finish(); err != nil {
						return err
					}
				}
			}
			if len(keys0) != len(values0) {
				return &bindings.ValidationError{bindings.DifferentSizedArraysInMap,
					fmt.Sprintf("Number of keys %d is different from number of values %d", len(keys0), len(values0)),
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
			len0 := len(keys0)
			map0 := make(map[string]mojom_types.UserDefinedType)
			for i0 := 0; i0 < len0; i0++ {
				map0[keys0[i0]] = values0[i0]
			}
			s.ResolvedTypes = map0
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
		} else {
			if err := decoder.StartMap(); err != nil {
				return err
			}
			var keys0 []string
			{
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					len1, err := decoder.StartArray(64)
					if err != nil {
						return err
					}
					keys0 = make([]string, len1)
					for i1 := uint32(0); i1 < len1; i1++ {
						pointer2, err := decoder.ReadPointer()
						if err != nil {
							return err
						}
						if pointer2 == 0 {
							return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
						} else {
							value2, err := decoder.ReadString()
							if err != nil {
								return err
							}
							keys0[i1] = value2
						}
					}
					if err := decoder.Finish(); err != nil {
						return err
					}
				}
			}
			var values0 []mojom_types.UserDefinedValue
			{
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					len1, err := decoder.StartArray(128)
					if err != nil {
						return err
					}
					values0 = make([]mojom_types.UserDefinedValue, len1)
					for i1 := uint32(0); i1 < len1; i1++ {
						var err error
						values0[i1], err = mojom_types.DecodeUserDefinedValue(decoder)
						if err != nil {
							return err
						}
						if values0[i1] == nil {
							return &bindings.ValidationError{bindings.UnexpectedNullUnion, "unexpected null union"}
						}
					}
					if err := decoder.Finish(); err != nil {
						return err
					}
				}
			}
			if len(keys0) != len(values0) {
				return &bindings.ValidationError{bindings.DifferentSizedArraysInMap,
					fmt.Sprintf("Number of keys %d is different from number of values %d", len(keys0), len(values0)),
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
			len0 := len(keys0)
			map0 := make(map[string]mojom_types.UserDefinedValue)
			for i0 := 0; i0 < len0; i0++ {
				map0[keys0[i0]] = values0[i0]
			}
			s.ResolvedValues = map0
		}
	}
	if err := decoder.Finish(); err != nil {
		return err
	}
	return nil
}

// String names and labels used by the MojomStruct types.
var (
	structName_MojomFileGraph                     = "MojomFileGraph"
	structFullIdentifier_MojomFileGraph           = "mojo.bindings.types.MojomFileGraph"
	structFieldName_MojomFileGraph_Files          = "Files"
	structFieldName_MojomFileGraph_ResolvedTypes  = "ResolvedTypes"
	structFieldName_MojomFileGraph_ResolvedValues = "ResolvedValues"
)

func mojom_files_MojomFileGraph__() mojom_types.MojomStruct {
	return mojom_types.MojomStruct{
		DeclData: &mojom_types.DeclarationData{
			ShortName:      &structName_MojomFileGraph,
			FullIdentifier: &structFullIdentifier_MojomFileGraph,
		}, Fields: []mojom_types.StructField{mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFileGraph_Files,
			},
			Type: &mojom_types.TypeMapType{
				Value: mojom_types.MapType{KeyType: &mojom_types.TypeStringType{mojom_types.StringType{false}},
					ValueType: &mojom_types.TypeTypeReference{
						Value: mojom_types.TypeReference{Identifier: &ID_mojom_files_MojomFile__,
							TypeKey: &ID_mojom_files_MojomFile__},
					},
				},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFileGraph_ResolvedTypes,
			},
			Type: &mojom_types.TypeMapType{
				Value: mojom_types.MapType{KeyType: &mojom_types.TypeStringType{mojom_types.StringType{false}},
					ValueType: &mojom_types.TypeTypeReference{
						Value: mojom_types.TypeReference{Identifier: &mojom_types.ID_mojom_types_UserDefinedType__,
							TypeKey: &mojom_types.ID_mojom_types_UserDefinedType__},
					},
				},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_MojomFileGraph_ResolvedValues,
			},
			Type: &mojom_types.TypeMapType{
				Value: mojom_types.MapType{KeyType: &mojom_types.TypeStringType{mojom_types.StringType{false}},
					ValueType: &mojom_types.TypeTypeReference{
						Value: mojom_types.TypeReference{Identifier: &mojom_types.ID_mojom_types_UserDefinedValue__,
							TypeKey: &mojom_types.ID_mojom_types_UserDefinedValue__},
					},
				},
			},
		}},
	}
}

type KeysByType struct {
	Interfaces        *[]string
	Structs           *[]string
	Unions            *[]string
	TopLevelEnums     *[]string
	EmbeddedEnums     *[]string
	TopLevelConstants *[]string
	EmbeddedConstants *[]string
}

func (s *KeysByType) Encode(encoder *bindings.Encoder) error {
	encoder.StartStruct(56, 0)
	if s.Interfaces == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.Interfaces))), 64)
		for _, elem0 := range *s.Interfaces {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem0); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if s.Structs == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.Structs))), 64)
		for _, elem0 := range *s.Structs {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem0); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if s.Unions == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.Unions))), 64)
		for _, elem0 := range *s.Unions {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem0); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if s.TopLevelEnums == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.TopLevelEnums))), 64)
		for _, elem0 := range *s.TopLevelEnums {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem0); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if s.EmbeddedEnums == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.EmbeddedEnums))), 64)
		for _, elem0 := range *s.EmbeddedEnums {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem0); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if s.TopLevelConstants == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.TopLevelConstants))), 64)
		for _, elem0 := range *s.TopLevelConstants {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem0); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if s.EmbeddedConstants == nil {
		encoder.WriteNullPointer()
	} else {
		if err := encoder.WritePointer(); err != nil {
			return err
		}
		encoder.StartArray(uint32(len((*s.EmbeddedConstants))), 64)
		for _, elem0 := range *s.EmbeddedConstants {
			if err := encoder.WritePointer(); err != nil {
				return err
			}
			if err := encoder.WriteString(elem0); err != nil {
				return err
			}
		}
		if err := encoder.Finish(); err != nil {
			return err
		}
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
	return nil
}

var keysByType_Versions []bindings.DataHeader = []bindings.DataHeader{
	bindings.DataHeader{64, 0},
}

func (s *KeysByType) Decode(decoder *bindings.Decoder) error {
	header, err := decoder.StartStruct()
	if err != nil {
		return err
	}
	index := sort.Search(len(keysByType_Versions), func(i int) bool {
		return keysByType_Versions[i].ElementsOrVersion >= header.ElementsOrVersion
	})
	if index < len(keysByType_Versions) {
		if keysByType_Versions[index].ElementsOrVersion > header.ElementsOrVersion {
			index--
		}
		expectedSize := keysByType_Versions[index].Size
		if expectedSize != header.Size {
			return &bindings.ValidationError{bindings.UnexpectedStructHeader,
				fmt.Sprintf("invalid struct header size: should be %d, but was %d", expectedSize, header.Size),
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.Interfaces = nil
		} else {
			s.Interfaces = new([]string)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.Interfaces) = make([]string, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					value1, err := decoder.ReadString()
					if err != nil {
						return err
					}
					(*s.Interfaces)[i0] = value1
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.Structs = nil
		} else {
			s.Structs = new([]string)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.Structs) = make([]string, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					value1, err := decoder.ReadString()
					if err != nil {
						return err
					}
					(*s.Structs)[i0] = value1
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.Unions = nil
		} else {
			s.Unions = new([]string)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.Unions) = make([]string, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					value1, err := decoder.ReadString()
					if err != nil {
						return err
					}
					(*s.Unions)[i0] = value1
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.TopLevelEnums = nil
		} else {
			s.TopLevelEnums = new([]string)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.TopLevelEnums) = make([]string, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					value1, err := decoder.ReadString()
					if err != nil {
						return err
					}
					(*s.TopLevelEnums)[i0] = value1
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.EmbeddedEnums = nil
		} else {
			s.EmbeddedEnums = new([]string)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.EmbeddedEnums) = make([]string, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					value1, err := decoder.ReadString()
					if err != nil {
						return err
					}
					(*s.EmbeddedEnums)[i0] = value1
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.TopLevelConstants = nil
		} else {
			s.TopLevelConstants = new([]string)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.TopLevelConstants) = make([]string, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					value1, err := decoder.ReadString()
					if err != nil {
						return err
					}
					(*s.TopLevelConstants)[i0] = value1
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if header.ElementsOrVersion >= 0 {
		pointer0, err := decoder.ReadPointer()
		if err != nil {
			return err
		}
		if pointer0 == 0 {
			s.EmbeddedConstants = nil
		} else {
			s.EmbeddedConstants = new([]string)
			len0, err := decoder.StartArray(64)
			if err != nil {
				return err
			}
			(*s.EmbeddedConstants) = make([]string, len0)
			for i0 := uint32(0); i0 < len0; i0++ {
				pointer1, err := decoder.ReadPointer()
				if err != nil {
					return err
				}
				if pointer1 == 0 {
					return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
				} else {
					value1, err := decoder.ReadString()
					if err != nil {
						return err
					}
					(*s.EmbeddedConstants)[i0] = value1
				}
			}
			if err := decoder.Finish(); err != nil {
				return err
			}
		}
	}
	if err := decoder.Finish(); err != nil {
		return err
	}
	return nil
}

// String names and labels used by the MojomStruct types.
var (
	structName_KeysByType                        = "KeysByType"
	structFullIdentifier_KeysByType              = "mojo.bindings.types.KeysByType"
	structFieldName_KeysByType_Interfaces        = "Interfaces"
	structFieldName_KeysByType_Structs           = "Structs"
	structFieldName_KeysByType_Unions            = "Unions"
	structFieldName_KeysByType_TopLevelEnums     = "TopLevelEnums"
	structFieldName_KeysByType_EmbeddedEnums     = "EmbeddedEnums"
	structFieldName_KeysByType_TopLevelConstants = "TopLevelConstants"
	structFieldName_KeysByType_EmbeddedConstants = "EmbeddedConstants"
)

func mojom_files_KeysByType__() mojom_types.MojomStruct {
	return mojom_types.MojomStruct{
		DeclData: &mojom_types.DeclarationData{
			ShortName:      &structName_KeysByType,
			FullIdentifier: &structFullIdentifier_KeysByType,
		}, Fields: []mojom_types.StructField{mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_KeysByType_Interfaces,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeStringType{mojom_types.StringType{false}}},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_KeysByType_Structs,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeStringType{mojom_types.StringType{false}}},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_KeysByType_Unions,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeStringType{mojom_types.StringType{false}}},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_KeysByType_TopLevelEnums,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeStringType{mojom_types.StringType{false}}},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_KeysByType_EmbeddedEnums,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeStringType{mojom_types.StringType{false}}},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_KeysByType_TopLevelConstants,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeStringType{mojom_types.StringType{false}}},
			},
		}, mojom_types.StructField{
			DeclData: &mojom_types.DeclarationData{
				ShortName: &structFieldName_KeysByType_EmbeddedConstants,
			},
			Type: &mojom_types.TypeArrayType{
				Value: mojom_types.ArrayType{Nullable: true, ElementType: &mojom_types.TypeStringType{mojom_types.StringType{false}}},
			},
		}},
	}
}
