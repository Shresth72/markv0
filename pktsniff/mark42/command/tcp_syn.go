package command

import (
	"context"
	"os"
	"os/signal"
	"strings"

	"github.com/Shresth72/mark42/pkg/scan/tcp"
	"github.com/google/gopacket/layers"
	"github.com/spf13/cobra"
)

func newTCPSYNCmd() *tcpSYNCmd {
	c := &tcpSYNCmd{}

	cmd := &cobra.Command{
		Use: "syn [flags] subnet",
		Example: strings.Join(
			[]string{"tcp syn -p 22 192.168.0.1/24", "tcp syn -p 22-4567 10.0.0.1"},
			"\n",
		),
		Short: "Perform TCP SYN scan",
		RunE: func(cmd *cobra.Command, args []string) (err error) {
			ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt)
			defer cancel()

			if err = c.opts.parseRawOptions(); err != nil {
				return
			}
			return c.opts.startScan(ctx, args)
		},
	}

	c.opts.initCliFlags(cmd)

	c.cmd = cmd
	return c
}

type tcpSYNCmd struct {
	cmd  *cobra.Command
	opts tcpSYNCmdOpts
}

type tcpSYNCmdOpts struct {
	tcpCmdOpts
}

func newTCPSYNCmdOpts(opts tcpCmdOpts) *tcpSYNCmdOpts {
	return &tcpSYNCmdOpts{opts}
}

func (o *tcpSYNCmdOpts) startScan(ctx context.Context, args []string) (err error) {
	scanName := tcp.SYNScanType

	if err = o.parseOptions(scanName, args); err != nil {
		return
	}

	m := o.newTCPScanMethod(ctx,
		withTCPScanName(scanName),
		withTCPPacketFillerOptions(tcp.WithSYN()),
		withTCPPacketFilterFunc(func(pkt *layers.TCP) bool {
			// port is open
			return pkt.SYN && pkt.ACK
		}),
		withTCPPacketFlags(tcp.EmptyFlags),
	)

	return startPortScanEngine(ctx, newPacketScanConfig(
		withPacketScanMethod(m),
		withPacketBPFFilter(tcp.SYNACKBPFFilter),
		withRateCount(o.rateCount),
		withRateWindow(o.rateWindow),
		withPacketVPNmode(o.vpnMode),
		withPacketEngineConfig(newEngineConfig(
			withLogger(o.logger),
			withScanRange(o.scanRange),
			withExitDelay(o.exitDelay),
		)),
	))
}
