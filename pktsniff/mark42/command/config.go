package command

import (
	"errors"
	"net"
	"strings"
	"time"

	"github.com/spf13/cobra"
)

const (
	cliHTTPProtoFlag  = "http"
	cliHTTPSProtoFlag = "https"

	defaultWorkerCount = 100
	defaultTimeout     = 5 * time.Second
	defaultExitDelay   = 300 * time.Millisecond
)

var (
	errSrcIP         = errors.New("invalid source IP")
	errSrcMAC        = errors.New("invalid source MAC")
	errSrcInterface  = errors.New("invalid source interface")
	errRateLimit     = errors.New("invalid ratelimit")
	errARPCacheStdin = errors.New("ARP cache is expected from file or stdin pipe")
	errIPFlags       = errors.New("invalid ip flags")
	errNoDstIP       = errors.New("requires one ip subnet argument or file with ip/port pairs")
	errARPStdin      = errors.New("ARP cache and IP file can not be read from stdin at the same time")
)

type packetScanCmdOpts struct {
	json       bool
	iface      *net.Interface
	srcIP      net.IP
	srcMAC     net.HardwareAddr
	rateCount  int
	rateWindow time.Duration
	exitDelay  time.Duration
	// excludeIPs scan.IPContainer

	rawInterface   string
	rawSrcMAC      string
	rawRateLimit   string
	rawExcludeFile string
}

func (o *packetScanCmdOpts) initCliFlags(cmd *cobra.Command) {
	cmd.Flags().BoolVar(&o.json, "json", false, "enable JSON output")
	cmd.Flags().StringVarP(&o.rawInterface, "iface", "i", "", "set interface to send/receive packets")
	cmd.Flags().IPVar(&o.srcIP, "srcip", nil, "set source IP address for generated packets")
	cmd.Flags().StringVar(&o.rawSrcMAC, "srcmac", "", "set source MAC address for generated packets")
	cmd.Flags().StringVar(&o.rawExcludeFile, "exclude", "",
		strings.Join([]string{
			"set file with IPs or subnets in CIDR notation to exclude, one-per line.",
			"It is useful to exclude RFC 1918 addresses, multicast, IANA reserved space, and other IANA special-purpose addresses."}, "\n"))
	cmd.Flags().StringVarP(&o.rawRateLimit, "rate", "r", "",
		strings.Join([]string{
			"set rate limit for generated packets",
			`format: "rateCount/rateWindow"`,
			"where rateCount is a number of packets, rateWindow is the time interval",
			"e.g. 1000/s -- 1000 packets per second", "500/7s -- 500 packets per 7 seconds\n"}, "\n"))
	cmd.Flags().DurationVar(&o.exitDelay, "exit-delay", defaultExitDelay,
		strings.Join([]string{
			"set exit delay to wait for last response packets",
			"any expression accepted by time.ParseDuration is valid"}, "\n"))
}

func (o *packetScanCmdOpts) parseRawOptions() (err error) {
	if len(o.rawInterface) > 0 {
		if o.iface, err = net.InterfaceByName(o.rawInterface); err != nil {
			return
		}
	}
	if len(o.rawSrcMAC) > 0 {
		if o.srcMAC, err = net.ParseMAC(o.rawSrcMAC); err != nil {
			return
		}
	}
	// if len(o.rawRateLimit) > 0 {
	// 	if o.rateCount, o.rateWindow, err = parseRateLimit(o.rawRateLimit); err != nil {
	// 		return
	// 	}
	// }
	// if len(o.rawExcludeFile) > 0 {
	// 	if o.excludeIPs, err = parseExcludeFile(func() (io.ReadCloser, error) {
	// 		return os.Open(o.rawExcludeFile)
	// 	}); err != nil {
	// 		return
	// 	}
	// }
	return
}

