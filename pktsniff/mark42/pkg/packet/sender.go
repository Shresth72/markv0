package packet

import (
	"context"

	"github.com/google/gopacket"
)

// Buffer and Error Store
type BufferData struct {
	Buf gopacket.SerializeBuffer
	Err error
}

type Sender interface {
	SendPackets(ctx context.Context, in <-chan *BufferData) (done <-chan interface{}, errchan <-chan error)
}

// Mock Writer or our actual Writer implements this interface
type Writer interface {
	WritePacketData(pkt []byte) error
}

// PacketSender
type PacketSender struct {
	w Writer
}

func NewPacketSender(w Writer) Sender {
	return &PacketSender{w}
}

// if name before output, then chan is just recieve channel
func (s *PacketSender) SendPackets(ctx context.Context, in <-chan *BufferData) (<-chan interface{}, <-chan error) {
	done := make(chan interface{})
	errchan := make(chan error, 100)

	go func() {
		defer func() {
			close(done)
			close(errchan)
		}()

		for {
			select {
			case <-ctx.Done():
				return
			case pkt, ok := <-in:
				if !ok {
					return
				}
				if pkt.Err != nil {
					errchan <- pkt.Err
					continue
				}
				if err := s.w.WritePacketData(pkt.Buf.Bytes()); err != nil {
					errchan <- err
				}
				if err := FreeSerializeBuffer(pkt.Buf); err != nil {
					errchan <- err
				}
			}
		}
	}()

	return done, errchan
}
