package utils

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGetIfaceName(t *testing.T) {
	iface, _ := GetIfaceName(uint32(2))
	assert.Equal(t, "eth0", iface, "iface name doesn't match")
}

func TestGetIfaceIndex(t *testing.T) {
	iface, _ := GetIfIndex("eth0")
	assert.Equal(t, uint32(2), iface, "iface index doesn't match")
}
