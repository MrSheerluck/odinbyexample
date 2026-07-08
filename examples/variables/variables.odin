// Variables store values that can be changed during
// program execution.
//
// Odin supports both type inference and explicit type
// annotations. Every declared variable must be used.
//
//   $ odin run variables.odin -file
//   initial
//   1 2
//   true
//   0
//   apple

package main

import "core:fmt"

main :: proc() {
	// Declare a variable with type inference.
	a := "initial"
	fmt.println(a)

	// Declare multiple variables at once.
	b, c := 1, 2
	fmt.println(b, c)

	// The compiler infers the type from the value.
	d := true
	fmt.println(d)

	// Variables declared without an initializer
	// receive the zero value of their type.
	e: int
	fmt.println(e)

	// You can also specify the type explicitly.
	f: string = "apple"
	fmt.println(f)
}
