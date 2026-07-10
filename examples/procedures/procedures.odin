// Procedures are reusable blocks of code that perform a
// specific task. If you're coming from another language,
// they're similar to functions.
//
// A procedure can accept parameters and return values.
// It is declared using the proc keyword.
//
//   $ odin run procedures.odin -file
//   Hello, Odin!
//   5 + 7 = 12

package main

import "core:fmt"

// This procedure takes a string parameter and
// doesn't return a value.
greet :: proc(name: string) {
	fmt.printfln("Hello, {}!", name)
}

// This procedure takes two integers and
// returns their sum.
add :: proc(a, b: int) -> int {
	return a + b
}

main :: proc() {
	// Call a procedure by passing arguments.
	greet("Odin")

	// Store and use the returned value.
	sum := add(5, 7)
	fmt.println("5 + 7 =", sum)
}
