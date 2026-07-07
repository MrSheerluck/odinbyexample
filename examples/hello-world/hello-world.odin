// Our first program will print the classic "hellope" message,
// which is Odin's twist on "hello world". Here's the full
// source code.
//
// To run the program, put the code in a file and use `odin run`:
//
//   $ odin run hello-world.odin -file
//   Hellope!
//
// You can also build it into a binary:
//
//   $ odin build hello-world.odin -file
//   $ ./hello-world
//   Hellope!
//
// Now that we can run and build basic Odin programs, let's
// learn more about the language.
package main

import "core:fmt"

main :: proc() {
	fmt.println("Hellope!")
}
