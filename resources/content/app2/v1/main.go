package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("Hello world v1")
	// for loop terminates when i becomes 6
	for i := 1; i >= 0; i++ {
		time.Sleep(5 * time.Second)
	}

}
