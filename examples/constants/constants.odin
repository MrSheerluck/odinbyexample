// Constants are values that are known at compile time and
// cannot be modified. They are declared using the :: operator.
//
// Constants can be declared at package scope or inside
// procedures. They are commonly used for values that never
// change, such as mathematical values and configuration data.
//
// Numeric constants are untyped until the compiler needs a
// concrete type. This allows constant expressions to be
// evaluated with arbitrary precision before being converted
// to the required type.
//
//   $ odin run constants.odin -file
//   constant
//   6e+11
//   600000000000
//   600000000000.0

package main

import "core:fmt"

// Package-level constants.
message :: "constant"
n :: 500000000

main :: proc() {
	// Constants behave like any other value.
	fmt.println(message)

	// Constant expressions are evaluated at compile time.
	d :: 3e20 / n
	fmt.println(d)

	// Convert an untyped numeric constant to i64.
	fmt.println(i64(d))

	// The same constant can be converted to a different type.
	fmt.println(f64(d))
}
