package packet

import (
	"context"
	"errors"
	"fmt"
	"testing"

	"github.com/golang/mock/gomock"
	"github.com/google/gopacket"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestSenderWithEmptyChannel(t *testing.T) {
	t.Parallel()
	in := make(chan *BufferData)
	close(in)

	ctrl := gomock.NewController(t)
	w := NewMockWriter(ctrl)
	s := NewPacketSender(w)

	done, errc := s.SendPackets(context.Background(), in)

	result := chanToSlice(t, chanErrToGeneric(errc), 0)
	assert.Equal(t, 0, len(result), "error slice is not empty")

	result = chanToSlice(t, done, 0)
	assert.Equal(t, 0, len(result), "done slice is not empty")
}

func TestSenderWithOnePacket(t *testing.T) {
	t.Parallel()
	in := make(chan *BufferData, 1)
	data := []byte{0x1, 0x2, 0x3}
	buffer := gopacket.NewSerializeBuffer()
	err := gopacket.SerializeLayers(buffer, gopacket.SerializeOptions{}, gopacket.Payload(data))
	require.NoError(t, err)
	in <- &BufferData{Buf: buffer}
	close(in)

	expectedData := make([]byte, len(data))
	copy(expectedData, data)

	ctrl := gomock.NewController(t)
	w := NewMockWriter(ctrl)
	w.EXPECT().WritePacketData(expectedData).Do(func(pkt []byte) {
		fmt.Printf("Received pakcet data: %v\n", pkt)
	}).Return(nil)
	s := NewPacketSender(w)

	done, errc := s.SendPackets(context.Background(), in)

	result := chanToSlice(t, chanErrToGeneric(errc), 0)
	assert.Equal(t, 0, len(result), "error slice is not empty")

	// Done channel should be empty after sending all packets
	result = chanToSlice(t, done, 0)
	assert.Equal(t, 0, len(result), "done slice is not empty")
}

func TestSenderWithTwoPackets(t *testing.T) {
	t.Parallel()
	in := make(chan *BufferData, 2)

	data := []byte{0x1, 0x2, 0x3}
	buffer := gopacket.NewSerializeBuffer()
	err := gopacket.SerializeLayers(buffer, gopacket.SerializeOptions{}, gopacket.Payload(data))
	require.NoError(t, err)
	in <- &BufferData{Buf: buffer}

	data2 := []byte{0x2, 0x3, 0x4}
	buffer2 := gopacket.NewSerializeBuffer()
	err = gopacket.SerializeLayers(buffer2, gopacket.SerializeOptions{}, gopacket.Payload(data2))
	require.NoError(t, err)
	in <- &BufferData{Buf: buffer2}

	close(in)

	expectedData := make([]byte, len(data))
	copy(expectedData, data)
	expectedData2 := make([]byte, len(data))
	copy(expectedData2, data2)

	ctrl := gomock.NewController(t)
	w := NewMockWriter(ctrl)
	gomock.InOrder(
		w.EXPECT().WritePacketData(expectedData).Do(func(pkt []byte) {
			fmt.Printf("Received pakcet data: %v\n", pkt)
		}).Return(nil),
		w.EXPECT().WritePacketData(expectedData2).Do(func(pkt []byte) {
			fmt.Printf("Received pakcet data: %v\n", pkt)
		}).Return(nil),
	)
	s := NewPacketSender(w)

	done, errc := s.SendPackets(context.Background(), in)

	result := chanToSlice(t, chanErrToGeneric(errc), 0)
	assert.Equal(t, 0, len(result), "error slice is not empty")
	result = chanToSlice(t, done, 0)
	assert.Equal(t, 0, len(result), "done slice is not empty")
}

func TestSenderWithInvalidPacketsReturnsError(t *testing.T) {
	t.Parallel()
	in := make(chan *BufferData, 1)
	in <- &BufferData{Err: errors.New("invalid data")}
	close(in)

	ctrl := gomock.NewController(t)
	w := NewMockWriter(ctrl)
	s := NewPacketSender(w)

	done, errc := s.SendPackets(context.Background(), in)

	result := chanToSlice(t, chanErrToGeneric(errc), 1)
	assert.Equal(t, 1, len(result), "error slice size is invalid")
	assert.Error(t, result[0].(error))

	result = chanToSlice(t, done, 0)
	assert.Equal(t, 0, len(result), "done slice is not empty")
}

func TestSenderWithWriteErrorReturnsError(t *testing.T) {
	t.Parallel()
	in := make(chan *BufferData, 1)

	data := []byte{0x3, 0x4, 0x5}
	buffer := gopacket.NewSerializeBuffer()
	err := gopacket.SerializeLayers(buffer, gopacket.SerializeOptions{}, gopacket.Payload(data))
	require.NoError(t, err)
	in <- &BufferData{Buf: buffer}
	close(in)

	ctrl := gomock.NewController(t)
	w := NewMockWriter(ctrl)
	w.EXPECT().WritePacketData(data).Return(errors.New("there was write error"))
	s := NewPacketSender(w)

	done, errc := s.SendPackets(context.Background(), in)

	result := chanToSlice(t, chanErrToGeneric(errc), 1)
	assert.Equal(t, 1, len(result), "error slice size is invalid")
  fmt.Println(result)
	assert.Error(t, result[0].(error))

	result = chanToSlice(t, done, 0)
	assert.Equal(t, 0, len(result), "error slice is not empty")
}