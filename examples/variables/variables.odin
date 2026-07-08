// In Odin, variables are declared with := and the compiler
// checks that every declared variable is used. The type of a
// variable is inferred from the value you assign to it.
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
	// := declares and assigns a variable in one step.
	// The type is inferred from the value.
	a := "initial"
	fmt.println(a)

	// You can declare multiple variables at once.
	b, c := 1, 2
	fmt.println(b, c)

	// The type is inferred for each variable.
	d := true
	fmt.println(d)

	// Variables are zero-valued if you assign the
	// zero value explicitly or use a type annotation
	// without a value. For int, the zero value is 0.
	e: int
	fmt.println(e)

	// := works everywhere. You can also write the
	// type explicitly when you want to be clear.
	f: string = "apple"
	fmt.println(f)
}
