// Odin has several basic types. These include strings,
// integers, floating-point numbers, and booleans. They
// are the fundamental building blocks used in programs.
//
// Strings hold UTF-8 encoded text. They can be
// concatenated with the + operator.
//
// Integers represent whole numbers. Odin provides signed
// and unsigned integer types in several sizes, along with
// platform-sized int and uint types.
//
// Floating-point numbers represent values with a
// fractional component. Odin provides f16, f32, and
// f64 floating-point types.
//
// Booleans have one of two values: true or false.
// Logical operators include && (and), || (or), and
// ! (not).
//
//   $ odin run values.odin -file
//   golang
//   1+1 = 2
//   7.0/3.0 = 2.3333333333333335
//   false
//   true
//   false

package main

import "core:fmt"

main :: proc() {
	// Concatenate two strings.
	fmt.println("go" + "lang")

	// Integer and floating-point arithmetic.
	fmt.println("1+1 =", 1 + 1)
	fmt.println("7.0/3.0 =", 7.0 / 3.0)

	// Boolean logic.
	fmt.println(true && false)
	fmt.println(true || false)
	fmt.println(!true)
}
