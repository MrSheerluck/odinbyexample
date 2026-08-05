// Strings hold UTF-8 encoded text. A string stores
// a pointer to data and a byte length, it does not
// own the underlying memory.
//
// The built-in len procedure returns the number of
// bytes in a string, not the number of characters.
//
// Indexing a string yields a byte (u8), not a rune.
// Use a for loop to iterate over runes, or index
// manually to access individual bytes.
//
// Constant strings can be concatenated with + at
// compile time. Use strings.concatenate for
// runtime concatenation. Strings can be compared
// with == and !=.
//
//   $ odin run strings.odin -file
//   Hellope!
//   len: 8
//   first byte: 72
//   Hellope!
//   Hellope!, world!
//   equal: true
//   0 H
//   1 e
//   2 l
//   3 l
//   4 o
//   5 p
//   6 e
//   7 !
//   bytes: 5
//   0 99
//   1 97
//   2 102
//   3 195
//   4 169

package main

import "core:fmt"
import "core:strings"

main :: proc() {
	// Create a string from a literal.
	s := "Hellope!"
	fmt.println(s)

	// len returns the number of bytes.
	fmt.println("len:", len(s))

	// Indexing returns a byte (u8).
	fmt.println("first byte:", s[0])

	// + concatenates constant strings at compile time.
	fmt.println("Hello" + "pe!")

	// For variables, use strings.concatenate.
	greeting := strings.concatenate({s, ", world!"})
	fmt.println(greeting)

	// Compare strings with == and !=.
	fmt.println("equal:", s == "Hellope!")

	// Iterate over runes. Odin decodes UTF-8
	// automatically.
	for r, i in s {
		fmt.println(i, r)
	}

	// UTF-8: len counts bytes, not characters.
	word := "café"
	fmt.println("bytes:", len(word))

	// Indexing gives raw bytes. The é character
	// uses two bytes in UTF-8.
	for i in 0..<len(word) {
		fmt.println(i, word[i])
	}
}