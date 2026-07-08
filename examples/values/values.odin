// Odin has several basic value types. These include
// strings, integers, floats, and booleans. They are the
// fundamental building blocks used in every program.
//
// Strings are used to hold text. You can join them
// together with the + operator.
//
// Integers represent whole numbers. Odin has signed types
// (int, i8 through i128) and unsigned types (uint, u8
// through u128). Plain int and uint are sized to
// match your machine's pointer.
//
// Floats represent fractional numbers and come in f16,
// f32, f64, and complex variants. Standard arithmetic
// works as you would expect.
//
// Booleans are either true or false. The usual logical
// operators work on them: && (and), || (or), ! (not).
//
//   $ odin run values.odin -file
//   golang
//   1+1 = 2
//   7.0/3.0 = 2.3333
//   false
//   true
//   false
package main

import "core:fmt"

main :: proc() {
	// Strings can be joined with +.
	fmt.println("go" + "lang")

	// Integers and floats use standard arithmetic.
	// Division produces a float when either operand is a float.
	fmt.println("1+1 =", 1+1)
	fmt.println("7.0/3.0 =", 7.0/3.0)

	// Booleans can be combined with logical operators.
	fmt.println(true && false)
	fmt.println(true || false)
	fmt.println(!true)
}
