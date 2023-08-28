package helpers

import "log"

func getError(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
