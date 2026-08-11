// A union is a type that can hold exactly one of a set of
// member types at a time. They are useful when a value may
// be one of several different things, such as a result that
// is either a number or an error message.
//
// Declare a union with the union keyword followed by the
// member types in {}. The default is a tagged union: a tag
// keeps track of which member is currently active.
//
// Create a union value by assigning one of its member types.
// Check which member is active with a type switch, and
// extract the stored value with a type assertion to the
// member type. Assigning a new value replaces whatever was
// stored before.
//
//   $ odin run unions.odin -file
//   first value: 10
//   as f64: 3.14
//   size of Number: 16
//   string value: hello
//   size of Value: 24
//   it's a string: hello
//   result: Result{value = 42, ok = true}
//   nil union

package main

import "core:fmt"

// A union of a few basic types. The tag is stored implicitly
// and is at least one byte, so the size is rounded up.
Number :: union {
	int,
	f64,
}

// A union can also hold structs and other user types.
Value :: union {
	int,
	string,
	Result,
}

Result :: struct {
	value: int,
	ok:    bool,
}

main :: proc() {
	// Assign a member type; the tag is set automatically.
	n: Number = 10
	fmt.println("first value:", n)

	// Reassign to a different member; the tag updates.
	n = 3.14
	fmt.println("as f64:", n)

	// The size is the largest member plus the tag.
	fmt.println("size of Number:", size_of(Number))

	// A union with a string member stores it the same way.
	v: Value = "hello"
	fmt.println("string value:", v)
	fmt.println("size of Value:", size_of(Value))

	// A type switch distinguishes the active member.
	describe :: proc(x: Value) {
		switch y in x {
		case int:
			fmt.println("it's an int:", y)
		case string:
			fmt.println("it's a string:", y)
		case Result:
			fmt.println("it's a Result:", y)
		}
	}
	describe(v)

	// A type assertion extracts the value if the tag matches.
	if i, ok := v.(int); ok {
		fmt.println("as int:", i)
	}

	// Assigning a struct member works like any other.
	r: Value = Result{42, true}
	fmt.println("result:", r)

	// A union can hold nil; check before extracting.
	u: Number
	if u == nil {
		fmt.println("nil union")
	}
}
