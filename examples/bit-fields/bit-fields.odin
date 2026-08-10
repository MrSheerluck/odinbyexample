// Bit fields pack many small values into one integer-sized
// record. Think of them as a bit-packed struct.
//
// Declare one with the bit_field keyword followed by the
// backing type: an integer or a fixed-length array of
// integers. Each field gives a type, then `|` and the number
// of bits it occupies. Field names and bit widths must add up
// to fit inside the backing type.
//
// Fields are read and written with dot notation, just like a
// struct. Writing truncates the value to the field's bit
// width. Reading a signed field sign-extends it back to its
// declared type.
//
//   $ odin run bit-fields.odin -file
//   flags size: 2
//   active: true mode: 2 count: -3
//   count after: 3
//   header size: 4
//   version: 9 kind: Green seq: 7
//   seq max: 15
//
// Odin's bit_field layout is well-defined (least-significant
// bit first), unlike C's bit fields which are not portable
// across compilers and targets.

package main

import "core:fmt"

// 1 + 2 + 3 + 10 = 16 bits, the size of the u16 backing type.
Flags :: bit_field u16 {
	active:  bool | 1,
	mode:    u16  | 2,
	count:   i32  | 3,
	padding: u16  | 10,
}

// An enum can be stored in a bit field to save space.
Color :: enum u8 {Red, Green, Blue}

// 4 + 2 + 4 + 22 = 32 bits, filling the u32 exactly.
Header :: bit_field u32 {
	version: u16   | 4,
	kind:    Color | 2,
	seq:     u8    | 4,
	rest:    u32   | 22,
}

main :: proc() {
	// Fields default to their zero value.
	f := Flags{}
	fmt.println("flags size:", size_of(Flags))

	// Write and read fields with dot notation.
	f.active = true
	f.mode = 2
	f.count = -3
	fmt.println("active:", f.active, "mode:", f.mode, "count:", f.count)

	// The count field is only 3 bits wide. Its signed range is
	// -4..3, so a value that does not fit is truncated.
	f.count = 3
	fmt.println("count after:", f.count)

	// Enum and integer fields can share a record.
	h := Header{}
	h.version = 9
	h.kind = .Green
	h.seq = 7
	fmt.println("header size:", size_of(Header))
	fmt.println("version:", h.version, "kind:", h.kind, "seq:", h.seq)

	// A 4-bit field holds values from 0 to 15.
	h.seq = 15
	fmt.println("seq max:", h.seq)
}
