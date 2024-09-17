package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestParseMac(t *testing.T) {
	macAddr, _ := parseMAC("00:15:5d:f6:10:57")
	assert.Equal(t, "", macAddr, "not equal")
}
