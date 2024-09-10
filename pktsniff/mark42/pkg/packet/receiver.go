package packet

import (
	"context"
	"errors"
	"io"
	"net"
	"strings"
	"syscall"
	"time"

	"github.com/google/gopacket"
)

// Processor
type Processor interface {
	ProcesPacketData(data []byte, ci *gopacket.CaptureInfo) error
}

// Reader
type Reader interface {
	ReadPacketData() (data []byte, ci *gopacket.CaptureInfo, err error)
}

// Receiver
type Receiver interface {
	ReceivePackets(ctx context.Context) <-chan error
}

type PacketReceiver struct {
	sr Reader
	p  Processor
}

func NewReceiver(sr Reader, p Processor) Receiver {
	return &PacketReceiver{sr, p}
}

func isTemporaryError(err error) bool {
	if errors.Is(err, syscall.EAGAIN) || errors.Is(err, syscall.ECONNRESET) {
		return true
	}
	nerr, ok := err.(net.Error)
	return ok && nerr.Timeout()
}

func isUnrecoverableError(err error) bool {
	switch err {
	case io.EOF, io.ErrUnexpectedEOF, io.ErrNoProgress,
		io.ErrClosedPipe, io.ErrShortBuffer, syscall.EBADF:
		return true
	default:
		return strings.Contains(err.Error(), "use of closed file")
	}
}

func (r *PacketReceiver) ReceivePackets(ctx context.Context) <-chan error {
	errchan := make(chan error, 100)
	go func() error {
		defer close(errchan)
		for {
			select {
			case <-ctx.Done():
				return <-errchan
			default:
			}

			data, ci, err := r.sr.ReadPacketData()
			if err != nil {
				// Immediately retry for temporary errors
				if isTemporaryError(err) {
					continue
				}
				if isUnrecoverableError(err) {
					return <-errchan
				}

				// Log unknown error
				select {
				case <-ctx.Done():
					return <-errchan
				case errchan <- err:
				}

				// Sleep briefly and try again
				time.Sleep(5 * time.Millisecond)
				continue
			}

			if err := r.p.ProcesPacketData(data, ci); err != nil {
				select {
				case <-ctx.Done():
					return <-errchan
				case errchan <- err:
				}
			}
		}
	}()

	return errchan
}
