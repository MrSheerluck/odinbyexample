// The if statement lets you execute code only when a
// condition is true.
//
// Conditions must evaluate to a boolean value. Unlike
// some languages, Odin does not automatically convert
// integers or pointers to booleans.
//
// An optional else block can be used to handle the case
// when the condition is false.
//
//   $ odin run if.odin -file
//   7 is odd
//   you can drive
//   both conditions are true

package main

import "core:fmt"

main :: proc() {
	// Execute a block only if the condition is true.
	if 7 % 2 == 0 {
		fmt.println("7 is even")
	} else {
		fmt.println("7 is odd")
	}

	age := 20

	// else runs when the condition is false.
	if age >= 18 {
		fmt.println("you can drive")
	} else {
		fmt.println("you cannot drive")
	}

	// Conditions can combine multiple expressions.
	if age >= 18 && age < 65 {
		fmt.println("both conditions are true")
	}
}
