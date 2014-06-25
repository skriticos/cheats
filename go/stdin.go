package main

import (
	"fmt"
	"os"
	"io/ioutil"
)

func main() {
	fi, err := os.Stdin.Stat()
	if err != nil {
		panic(err)
	}
	// check if we have anything on stdin
	if fi.Mode() & os.ModeNamedPipe != 0 {
		bytes, _ := ioutil.ReadAll(os.Stdin)
		stdinStr := string(bytes)
		fmt.Printf("%v", stdinStr)
	// nothing on stdin
	} else {
		fmt.Println("nothing to read")
	}
}
