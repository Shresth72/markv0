package main

import (
	"flag"
	"fmt"
	"log"
	"net"
	"os"
	"path/filepath"

	"github.com/cilium/ebpf"
)

var (
	help        = flag.Bool("help", false, "Show help")
	dev         = flag.String("dev", "", "Operate on device <ifname>")
	redirectDev = flag.String("redirect-dev", "", "Redirect to device <ifname>")
	srcMAC      = flag.String("src-mac", "", "Source MAC address of <dev>")
	destMAC     = flag.String("dest-mac", "", "Destination MAC address of <redirect-dev>")
	quiet       = flag.Bool("quiet", false, "Quiet mode (no output)")
	pinBasedir  = "/sys/fs/bpf"
)

func main() {
	flag.Parse()

	if *help {
		flag.Usage()
		os.Exit(0)
	}

	if *dev == "" {
		log.Fatal("ERR: required option --dev missing")
	}

	// Parse MAC addresses
	src, err := parseMAC(*srcMAC)
	if err != nil {
		log.Fatalf("ERR: can't parse MAC address %s: %v", *srcMAC, err)
	}
	dest, err := parseMAC(*destMAC)
	if err != nil {
		log.Fatalf("ERR: can't parse MAC address %s: %v", *destMAC, err)
	}
}
