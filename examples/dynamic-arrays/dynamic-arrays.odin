// Dynamic arrays are resizable collections. Unlike
// arrays, they can grow and shrink as elements are
// added or removed.
//
// The built-in append procedure adds one or more
// elements to the end of a dynamic array.
//
// The built-in len procedure returns the number of
// elements, while cap returns the current capacity.
//
//   $ odin run dynamic_arrays.odin -file
//   []
//   [10 20 30]
//   len: 3
//   cap: 8
//   [10 20]

package main

import "core:fmt"

main :: proc() {
	// Declare an empty dynamic array.
	numbers: [dynamic]int

	fmt.println(numbers)

	// Append elements.
	append(&numbers, 10)
	append(&numbers, 20, 30)

	fmt.println(numbers)

	// len returns the number of elements.
	fmt.println("len:", len(numbers))

	// cap returns the current capacity.
	fmt.println("cap:", cap(numbers))

	// Remove the last element.
	pop(&numbers)

	fmt.println(numbers)
}
