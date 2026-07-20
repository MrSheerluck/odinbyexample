// Slices provide a view into an array. Unlike arrays,
// slices do not own their data and their size is not
// part of their type.
//
// A slice is created by slicing an array or by using
// a slice literal. Multiple slices can refer to the
// same underlying array.
//
// The built-in len procedure returns the number of
// elements in a slice.
//
//   $ odin run slices.odin -file
//   [2 3 4]
//   first: 2
//   len: 3
//   [1 20 3 4 5]

package main

import "core:fmt"

main :: proc() {
	// Create an array.
	numbers := [5]int{1, 2, 3, 4, 5}

	// Create a slice that refers to part of the array.
	s := numbers[1:4]

	fmt.println(s)

	// Access elements by index.
	fmt.println("first:", s[0])

	// len returns the number of elements.
	fmt.println("len:", len(s))

	// Modifying a slice also modifies the
	// underlying array.
	s[1] = 20

	fmt.println(numbers)
}
