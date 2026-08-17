// A pointer is a value that holds the memory address of
// another value. The type ^T is a pointer to a T value.
// Pointers allow code to share and mutate a value without
// copying it.
//
// The & operator takes the address of its operand, and the ^
// operator dereferences a pointer, reading or writing the
// value it points to.
//
// The zero value of a pointer is nil. Reading through a nil
// pointer causes a runtime panic, so check before using.
//
// Note: unlike C, Odin uses ^ for pointers (Pascal style)
// instead of *. There is no pointer arithmetic; use
// ptr_offset in "core:mem" if you need it.
//
//   $ odin run pointers.odin -file
//   read through p: 123
//   wrote through p: 1337
//   zero value is nil: true
//   moved x: 99
//   swapped: a = 2 b = 1
//   double: 10

package main

import "core:fmt"

Point :: struct {
	x, y: int,
}

main :: proc() {
	// & takes the address of a variable; p has type ^int.
	i := 123
	p := &i

	// ^ dereferences: read and write through the pointer.
	fmt.println("read through p:", p^)
	p^ = 1337
	fmt.println("wrote through p:", i)

	// A pointer with no address is nil.
	q: ^int
	fmt.println("zero value is nil:", q == nil)

	// Struct fields can be reached through a pointer without
	// an explicit dereference: p.x means p^.x.
	pt := Point{1, 2}
	pp := &pt
	pp.x = 99
	fmt.println("moved x:", pt.x)

	// Passing pointers lets a procedure mutate its arguments.
	swap :: proc(a, b: ^int) {
		tmp := a^
		a^ = b^
		b^ = tmp
	}
	x, y := 1, 2
	swap(&x, &y)
	fmt.println("swapped: a =", x, "b =", y)

	// Pointer to a pointer: ^^int dereferences twice.
	n := 5
	pn := &n
	ppn := &pn
	ppn^^ = 10
	fmt.println("double:", n)
}
