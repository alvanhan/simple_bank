package util

import (
	"math/rand"
	"strings"
	"time"
)

const alpha = "abcdefghijklmnopqrstuvwxyz"

func init() {
	rand.New(rand.NewSource(time.Now().UnixNano()))
}

func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

func RandomString(n int) string {
	var sb strings.Builder
	k := len(alpha)

	for i := 0; i < n; i++ {
		sb.WriteByte(alpha[rand.Intn(k)])
	}

	return sb.String()
}

func RandOwner() string {
	return RandomString(6)
}

func RandMoney() int64 {
	return RandomInt(0, 1000)
}

func RandCurreny() string {
	curren := []string{"IDR", "USD", "JPY"}
	n := len(curren)
	return curren[rand.Intn(n)]
}

func RandomMoney() int64 {
	return RandomInt(0, 1000)
}
