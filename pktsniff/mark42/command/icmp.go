package command

import (
	"context"
	"io"
	"os"
	"os/signal"
	"runtime"
	"strings"

	"github.com/Shresth72/mark42/pkg/scan"
	"github.com/Shresth72/mark42/pkg/scan/arp"
	"github.com/Shresth72/mark42/pkg/scan/icmp"
	"github.com/spf13/cobra"
)

func newICMPCmd() *icmpCmd {
	c := &icmpCmd{}

	cmd := &cobra.Command{
		Use: "icmp [flags] subnet",
		Example: strings.Join([]string{
			"icmp 192.168.0.1/24",
			"icmp --ttl 37 192.168.0.1/24",
			"icmp --ipproto 157 192.168.0.1/24",
			`icmp --type 13 --code 0 --payload '\x01\x02\x03' 10.0.0.1`}, "\n"),
		Short: "Perform ICMP scan",
		RunE: func(cmd *cobra.Command, args []string) (err error) {
			ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt)
			defer cancel()

			if err = c.opts.parseRawOptions(); err != nil {
				return
			}
			if err = c.opts.parseOptions(icmp.ScanType, args); err != nil {
				return
			}

			m := c.opts.newICMPScanMethod(ctx)

			return startPacketScanEngine(ctx, newPacketScanConfig(
				withPacketScanMethod(m),
				withPacketBPFFilter(icmp.BPFFilter),
				withRateCount(c.opts.rateCount),
				withRateWindow(c.opts.rateWindow),
				withPacketVPNmode(c.opts.vpnMode),
				withPacketEngineConfig(newEngineConfig(
					withLogger(c.opts.logger),
					withScanRange(c.opts.scanRange),
					withExitDelay(c.opts.exitDelay),
				)),
			))
		},
	}

	c.opts.initCliFlags(cmd)

	c.cmd = cmd
	return c
}

type icmpCmd struct {
	cmd  *cobra.Command
	opts icmpCmdOpts
}

type icmpCmdOpts struct {
	ipScanCmdOpts
	ipTTL      uint8
	ipFlags    uint8
	ipProtocol uint8
	ipTotalLen uint16

	icmpType    uint8
	icmpCode    uint8
	icmpPayload []byte

	rawIPFlags     string
	rawICMPPayload string
}

func (o *icmpCmdOpts) initCliFlags(cmd *cobra.Command) {
	o.ipScanCmdOpts.initCliFlags(cmd)
	cmd.Flags().Uint8Var(&o.ipTTL, "ttl", 64, "set IP TTL field of generated packet")
	cmd.Flags().Uint8Var(&o.ipProtocol, "ipproto", 1,
		strings.Join([]string{"set IP Protocol field of generated packet", "ICMP by default"}, "\n"),
	)
	cmd.Flags().StringVar(&o.rawIPFlags, "ipflags", "DF", "set IP Flags field of generated packet")
	cmd.Flags().Uint16Var(&o.ipTotalLen, "iplen", 0,
		strings.Join([]string{"set IP Total Length field of generated packet", "calculated by default"}, "\n"),
	)

	cmd.Flags().Uint8VarP(&o.icmpType, "type", "t", 8,
		strings.Join([]string{"set ICMP type of generated packet", "ICMP Echo (Type 8) by default"}, "\n"),
	)
	cmd.Flags().Uint8VarP(&o.icmpCode, "code", "c", 0, "set ICMP code of generated packet")
	cmd.Flags().StringVarP(&o.rawICMPPayload, "payload", "p", "",
		strings.Join([]string{"set byte payload of generated packet", "48 random bytes by default"}, "\n"),
	)
}

func (o *icmpCmdOpts) parseRawOptions() (err error) {
	if err = o.ipScanCmdOpts.parseRawOptions(); err != nil {
		return
	}
	if len(o.rawIPFlags) > 0 {
		if o.ipFlags, err = parseIPFlags(o.rawIPFlags); err != nil {
			return
		}
	}
	if len(o.rawICMPPayload) > 0 {
		if o.icmpPayload, err = parsePacketPayload(o.rawICMPPayload); err != nil {
			return
		}
	}
	return
}

func (o *icmpCmdOpts) newICMPScanMethod(ctx context.Context) *icmp.ScanMethod {
	ipgen := scan.NewIPGenerator()
	if len(o.ipFile) > 0 {
		ipgen = scan.NewFileIPGenerator(func() (io.ReadCloser, error) {
			return os.Open(o.ipFile)
		})
	}
	reqgen := scan.NewIPRequestGenerator(ipgen)
	if o.excludeIPs != nil {
		reqgen = scan.NewFilterIPRequestGenerator(reqgen, o.excludeIPs)
	}
	if o.cache != nil {
		reqgen = arp.NewCacheRequestGenerator(reqgen, o.gatewayMAC, o.cache)
	}
	pktgen := scan.NewPacketMultiGenerator(
		icmp.NewPacketFiller(o.getICMPOptions()...),
		runtime.NumCPU(),
	)
	psrc := scan.NewPacketSource(reqgen, pktgen)
	results := scan.NewResultChan(ctx, 1000)
	return icmp.NewScanMethod(psrc, results, o.vpnMode)
}

func (o *icmpCmdOpts) getICMPOptions() (opts []icmp.PacketFillerOption) {
	opts = append(opts,
		icmp.WithTTL(o.ipTTL),
		icmp.WithIPProtocol(o.ipProtocol),
		icmp.WithIPFlags(o.ipFlags),
		icmp.WithIPTotalLength(o.ipTotalLen),
		icmp.WithType(o.icmpType),
		icmp.WithCode(o.icmpCode),
		icmp.WithVPNmode(o.vpnMode))

	if len(o.icmpPayload) > 0 {
		opts = append(opts, icmp.WithPayload(o.icmpPayload))
	}
	return
}
