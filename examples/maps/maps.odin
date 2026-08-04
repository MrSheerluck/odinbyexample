// Maps store key-value pairs. Keys must be of a
// comparable type, such as strings or integers.
//
// The zero value of a map is nil. Use make to
// create a map before adding entries.
//
// Accessing a missing key returns the zero value
// of the element type. Use the comma-ok idiom or
// the "in" operator to check whether a key exists.
//
// The built-in delete_key procedure removes a key.
// The built-in len procedure returns the number of
// key-value pairs.
//
//   $ odin run maps.odin -file
//   alice: 95
//   bob: 87
//   zero value: 0
//   charlie present: false
//   alice is in the map
//   len: 2
//   len: 1
//   len: 2

package main

import "core:fmt"

main :: proc() {
	// Create a map with string keys and int values.
	scores := make(map[string]int)

	// Add entries.
	scores["alice"] = 95
	scores["bob"] = 87

	fmt.println("alice:", scores["alice"])
	fmt.println("bob:", scores["bob"])

	// Accessing a missing key returns the zero value.
	fmt.println("zero value:", scores["charlie"])

	// Comma-ok idiom: ok is true if the key exists.
	_, ok := scores["charlie"]
	fmt.println("charlie present:", ok)

	// The "in" operator also checks for key existence.
	if "alice" in scores {
		fmt.println("alice is in the map")
	}

	fmt.println("len:", len(scores))

	// Remove a key.
	delete_key(&scores, "bob")
	fmt.println("len:", len(scores))

	scores["charlie"] = 92
	fmt.println("len:", len(scores))

	// Iterate over keys and values. Order is not
	// specified.
	for key, value in scores {
		fmt.println(key, value)
	}
}