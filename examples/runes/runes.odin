// A rune represents a single Unicode code point. It is
// a signed 32-bit integer and a distinct type from i32.
//
// Character literals use single quotes and produce
// untyped rune constants. They can be assigned to a
// rune variable or to an integer type that can hold
// the value.
//
// Strings store UTF-8 encoded bytes. When you iterate
// a string with for-in, Odin decodes UTF-8 into runes.
// Indexing a string still gives bytes (u8), as shown in
// the Strings example.
//
// The core:unicode/utf8 package provides procedures
// for converting between strings and rune slices.
//
//   $ odin run runes.odin -file
//   A
//   65
//   é
//   233
//   世
//   19990
//   A is uppercase
//   3
//   café
//   0 99
//   1 97
//   2 102
//   3 233
//   café

package main

import "core:fmt"
import "core:unicode/utf8"

main :: proc() {
	// A rune literal.
	r := 'A'
	fmt.println(r)

	// Untyped rune constants convert to integers.
	fmt.println(int(r))

	// Multi-byte Unicode characters work too.
	acc := 'é'
	fmt.println(acc)
	fmt.println(int(acc))

	// Characters outside the ASCII range.
	kanji := '世'
	fmt.println(kanji)
	fmt.println(int(kanji))

	// Runes are comparable and ordered.
	if 'A' <= r && r <= 'Z' {
		fmt.println("A is uppercase")
	}

	// Iterate a string to get runes. The index is the
	// byte offset, not the rune index.
	word := "café"
	fmt.println(len(word)) // byte length

	for r, i in word {
		fmt.println(i, r)
	}

	// Convert a string to a []rune slice.
	runes := utf8.string_to_runes(word)
	defer delete(runes)

	// Convert back to a string.
	back := utf8.runes_to_string(runes)
	defer delete(back)
	fmt.println(back)

	// Decode a single rune from a string at a byte
	// offset. The second return value is the number of
	// bytes consumed.
	r2, size := utf8.decode_rune_in_string(word)
	fmt.println(r2, size) // 'c', 1
}