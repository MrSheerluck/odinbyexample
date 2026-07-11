// Procedures in Odin can return multiple values. This is
// commonly used to return a result along with additional
// information, such as an error or status.
//
// Return types are listed inside parentheses after the
// -> operator. Multiple values are returned using the
// return statement.
//
//   $ odin run multiple-return-values.odin -file
//   7 3
//   Odin language

package main

import "core:fmt"

// Divide returns both the quotient and remainder.
divide :: proc(a, b: int) -> (int, int) {
	return a / b, a % b
}

// split returns two strings.
split :: proc() -> (string, string) {
	return "Odin", "language"
}

main :: proc() {
	quotient, remainder := divide(31, 4)
	fmt.println(quotient, remainder)

	first, second := split()
	fmt.println(first, second)
}
