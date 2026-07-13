// Switch selects one of several code blocks based on
// the value of an expression.
//
// Cases do not fall through by default. Multiple values
// can be matched in a single case by separating them
// with commas.
//
// A switch can also be written without an expression,
// making it behave like a series of if/else statements.
//
//   $ odin run switch.odin -file
//   today is a weekday
//   good evening

package main

import "core:fmt"

main :: proc() {
	day := "Wednesday"

	// Match against the value of an expression.
	switch day {
	case "Saturday", "Sunday":
		fmt.println("today is a weekend")
	case "Monday", "Tuesday", "Wednesday", "Thursday", "Friday":
		fmt.println("today is a weekday")
	case:
		fmt.println("unknown day")
	}

	hour := 21

	// A switch without an expression behaves like
	// a chain of if/else statements.
	switch {
	case hour < 12:
		fmt.println("good morning")
	case hour < 18:
		fmt.println("good afternoon")
	case:
		fmt.println("good evening")
	}
}