func (o *packetScanCmdOpts) getScanRange(dstSubnet *net.IPNet) (*scan.Range, error) {
	iface, srcIP, err := o.getInterface(dstSubnet)
	if err != nil {
		return nil, err
	}
	if iface == nil {
		return nil, errSrcInterface
	}

	if o.srcIP != nil {
		srcIP = o.srcIP
	}
	if srcIP == nil {
		return nil, errSrcIP
	}

	srcMAC := iface.HardwareAddr
	if o.srcMAC != nil {
		srcMAC = o.srcMAC
	}

	return &scan.Range{
		Interface: iface,
		DstSubnet: dstSubnet,
		SrcIP:     srcIP.To4(),
		SrcMAC:    srcMAC}, nil
}

func (o *packetScanCmdOpts) getInterface(dstSubnet *net.IPNet) (iface *net.Interface, ifaceIP net.IP, err error) {
	if dstSubnet != nil {
		// try to find directly connected interface
		if iface, ifaceIP, err = o.getLocalSubnetInterface(dstSubnet); err != nil {
			return
		}
		// found local interface
		if iface != nil && ifaceIP != nil {
			return
		}
	}
	if o.iface != nil {
		// try to get first ip address
		ifaceIP, err = ip.GetInterfaceIP(o.iface)
		return o.iface, ifaceIP, err
	}
	// fallback to interface of default gateway
	return ip.GetDefaultInterface()
}

func (o *packetScanCmdOpts) getLocalSubnetInterface(dstSubnet *net.IPNet) (iface *net.Interface, ifaceIP net.IP, err error) {
	if o.iface == nil {
		return ip.GetLocalSubnetInterface(dstSubnet)
	}
	ifaceIP, err = ip.GetLocalSubnetInterfaceIP(o.iface, dstSubnet)
	return o.iface, ifaceIP, err
}

func (o *packetScanCmdOpts) getLogger(name string, w io.Writer) (logger log.Logger, err error) {
	opts := []log.LoggerOption{log.FlushInterval(1 * time.Second)}
	if o.json {
		opts = append(opts, log.JSON())
	}
	logger, err = log.NewLogger(w, name, opts...)
	return
}

type ipScanCmdOpts struct {
	packetScanCmdOpts
	ipFile       string
	arpCacheFile string
	gatewayMAC   net.HardwareAddr
	vpnMode      bool

	logger    log.Logger
	scanRange *scan.Range
	// cache     *arp.Cache

	rawGatewayMAC string
}

func (o *ipScanCmdOpts) initCliFlags(cmd *cobra.Command) {
	o.packetScanCmdOpts.initCliFlags(cmd)
	cmd.Flags().StringVar(&o.rawGatewayMAC, "gwmac", "", "set gateway MAC address to send generated packets to")
	cmd.Flags().StringVarP(&o.ipFile, "file", "f", "", "set JSONL file with IPs to scan")
	cmd.Flags().StringVarP(&o.arpCacheFile, "arp-cache", "a", "",
		strings.Join([]string{"set ARP cache file", "reads from stdin by default"}, "\n"))
}

func (o *ipScanCmdOpts) parseRawOptions() (err error) {
	if err = o.packetScanCmdOpts.parseRawOptions(); err != nil {
		return
	}
	if len(o.rawGatewayMAC) > 0 {
		if o.gatewayMAC, err = net.ParseMAC(o.rawGatewayMAC); err != nil {
			return
		}
	}
	return
}

func (o *ipScanCmdOpts) parseOptions(scanName string, args []string) (err error) {

	dstSubnet, err := o.parseDstSubnet(args)
	if err != nil {
		return
	}
	if o.scanRange, err = o.getScanRange(dstSubnet); err != nil {
		return
	}
	if o.scanRange.SrcMAC == nil {ayu
		o.vpnMode = true
	}

	if o.logger, err = o.getLogger(scanName, os.Stdout); err != nil {
		return
	}

	// disable arp cache parsing for vpn mode
	if o.vpnMode {
		return
	}
	if err = o.validateARPStdin(); err != nil {
		return
	}

	if o.cache, err = o.parseARPCache(); err != nil {
		return
	}

	if o.gatewayMAC, err = o.getGatewayMAC(o.scanRange.Interface, o.cache); err != nil {
		return
	}
	return
}
