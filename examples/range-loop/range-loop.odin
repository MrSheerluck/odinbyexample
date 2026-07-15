// The for-in loop iterates over the elements of a
// collection. Depending on the collection, you can
// access the value, the index, or both.
//
//   $ odin run range-loops.odin -file
//   10
//   20
//   30
//   0 10
//   1 20
//   2 30

package main

import "core:fmt"

main :: proc() {
	// An array to iterate over.
	numbers := [3]int{10, 20, 30}

	// Iterate over the values.
	for value in numbers {
		fmt.println(value)
	}

	// Iterate over both the index and value.
	for index, value in numbers {
		fmt.println(index, value)
	}
}
