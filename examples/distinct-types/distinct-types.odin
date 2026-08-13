// A distinct type creates a brand new type that has the same
// underlying representation as an existing one. Unlike a type
// alias, it is not interchangeable with the original type.
//
// Declare one with the distinct keyword: My_Int :: distinct int.
// Values of a distinct type do not mix with the underlying
// type - arithmetic, assignment, and comparison all require
// an explicit conversion. This prevents accidental mixing of
// values that have the same representation but different
// meanings, like temperatures in Celsius and Fahrenheit.
//
// Aggregate types (struct, enum, union) are always distinct,
// even when named, so distinct mostly matters for basic types.
//
// Convert a distinct value to its underlying type (or back)
// with an explicit conversion: T(value).
//
//   $ odin run distinct-types.odin -file
//   celsius: 100 converted: 101.5
//   fahrenheit: 212
//   boiling point: 100
//   converted to int: true
//   Celsius is distinct from int: true
//   total bytes: 200
//   score: 100000
//   valid age: true

package main

import "core:fmt"

// A distinct type shares the underlying representation but is
// a different type. Celsius and Fahrenheit are both f64, but
// mixing them is a bug the compiler can catch.
Celsius :: distinct f64
Fahrenheit :: distinct f64

// Distinct types work as element types too.
Byte_Count :: distinct u64

// A distinct type can be based on any basic type.
ID :: distinct int

main :: proc() {
	// Literals convert implicitly to the distinct type.
	boiling := Celsius(100)

	// Distinct types cannot be mixed with the underlying type
	// without conversion. This line would not compile:
	//   boiling + 1.5
	// Convert explicitly to do math with plain f64 values.
	value := f64(boiling) + 1.5
	fmt.println("celsius:", boiling, "converted:", value)

	// A helper procedure can keep conversions in one place.
	to_fahrenheit :: proc(c: Celsius) -> Fahrenheit {
		return Fahrenheit(f64(c) * 9.0 / 5.0 + 32.0)
	}
	fmt.println("fahrenheit:", to_fahrenheit(Celsius(100)))

	// Convert back and forth with explicit conversions.
	fmt.println("boiling point:", int(boiling))
	fmt.println("converted to int:", int(Celsius(37)) == 37)

	// distinct is not the same as the underlying type.
	#assert(Celsius != f64)
	fmt.println("Celsius is distinct from int:", Celsius != int)

	// Distinct types keep the underlying size and layout.
	total := Byte_Count(200)
	fmt.println("total bytes:", total)

	// Storing distinct values in a variable of a different
	// distinct type requires conversion, as does using one
	// where an int is expected.
	score := ID(100_000)
	fmt.println("score:", score)

	// Comparing across distinct types fails to compile too.
	age := ID(42)
	fmt.println("valid age:", age == ID(42))
}
