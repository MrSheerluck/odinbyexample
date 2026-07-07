// Our first program will print the classic "hellope" message,
// which is Odin's twist on "hello world". Here's the full
// source code.
//
// To run the program, put the code in a file and use odin run:
//
//   $ odin run hello-world.odin -file
//   Hellope!
//
// Sometimes we'll want to build our programs into binaries.
// We can do this using odin build:
//
//   $ odin build hello-world.odin -file -out:hello-world
//   $ ls
//   hello-world     hello-world.odin
//
// We can then execute the built binary directly:
//
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
