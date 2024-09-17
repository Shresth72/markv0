package main

import (
	"flag"
	"fmt"
	"net"
	"os"
	"strconv"
	"strings"

	"github.com/cilium/ebpf"
	"github.com/cilium/ebpf/link"

	"github.com/Shresth72/redirect/pkg/utils"
)

const (
	ETH_ALEN         = 6
	EXIT_OK          = 0
	EXIT_FAIL        = 1
	EXIT_FAIL_OPTION = 2
	EXIT_FAIL_XDP    = 30
	EXIT_FAIL_BPF    = 40
	pinBasedir       = "/sys/fs/bpf"
)

func parseU8(str string) (byte, error) {
	val, err := strconv.ParseUint(str, 16, 8)
	if err != nil {
		return 0, err
	}
	return byte(val), nil
}

func parseMAC(str string) ([ETH_ALEN]byte, error) {
	var mac [6]byte

	// MAC address should be in the format "xx:xx:xx:xx:xx:xx"
	parts := strings.Split(str, ":")
	if len(parts) != 6 {
		return mac, fmt.Errorf("invalid MAC address format")
	}

	for i, part := range parts {
		if len(part) != 2 {
			return mac, fmt.Errorf("invalid MAC address segment length")
		}
		b, err := parseU8(part)
		if err != nil {
			return mac, fmt.Errorf("failed to parse MAC address segment: %v", err)
		}
		mac[i] = b
	}

	return mac, nil
}

func writeIfaceParams(mapObj *ebpf.Map, src, dest [ETH_ALEN]byte) error {
	err := mapObj.Update(src[:], dest[:], ebpf.UpdateAny)
	if err != nil {
		fmt.Printf("WARN: failed to update BPF map: %v\n", err)
		return err
	}
	fmt.Printf("forward: %02x:%02x:%02x:%02x:%02x:%02x -> %02x:%02x:%02x:%02x:%02x:%02x\n",
		src[0], src[1], src[2], src[3], src[4], src[5],
		dest[0], dest[1], dest[2], dest[3], dest[4], dest[5],
	)
	return nil
}

func main() {
	cfg := utils.Config{}
	flag.StringVar(&cfg.Ifindex, "dev", "", "Operate on device <ifname>")
	flag.StringVar(&cfg.RedirectIfindex, "redirect-dev", "", "Redirect to device <ifname>")
	flag.StringVar(&cfg.SrcMac, "src-mac", "", "Source MAC address of <dev>")
	flag.StringVar(&cfg.DestMac, "dest-mac", "", "Destination MAC address of <redirect-dev>")
	flag.StringVar(
		&cfg.XdpProgPath,
		"xdp",
		"../xdp_redirect_to_iface_kern.o",
		"Path to the XDP object file",
	)

	flag.Parse()

	spec, err := ebpf.LoadCollectionSpec(*&cfg.XdpProgPath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Failed to load XDP object: %v\n", err)
		os.Exit(EXIT_FAIL_BPF)
	}

	coll, err := ebpf.NewCollection(spec)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Failed to create BPF collection: %v\n", err)
		os.Exit(EXIT_FAIL_BPF)
	}
	defer coll.Close()

	iface, err := net.InterfaceByName(cfg.Ifindex)
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERR: failed to find interface: %v\n", err)
		os.Exit(EXIT_FAIL)
	}

	prog := coll.Programs["xdp_redirect_map_func"]
	if prog == nil {
		fmt.Fprintf(os.Stderr, "ERR: failed to find BPF program\n")
		os.Exit(EXIT_FAIL)
	}

	lnk, err := link.AttachXDP(link.XDPOptions{
		Program:   prog,
		Interface: iface.Index,
	})
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERR: failed to attach XDP program: %v\n", err)
		os.Exit(EXIT_FAIL_XDP)
	}
	defer lnk.Close()

	srcMAC, err := parseMAC(cfg.SrcMac)
	if err != nil {
		fmt.Printf("ERR: can't parse mac address %s\n", cfg.SrcMac)
		os.Exit(EXIT_FAIL)
	}

	destMAC, err := parseMAC(cfg.DestMac)
	if err != nil {
		fmt.Printf("ERR: can't parse mac address %s\n", cfg.DestMac)
		os.Exit(EXIT_FAIL)
	}

	redirectParamsMap := coll.Maps["redirect_params"]
	if redirectParamsMap == nil {
		fmt.Fprintf(os.Stderr, "ERR: failed to find redirect_params map\n")
		os.Exit(EXIT_FAIL_BPF)
	}

	if err := writeIfaceParams(redirectParamsMap, srcMAC, destMAC); err != nil {
		fmt.Fprintf(os.Stderr, "ERR: failed to update redirect_params map: %v\n", err)
		os.Exit(EXIT_FAIL_BPF)
	}

	// Update tx_port map with destination interface index
	txPortMap := coll.Maps["tx_port"]
	if txPortMap == nil {
		fmt.Fprintf(os.Stderr, "ERR: failed to find tx_port map\n")
		os.Exit(EXIT_FAIL_BPF)
	}

	redirectIface, err := net.InterfaceByName(cfg.RedirectIfindex)
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERR: failed to find redirect interface: %v\n", err)
		os.Exit(EXIT_FAIL)
	}

	key := uint32(0) // Assuming key 0 is used in the BPF program
	if err := txPortMap.Update(key, redirectIface.Index, ebpf.UpdateAny); err != nil {
		fmt.Fprintf(os.Stderr, "ERR: failed to update tx_port map: %v\n", err)
		os.Exit(EXIT_FAIL_BPF)
	}

	fmt.Println("Successfully updated BPF maps and attached XDP program")
	os.Exit(EXIT_OK)
}
