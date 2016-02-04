// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package parser

import (
	"fmt"
	"mojom/mojom_parser/mojom"
	"strings"
	"testing"
)

type singleFileTestCase struct {
	fileName       string
	mojomContents  string
	importedFrom   *mojom.MojomFile
	expectedErrors []string
}

type singleFileTest struct {
	cases       []singleFileTestCase
	testCaseNum int
}

func (test *singleFileTest) addTestCase(contents string, expectedErrors []string) {
	fileName := fmt.Sprintf("file%d", test.testCaseNum)
	var importedFrom *mojom.MojomFile = nil
	test.cases = append(test.cases, singleFileTestCase{fileName, contents, importedFrom, expectedErrors})
	test.testCaseNum += 1
}

// TestSingleFileResolutionErrors() tests that appropriate error messages are generated
// when a .mojom file contains unresolved references.
func TestSingleFileResolutionErrors(t *testing.T) {
	test := singleFileTest{}

	////////////////////////////////////////////////////////////
	// Test Case: One unresolved value reference
	////////////////////////////////////////////////////////////
	{
		contents := `

    struct Foo{
      int32 x = Bar;
    };`

		test.addTestCase(contents, []string{
			"Undefined value: \"Bar\"",
			"int32 x = Bar;",
			"^^^"})
	}

	////////////////////////////////////////////////////////////
	// Test Case:Two unresolved value references
	////////////////////////////////////////////////////////////
	{
		contents := `

    const bool F = Baz;

    struct Foo{
      int32 x = Bar;
    };`

		test.addTestCase(contents, []string{
			"Undefined value: \"Baz\"", "Undefined value: \"Bar\""})
	}

	////////////////////////////////////////////////////////////
	// Test Case: One unresolved type reference
	////////////////////////////////////////////////////////////
	{
		contents := `

    struct Foo{
      Bar x;
    };`

		test.addTestCase(contents, []string{"Undefined type: \"Bar\""})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Multiple unresolved types and values.
	////////////////////////////////////////////////////////////
	{
		contents := `

	const int32 X = Boom;

    struct Foo{
      Bar x;
      Baz y = Bing;
      int32 z = X;
    };

    struct Foo2 {
    	Foo f = default;
    };`

		test.addTestCase(contents, []string{
			"Undefined type: \"Bar\"", "Undefined type: \"Baz\"",
			"Undefined value: \"Boom\"", "Undefined value: \"Bing\"",
			"Use of unresolved value: \"X\"",
			"^^^^"}) // There will be four carets in the snippet because of "Boom"
	}

	////////////////////////////////////////////////////////////
	// Execute all of the test cases.
	////////////////////////////////////////////////////////////
	for i, c := range test.cases {
		// Parse and resolve the mojom input.
		descriptor := mojom.NewMojomDescriptor()
		specifiedName := ""
		if c.importedFrom == nil {
			specifiedName = c.fileName
		}
		parser := MakeParser(c.fileName, specifiedName, c.mojomContents, descriptor, c.importedFrom)
		parser.Parse()
		if !parser.OK() {
			t.Errorf("Parsing error for %s: %s", c.fileName, parser.GetError().Error())
			continue
		}
		err := descriptor.Resolve()
		if err == nil {
			t.Errorf("Resolution unexpectedly succeeded for test case %d.", i)
			continue
		}
		got := err.Error()
		for _, expected := range c.expectedErrors {
			if !strings.Contains(got, expected) {
				t.Errorf("%s:\n*****expected to contain:\n%s\n****actual\n%s", c.fileName, expected, got)
			}
		}

	}
}

// TestSingleFileValueValidationErrors() test the function
// UserValueRef.validateAfterResolution(). It tests that appropriate error messages are generated
// when a .mojom file contains validation errors. In particular we are testing errors
// that are not detected during parsing but are only detected after all names have
// been resolved. Thus we are not testing here, for example, an attempt to assign
// an int32 literal value to a string variable, because that type of error can be
// detected during parsing. But we are testing the case of a constant whose value is
// an int32 literal being assigned to a string variable.
func TestSingleFileValueValidationErrors(t *testing.T) {
	test := singleFileTest{}

	////////////////////////////////////////////////////////////
	// Group 1: The left-hand-side is an int32 variable.
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of bool type to int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const bool Bar = true;

	struct Foo{
	  int32 x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value true of type bool may not be assigned to x of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of string type to int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const string Bar = "Hi Bar";

	struct Foo{
	  int32 x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value \"Hi Bar\" of type string may not be assigned to x of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant with value double.INFINITY  to int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const double Bar = double.INFINITY;

	struct Foo{
	  int32 x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value double.INFINITY may not be assigned to x of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign double.INFINITY directly to an int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	  int32 x = double.INFINITY;
	};`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"double.INFINITY may not be assigned to x of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of enum value to int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const MyEnum Bar = TWO;

	struct Foo{
	  int32 x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value MyEnum.TWO may not be assigned to x of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign enum value directly to int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const int32 Bar = MyEnum.TWO;
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"The enum value MyEnum.TWO of type MyEnum may not be assigned to Bar of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Group 2: The left-hand-side is a string variable.
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of int32 type to string variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const int32 Bar = 42;

	struct Foo{
	  string? x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value 42 of type int8 may not be assigned to x of type string?"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant with value double.INFINITY to a string variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const double Bar = double.INFINITY;

	struct Foo{
	  string x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value double.INFINITY may not be assigned to x of type string"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign double.INFINITY directly to a string variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const string Bar = double.INFINITY;
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"double.INFINITY may not be assigned to Bar of type string"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of enum value to string variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const MyEnum Bar = TWO;

	struct Foo{
	  string x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value MyEnum.TWO may not be assigned to x of type string"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign enum value directly to a string variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const string Bar = MyEnum.TWO;
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"The enum value MyEnum.TWO of type MyEnum may not be assigned to Bar of type string"})
	}

	////////////////////////////////////////////////////////////
	// Group 3: The left-hand-side is an enum variable.
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of bool type to an enum variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const bool Bar = true;

	enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };


	struct Foo{
	  MyEnum x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value true of type bool may not be assigned to x of type MyEnum"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of value double.INFINITY to an enum variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const double Bar = double.INFINITY;

	struct Foo{
	  MyEnum x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value double.INFINITY may not be assigned to x of type MyEnum"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign double.INFINITY directly to an enum variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const MyEnum Bar = double.INFINITY;
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"double.INFINITY may not be assigned to Bar of type MyEnum"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of enum value to a variable of a different enum type.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	  enum MyOtherEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const MyEnum Bar = TWO;

	struct Foo{
	  MyOtherEnum x = Bar;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value MyEnum.TWO may not be assigned to x of type MyOtherEnum"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign enum value to a variable of a different enum type.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	  enum MyOtherEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const MyEnum Bar = MyOtherEnum.TWO;
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"The enum value MyOtherEnum.TWO of type MyOtherEnum may not be assigned to Bar of type MyEnum"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Use an enum value from a different enum as an enum value initializer.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	  enum MyOtherEnum {
	   ONE,
	   TWO = MyEnum.TWO,
	   THREE
	 };
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"The enum value MyEnum.TWO of type MyEnum may not be used as an initializer for TWO of type MyOtherEnum."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Use a constant with a value of an enum value from a different enum as an enum value initializer.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	 const MyEnum Bar = MyEnum.TWO;

	  enum MyOtherEnum {
	   ONE,
	   TWO = Bar,
	   THREE
	 };
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar with the value MyEnum.TWO may not be used as an initializer for TWO of type MyOtherEnum."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign the default keyword to a variable of enum type.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	 };

	struct Foo{
	  MyEnum x = default;
	};`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"The 'default' keyword may not be used with the field x of type MyEnum."})
	}

	////////////////////////////////////////////////////////////
	// Group 4: The left-hand-side is an interface varialbe.
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Assign an enum value to an interface
	////////////////////////////////////////////////////////////
	{
		contents := `
	interface Foo{
	  enum MyEnum {
	    ONE
	  };
	};

	struct Bar{
	  Foo&? x = Foo.MyEnum.ONE;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"The enum value Foo.MyEnum.ONE of type Foo.MyEnum may not be assigned to x of type Foo&?."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign constant of value double.INFINITY to an enum variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	interface Foo{
	  const double BIG = double.INFINITY;
	};

	struct Bar{
	  Foo? x = Foo.BIG;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Foo.BIG with the value double.INFINITY may not be assigned to x of type Foo?."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign double.INFINITY directly to an interface variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	interface Foo{
	};

	struct Bar{
	  Foo& x = double.INFINITY;
	};
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"double.INFINITY may not be assigned to x of type Foo&."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign the default keyword to a variable of interface type.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 interface Foo{
	};

	struct Bar{
	  Foo& x = default;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"The 'default' keyword may not be used with the field x of type Foo&."})
	}

	////////////////////////////////////////////////////////////
	// Group 5: Multiple indirection
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Assign doubly-indirected constant of bool type to int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const bool Bar = true;
	const bool Baz = Bar;

	struct Foo{
	  int32 x = Baz;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Baz with the value true of type bool may not be assigned to x of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign doubly-indirected constant with value double.INFINITY  to int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const double Bar = double.INFINITY;
	const double Baz = Bar;

	struct Foo{
	  int32 x = Baz;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Baz with the value double.INFINITY may not be assigned to x of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign doubly-indirected constant of enum value to int32 variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	 enum MyEnum {
	   ONE,
	   TWO,
	   THREE
	 };

	const MyEnum Bar = TWO;
	const MyEnum Baz = Bar;

	struct Foo{
	  int32 x = Baz;
	};`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Baz with the value MyEnum.TWO may not be assigned to x of type int32"})
	}

	////////////////////////////////////////////////////////////
	// Group 4: Invalid EnumValue initializers.
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Use string as enum value initializer.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const int32 Foo = 8;
	const string Bar = "fly";

	enum MyEnum {
	   ONE = Foo,
	   TWO = Bar,
	   THREE
	 };`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Bar cannot be used as an enum value initializer because its value, \"fly\", is not a signed 32-bit integer"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Use double.NAN as an enum value initializer.
	////////////////////////////////////////////////////////////
	{
		contents := `
	const int32 Foo = 8;
	const int64 Bar = 9;

	enum MyEnum {
	   ONE = Foo,
	   TWO = Bar,
	   THREE = double.NAN
	 };`

		test.addTestCase(contents, []string{
			"Illegal assignment",
			"double.NAN cannot be used as an enum value initializer"})
	}

	////////////////////////////////////////////////////////////
	// Group 5: Non-referent shadows referent
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Field name shadows constant name
	////////////////////////////////////////////////////////////
	{
		contents := `
	const int32 foo = 42;

    struct MyStruct {
      string foo = "hello";
      int32 bar = foo;
    };`

		test.addTestCase(contents, []string{
			"Error",
			"\"foo\" does not refer to a value. It refers to the field MyStruct.foo at"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Method name shadows constant name
	////////////////////////////////////////////////////////////
	{
		contents := `
	const int32 foo = 42;

    interface MyInterface {
      foo();
      const int32 bar = foo;
    };`

		test.addTestCase(contents, []string{
			"Error",
			"\"foo\" does not refer to a value. It refers to the method MyInterface.foo at"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Field name shadows type name
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct SomethingGood{};

    struct MySecondStruct {
      int32 SomethingGood = 7;
      SomethingGood x = default;
    };`

		test.addTestCase(contents, []string{
			"Error",
			"\"SomethingGood\" does not refer to a type. It refers to the field MySecondStruct.SomethingGood at"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Method name shadows type name
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct SomethingGood{};

    interface MyInterface {
      SomethingGood();

      DoIt(SomethingGood x);
    };`

		test.addTestCase(contents, []string{
			"Error",
			"\"SomethingGood\" does not refer to a type. It refers to the method MyInterface.SomethingGood at"})
	}

	////////////////////////////////////////////////////////////
	// Execute all of the test cases.
	////////////////////////////////////////////////////////////
	for i, c := range test.cases {
		// Parse and resolve the mojom input.
		descriptor := mojom.NewMojomDescriptor()
		specifiedName := ""
		if c.importedFrom == nil {
			specifiedName = c.fileName
		}
		parser := MakeParser(c.fileName, specifiedName, c.mojomContents, descriptor, c.importedFrom)
		parser.Parse()
		if !parser.OK() {
			t.Errorf("Parsing error for %s: %s", c.fileName, parser.GetError().Error())
			continue
		}
		err := descriptor.Resolve()
		if err == nil {
			t.Errorf("Resolution unexpectedly succeeded for test case %d.", i)
			continue
		}
		got := err.Error()
		for _, expected := range c.expectedErrors {
			if !strings.Contains(got, expected) {
				t.Errorf("%s:\n*****expected to contain:\n%s\n****actual\n%s", c.fileName, expected, got)
			}
		}

	}
}

// TestSingleFileTypeValidationErrors() test the method UserTypeRef.validateAfterResolution().
// It is similar to TestSingleFileValueValidationErrors()
// except that it tests the validation of types phase which occurs before the validation
// of values phase. This phase detects errors that may not be detected during parsing
// but that may be detected without resolving value references.
func TestSingleFileTypeValidationErrors(t *testing.T) {
	test := singleFileTest{}

	////////////////////////////////////////////////////////////
	// Group 1: Left-hand-side is a struct
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Use struct as constant type
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	};

    const Foo MyFoo = 3;
	`
		test.addTestCase(contents, []string{
			"The type Foo is not allowed as the type of a declared constant.",
			"Only simple types, strings and enum types may be used"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Use struct as map key
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	};

    struct Bar{
    	map<Foo, int32> x;
    };
	`
		test.addTestCase(contents, []string{
			"The type Foo is not allowed as the key type of a map.",
			"Only simple types, strings and enum types may be map keys"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign an integer to a struct variable.
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	};

    struct Bar{
    	Foo x = 42;
    };
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Field x of type Foo may not be assigned the value 42 of type int8"})
	}

	////////////////////////////////////////////////////////////
	// Group 2: Left-hand-side is an enum
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Assign an integer to an enum variable in a struct field.
	////////////////////////////////////////////////////////////
	{
		contents := `
	enum Hats {
		COWBOY,
		TOP
	};

    struct Bar{
    	Hats my_hat = 1;
    };
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Field my_hat of type Hats may not be assigned the value 1 of type int8."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Assign an integer to an enum variable in a constant.
	////////////////////////////////////////////////////////////
	{
		contents := `
	enum Hats {
		COWBOY,
		TOP
	};

    const Hats MY_HAT = 1;
	`
		test.addTestCase(contents, []string{
			"Illegal assignment",
			"Const MY_HAT of type Hats may not be assigned the value 1 of type int8."})
	}

	////////////////////////////////////////////////////////////
	// Group 3: Invalid use of interface request.
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Make an interface request out of a struct
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	};

    struct Bar{
    	Foo& x;
	};
	`
		test.addTestCase(contents, []string{
			"Invalid interface request specification",
			"Foo&. Foo is not an interface type"})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Make a nullable interface request out of a struct
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	};

    struct Bar{
    	Foo&? x;
	};
	`
		test.addTestCase(contents, []string{
			"Invalid interface request specification",
			"Foo&?. Foo is not an interface type"})
	}

	////////////////////////////////////////////////////////////
	// Group 4: Invalid use of nullable
	////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////
	// Test Case: Make nullable enum.
	////////////////////////////////////////////////////////////
	{
		contents := `
	enum Hats {
		COWBOY,
		TOP
	};

    struct Bar{
    	Hats? my_hat;
	};
	`
		test.addTestCase(contents, []string{
			"The type Hats? is invalid because Hats is an enum type and these may not be made nullable."})
	}

	////////////////////////////////////////////////////////////
	// Execute all of the test cases.
	////////////////////////////////////////////////////////////
	for i, c := range test.cases {
		// Parse and resolve the mojom input.
		descriptor := mojom.NewMojomDescriptor()
		specifiedName := ""
		if c.importedFrom == nil {
			specifiedName = c.fileName
		}
		parser := MakeParser(c.fileName, specifiedName, c.mojomContents, descriptor, c.importedFrom)
		parser.Parse()
		if !parser.OK() {
			t.Errorf("Parsing error for %s: %s", c.fileName, parser.GetError().Error())
			continue
		}
		err := descriptor.Resolve()
		if err == nil {
			t.Errorf("Resolution unexpectedly succeeded for test case %d.", i)
			continue
		}
		got := err.Error()
		for _, expected := range c.expectedErrors {
			if !strings.Contains(got, expected) {
				t.Errorf("%s:\n*****expected to contain:\n%s\n****actual\n%s", c.fileName, expected, got)
			}
		}

	}
}

////////////////////////////////////////////////
/// Resolution Success Tests
////////////////////////////////////////////////

// testFuncType is a callback used to specify how to test each case.
type testFuncType func(*mojom.MojomDescriptor) error

// singleFileSuccessTestCase stores the data for one test case.
type singleFileSuccessTestCase struct {
	mojomContents string
	testFunc      testFuncType
}

// singleFileSuccessTest contains a series of test cases.
type singleFileSuccessTest struct {
	cases []singleFileSuccessTestCase
}

// addTestCase() should be invoked at the start of a case in
// TestSingleFileResolutionSuccess.
func (test *singleFileSuccessTest) addTestCase(moduleNameSpace, contents string, testFunc testFuncType) {
	test.cases = append(test.cases, singleFileSuccessTestCase{contents, testFunc})
}

// TestSingleFileResolutionSuccess() iterates through a series of test cases.
// For each case we expect for parsing and resolution to succeed. Then we
// execute a given callback test function to test that resolution produced
// the desired result.
func TestSingleFileResolutionSuccess(t *testing.T) {
	test := singleFileSuccessTest{}

	////////////////////////////////////////////////////////////
	// Test Case: A local constant name shadows an enum name.
	////////////////////////////////////////////////////////////
	{
		contents := `
	enum Color{
	  RED, BLUE
	};

	struct MyStruct {
		const Color RED = BLUE;

        Color a_color = RED; // This should resolve to the local constant RED,
                             // and therefore the concrete value should be BLUE.
	};`

		testFunc := func(descriptor *mojom.MojomDescriptor) error {
			myStructType := descriptor.TypesByKey["TYPE_KEY:MyStruct"].(*mojom.MojomStruct)
			aColorField := myStructType.Fields[0]
			concreteValue := aColorField.DefaultValue.ResolvedConcreteValue().(*mojom.EnumValue)
			key := concreteValue.ValueKey()
			if key != "TYPE_KEY:Color.BLUE" {
				return fmt.Errorf("%s != TYPE_KEY:Color.BLUE", key)
			}
			return nil
		}
		test.addTestCase("", contents, testFunc)
	}

	////////////////////////////////////////////////////////////
	// Execute all of the test cases.
	////////////////////////////////////////////////////////////
	for i, c := range test.cases {
		// Parse and resolve the mojom input.
		descriptor := mojom.NewMojomDescriptor()
		fileName := fmt.Sprintf("file%d", i)
		parser := MakeParser(fileName, fileName, c.mojomContents, descriptor, nil)
		parser.Parse()
		if !parser.OK() {
			t.Errorf("Parsing error for %s: %s", fileName, parser.GetError().Error())
			continue
		}
		err := descriptor.Resolve()
		if err != nil {
			t.Errorf("Resolution failed for test case %d: %s", i, err.Error())
			continue
		}

		if c.testFunc != nil {
			if err := c.testFunc(descriptor); err != nil {
				t.Errorf("%s:\n%s", fileName, err.Error())
				continue
			}
		}
	}
}

////////////////////////////////////////////////
/// TestFindReachableTypes
////////////////////////////////////////////////

// typeGraphTestCase stores the data for one test case.
type typeGraphTestCase struct {
	mojomContents          string
	typeToSearch           string
	expectedReachableTypes []string
}

// typeGraphTest contains a series of test cases.
type typeGraphTest struct {
	cases []typeGraphTestCase
}

// addTestCase() should be invoked at the start of a case in TestFindReachableTypes.
func (test *typeGraphTest) addTestCase(contents, typeToSearch string, expectedReachableTypes []string) {
	test.cases = append(test.cases, typeGraphTestCase{contents, typeToSearch, expectedReachableTypes})
}

// TestFindReachableTypes() iterates through a series of test cases.
// For each case we expect for parsing and resolution to succeed. Then we
// invoke FindReachableTypes() on |typeToSearch| and compare the result
// to |expectedReachableTypes|.
func TestFindReachableTypes(t *testing.T) {
	test := typeGraphTest{}

	////////////////////////////////////////////////////////////
	// Test Case
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Struct1{
	};

	struct Struct2{
		Struct1 x;
	};

    struct Struct3{
		Struct2 x;
	};

	struct Struct4{
		Struct3 x;
	};

	union Union1 {
		Struct3 x;
		Struct2 y;
	};

	union Union2 {
		Struct2 x;
	};
	`
		test.addTestCase(contents,
			"Struct4",
			[]string{"Struct1", "Struct2", "Struct3", "Struct4"},
		)

		test.addTestCase(contents,
			"Union1",
			[]string{"Union1", "Struct1", "Struct2", "Struct3"},
		)

		test.addTestCase(contents,
			"Union2",
			[]string{"Union2", "Struct1", "Struct2"},
		)
	}

	////////////////////////////////////////////////////////////
	// Test Case
	////////////////////////////////////////////////////////////
	{
		contents := `
	   	struct Struct1{
	   		Struct4 x;
	   	};

	   	struct Struct2{
	   		Struct1 x;
	   	};

	    struct Struct3{
	   		Struct2 x;
	   	};

	   	struct Struct4{
	   		Struct3 x;
	   	};

	   	union Union1 {
	   		Struct2 x;
	   	};
	   	`

		test.addTestCase(contents,
			"Union1",
			[]string{"Union1", "Struct1", "Struct2", "Struct3", "Struct4"},
		)
	}

	////////////////////////////////////////////////////////////
	// Test Cases
	////////////////////////////////////////////////////////////
	{
		contents := `

		enum Height {
			SHORT, TALL
		};

		struct Struct1{
		  enum Color {
			RED, BLUE
		  };
		};

		struct Struct2{
			const Struct1.Color FAVORITE = RED;
		};
		`

		test.addTestCase(contents,
			"Struct1",
			[]string{"Struct1", "Struct1.Color"},
		)

		test.addTestCase(contents,
			"Struct2",
			[]string{"Struct2", "Struct1.Color"},
		)
	}

	////////////////////////////////////////////////////////////
	// Test Cases
	////////////////////////////////////////////////////////////
	{
		contents := `
		enum Color {
			RED, BLUE
		};

		enum Height {
			SHORT, TALL
		};

		struct Struct1{};
		struct Struct2{};

		interface Interface1 {
			const Color FAVORITE_COLOR = RED;

			Foo(int32 x) => (string y);
		};

		interface Interface2 {
			Foo(int32 x) => (Struct1 y);
		};
		`

		test.addTestCase(contents,
			"Interface1",
			[]string{"Interface1", "Color"},
		)

		test.addTestCase(contents,
			"Interface2",
			[]string{"Interface2", "Struct1"},
		)
	}

	////////////////////////////////////////////////////////////
	// Test Cases
	////////////////////////////////////////////////////////////

	{
		contents := `
		enum Color {
			RED, BLUE
		};

		enum Height {
			SHORT, TALL
		};

		struct Struct1{};
		struct Struct2{};

		interface Interface1 {
			const Color FAVORITE_COLOR = RED;

			Foo(map<Height, int8> x) => (string y);
		};

		interface Interface2 {
			Foo(int32 x) => (array<Struct1?> y);
		};
		`

		test.addTestCase(contents,
			"Interface1",
			[]string{"Interface1", "Color", "Height"},
		)

		test.addTestCase(contents,
			"Interface2",
			[]string{"Interface2", "Struct1"},
		)
	}

	////////////////////////////////////////////////////////////
	// Test Cases
	////////////////////////////////////////////////////////////

	{
		contents := `
		enum Color {
			RED, BLUE
		};

		enum Height {
			SHORT, TALL
		};

		struct Struct1{};
		struct Struct2{};

		interface Interface1 {
			const Color FAVORITE_COLOR = RED;

			Foo(int32 x) => (string y);
			Bar(map<string, Height> z) => ();
		};

		interface Interface2 {
			Foo(int32 x) => (map<Height, Struct1?> y);
		};
		`

		test.addTestCase(contents,
			"Interface1",
			[]string{"Interface1", "Color", "Height"},
		)

		test.addTestCase(contents,
			"Interface2",
			[]string{"Interface2", "Height", "Struct1"},
		)
	}

	////////////////////////////////////////////////////////////
	// Execute all of the test cases.
	////////////////////////////////////////////////////////////
	for i, c := range test.cases {
		// Parse and resolve the mojom input.
		descriptor := mojom.NewMojomDescriptor()
		fileName := fmt.Sprintf("file%d", i)
		parser := MakeParser(fileName, fileName, c.mojomContents, descriptor, nil)
		parser.Parse()
		if !parser.OK() {
			t.Errorf("Parsing error for %s: %s", fileName, parser.GetError().Error())
			continue
		}
		err := descriptor.Resolve()
		if err != nil {
			t.Errorf("Resolution failed for test case %d: %s", i, err.Error())
			continue
		}

		userDefinedType := descriptor.TypesByKey[mojom.ComputeTypeKey(c.typeToSearch)]
		result := userDefinedType.FindReachableTypes()
		if err := compareTypeSets(descriptor, c.expectedReachableTypes, result); err != nil {
			t.Errorf("Case %d, unexpected typeset for %s: %s\n", i, c.typeToSearch, err.Error())
			continue
		}
	}
}

func compareTypeSets(descriptor *mojom.MojomDescriptor, expectedTypeNames, actualTypeKeys []string) error {
	expectedSet := userDefinedTypeSet(descriptor, expectedTypeNames, false)
	actualSet := userDefinedTypeSet(descriptor, actualTypeKeys, true)
	return expectedSet.Compare(&actualSet)
}

func userDefinedTypeSet(descriptor *mojom.MojomDescriptor, types []string, typesAreKeys bool) mojom.UserDefinedTypeSet {
	typeSet := mojom.MakeUserDefinedTypeSet()
	for _, t := range types {
		if t == "" {
			panic("Found empty type in types array.")
		}
		var typeKey string
		if typesAreKeys {
			typeKey = t
		} else {
			typeKey = mojom.ComputeTypeKey(t)
		}
		userDefinedType := descriptor.TypesByKey[typeKey]
		if userDefinedType == nil {
			panic(fmt.Sprintf("No type found for: %s", t))
		}
		typeSet.Add(userDefinedType)
	}
	return typeSet
}
