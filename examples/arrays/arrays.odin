// Arrays are fixed-size collections of elements of the
// same type. The number of elements is part of the array's
// type and cannot be changed after it is declared.
//
// Array elements are accessed using zero-based indexing.
// The built-in len procedure returns the number of
// elements in an array.
//
//   $ odin run arrays.odin -file
//   empty: [0 0 0 0 0]
//   values: [1 2 3 4 5]
//   first: 1
//   last: 5
//   len: 5

package main

import "core:fmt"

main :: proc() {
	// Declare an array of five integers.
	numbers: [5]int
	fmt.println("empty:", numbers)

	// Assign values using their indices.
	numbers[0] = 1
	numbers[1] = 2
	numbers[2] = 3
	numbers[3] = 4
	numbers[4] = 5

	fmt.println("values:", numbers)

	// Access individual elements.
	fmt.println("first:", numbers[0])
	fmt.println("last:", numbers[4])

	// len returns the number of elements.
	fmt.println("len:", len(numbers))
}
