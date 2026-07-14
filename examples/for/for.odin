// For is Odin's only looping construct. It can be used
// as a traditional counted loop, a while-style loop,
// or an infinite loop.
//
// The continue statement skips to the next iteration,
// while break exits the loop early.
//
//   $ odin run for.odin -file
//   0
//   1
//   2
//   while: 0
//   while: 1
//   infinite loop
//   continue
//   break

package main

import "core:fmt"

main :: proc() {
	// A traditional counted loop.
	for i := 0; i < 3; i += 1 {
		fmt.println(i)
	}

	// A while-style loop.
	j := 0
	for j < 2 {
		fmt.println("while:", j)
		j += 1
	}

	// An infinite loop.
	for {
		fmt.println("infinite loop")
		break
	}

	// continue skips the rest of the current iteration.
	for i := 0; i < 3; i += 1 {
		if i == 1 {
			fmt.println("continue")
			continue
		}

		if i == 2 {
			fmt.println("break")
			break
		}
	}
}
