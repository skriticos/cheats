// This program is used for meditation. It outputs random character,
// numbers and symbols with a slight delay. Before it commits to an
// output character, it clears back for a random number of times, making
// the output progress (semi)random too.

package main

import (
	"time"
	"fmt"
	"os"
)

func main() {

	// Read a random number from /dev/urandom.
	// On my first attempt, I used math.rand.Intn, but there is no way
	// to make it act even remotely random. It will always output the
	// same number. I could change it's seed value, but I'd need a
	// random value from an external source first. So then I decided that
	// I could as well take all values from external sources, namely
	// /dev/urandom, which works fine.
	fp, err := os.Open("/dev/urandom")
	defer fp.Close()
	if err != nil {
		panic(err)
	}
	b1 := make([]byte, 1)
	// This works like rand.Intn(), but returns different sequences each
	// time the program runs.
	getRand := func (limit int) int {
		fp.Read(b1)
		return int(b1[0]) % ( limit + 1)
	}

	// program terminates with ctr+c, so loop forever
	for {

		// The thinktime variable holds the number of backspace clears
		// before the algorithm leaves a character on the screen.
		thinktime := getRand(100)
		// The wait time before the next update is made in the output.
		pause := time.Millisecond * 10

		for i := 0; i<thinktime; i++ {

			// Compute a random, printable character in the ASCII table. A
			// rune is just an unsigned 32 bit number.
			outrune := rune(getRand(94) + 32)
			// Leave the previous character on the first run, otherwise
			// clear it.
			if i != 0 {
				fmt.Printf("\b")
			}
			// Print the new, random character. Note how the number needs
			// to be converted to a string for this to work.
			fmt.Printf("%s", string(outrune))
			// Sleep until next update.
			time.Sleep(pause)

		}
	}
}
