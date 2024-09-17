package utils

import (
	"fmt"
	"strings"
	"syscall"
	"unsafe"
)

type AttachMode int

const (
	AttachModeXdp AttachMode = iota
)

// Config holds configuration parameters for the XDP program.
type Config struct {
	XdpProgPath     string
	Ifindex         string
	Ifname          string
	RedirectIfindex string
	RedirectIfname  string
	DoUnload        bool
	ProgID          uint32
	ReuseMaps       bool
	PinDir          string
	Filename        string
	Progname        string
	SrcMac          string
	DestMac         string
	XskBindFlags    uint16
	XskIfQueue      int
	XskPollMode     bool
	UnloadAll       bool
}

var Verbose int

const (
	IFNAMSIZ = 16
)

type ifreq struct {
	Name [IFNAMSIZ]byte
	Data uintptr
}

func GetIfaceName(ifindex uint32) (string, error) {
	s, err := syscall.Socket(syscall.AF_INET, syscall.SOCK_DGRAM, 0)
	if err != nil {
		return "", fmt.Errorf("socket creation failed: %v", err)
	}
	defer syscall.Close(s)

	var ifr ifreq
	ifr.Data = uintptr(ifindex)

	_, _, errno := syscall.Syscall(
		syscall.SYS_IOCTL,
		uintptr(s),
		syscall.SIOCGIFNAME,
		uintptr(unsafe.Pointer(&ifr)),
	)
	if errno != 0 {
		return "", fmt.Errorf("ioctl SIOCGIFNAME failed: %v", errno)
	}

	ifaceName := string(ifr.Name[:])
	ifaceName = strings.TrimRight(ifaceName, "\x00")
	return ifaceName, nil
}

func GetIfIndex(ifaceName string) (uint32, error) {
	// Create a socket for the ioctl system call
	s, err := syscall.Socket(syscall.AF_INET, syscall.SOCK_DGRAM, 0)
	if err != nil {
		return 0, fmt.Errorf("socket creation failed: %v", err)
	}
	defer syscall.Close(s)

	// Prepare the ifreq structure
	var ifr ifreq
	copy(ifr.Name[:], ifaceName)

	// Perform the ioctl call to get the interface index
	_, _, errno := syscall.Syscall(
		syscall.SYS_IOCTL,
		uintptr(s),
		syscall.SIOCGIFINDEX,
		uintptr(unsafe.Pointer(&ifr)),
	)
	if errno != 0 {
		return 0, fmt.Errorf("ioctl SIOCGIFINDEX failed: %v", errno)
	}

	return uint32(ifr.Data), nil
}
