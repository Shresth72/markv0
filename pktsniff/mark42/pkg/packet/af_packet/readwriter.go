package afpacket

import (
	"github.com/Shresth72/mark42/pkg/packet"

	"github.com/google/gopacket"
	afp "github.com/google/gopacket/afpacket"
	"github.com/google/gopacket/layers"
	"github.com/google/gopacket/pcap"
	"golang.org/x/net/bpf"
)

type Source struct {
	// TPacket implements packet receiving for Linux AF_PACKET versions 1, 2, and 3.
	packetHandler *afp.TPacket
	linkType      layers.LinkType
}

var _ packet.ReadWriter = (*Source)(nil)

func NewPacketSource(iface string, vpnMode bool) (*Source, error) {
	packetHandler, err := afp.NewTPacket(afp.SocketRaw, afp.OptInterface(iface))
	if err != nil {
		return nil, err
	}

	linkType := layers.LinkTypeEthernet
	if vpnMode {
		linkType = layers.LinkTypeIPv4
	}
	return &Source{packetHandler, linkType}, nil
}

/*
bpf.RawInstruction: In this block, the pcap.BPFInstruction objects (returned by pcap.CompileBPFFilter) are converted into bpf.RawInstruction objects. The reason for this conversion is that the pcap.BPFInstruction format might not be directly usable by the AF_PACKET interface, so we need to translate it into a format that Linux AF_PACKET sockets can understand.
Each BPF instruction contains four key fields:

Op: The operation code that tells the BPF what to do with the packet data. For example, Op could be a comparison operation (e.g., "check if the packet is TCP") or a jump operation (e.g., "jump to the next instruction if the comparison fails").

Jt: Jump true – if the condition of the operation is true, the BPF engine will jump to this instruction.

Jf: Jump false – if the condition is false, the BPF engine will jump to this instruction.

K: The operand for the operation (e.g., a specific port number, an IP address, or a value to compare against packet data).
*/
func (s *Source) SetBPFFilter(bpfFilter string, maxPacketLength int) error {
	pcapBPF, err := pcap.CompileBPFFilter(s.linkType, maxPacketLength, bpfFilter)
	if err != nil {
		return err
	}

	bpfIns := make([]bpf.RawInstruction, 0, len(pcapBPF))
	for _, ins := range pcapBPF {
		rawIns := bpf.RawInstruction{
			Op: ins.Code,
			Jt: ins.Jt,
			Jf: ins.Jf,
			K:  ins.K,
		}
		bpfIns = append(bpfIns, rawIns)
	}

	return s.packetHandler.SetBPF(bpfIns)
}

func (s *Source) Close() {
	s.packetHandler.Close()
}

func (s *Source) ReadPacketData() ([]byte, *gopacket.CaptureInfo, error) {
	data, ci, err := s.packetHandler.ZeroCopyReadPacketData()
	return data, &ci, err
}

func (s *Source) WritePacketData(pkt []byte) error {
	return s.packetHandler.WritePacketData(pkt)
}
