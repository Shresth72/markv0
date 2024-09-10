package afpacket

import (
	"mark42/pkg/packet"

	afp "github.com/google/gopacket/afpacket"
	"github.com/google/gopacket/layers"
	"github.com/google/gopacket/pcap"
)

type Source struct {
  // TPacket implements packet receiving for Linux AF\_PACKET versions 1, 2, and 3.
	handle   *afp.TPacket
	linkType layers.LinkType
}

// var _ packet.ReadWriter = (*Source)(nil)

func NewPacketSource(iface string, vpnMode bool) (*Source, error) {
  handle, err := afp.NewTPacket(afp.SocketRaw, afp.OptInterface(iface))
  if err != nil {
    return nil, err
  }

  linkType := layers.LinkTypeEthernet
  if vpnMode {
    linkType = layers.LinkTypeIPv4
  }
  return &Source{handle, linkType}, nil
}

func (s *Source) SetBPFFilter(bpfFilter string, maxPacketLength int) error {
  pcapBPF, err := pcap.CompileBPFFilter(s.linkType, maxPacketLength, bpfFilter)
  if err != nil {
    return err
  }
}
