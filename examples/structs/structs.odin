// Structs group named fields into a single type.
// Define a struct with the struct keyword and access
// fields with dot notation.
//
// Struct literals create values. Supply all fields
// positionally, use named fields for partial init,
// or use an empty literal for the zero value.
//
// Fields can be accessed through a pointer without
// explicit dereferencing: p.x works when p is ^T.
//
//   $ odin run structs.odin -file
//   Alice is 30 years old
//   Bob is 0 years old
//   name: Alice age: 31
//   point: 3, 4
//   zero name: true zero age: true
//   age after pointer: 32

package main

import "core:fmt"

Person :: struct {
	name: string,
	age:  int,
}

Point :: struct {
	x, y: int,
}

main :: proc() {
	// Struct literal with named fields.
	alice := Person{name = "Alice", age = 30}
	fmt.printf("%s is %d years old\n", alice.name, alice.age)

	// Named fields can be partial; others are zero.
	bob := Person{name = "Bob"}
	fmt.printf("%s is %d years old\n", bob.name, bob.age)

	// Modify fields after creation.
	alice.age = 31
	fmt.println("name:", alice.name, "age:", alice.age)

	// Positional literal when all fields are given.
	p := Point{3, 4}
	fmt.printf("point: %d, %d\n", p.x, p.y)

	// Zero value: empty string and zero int.
	empty := Person{}
	fmt.println("zero name:", empty.name == "", "zero age:", empty.age == 0)

	// Access fields through a pointer.
	ptr := &alice
	ptr.age = 32
	fmt.println("age after pointer:", alice.age)
}