package packet

import (
	"context"
	"reflect"

	"github.com/golang/mock/gomock"
)

type MockSender struct {
	ctrl     *gomock.Controller
	recorder *MockSenderMockRecorder
}

type MockSenderMockRecorder struct {
	mock *MockSender
}

func NewMockSender(ctrl *gomock.Controller) *MockSender {
	mock := &MockSender{ctrl: ctrl}
	mock.recorder = &MockSenderMockRecorder{mock}
	return mock
}

func (m *MockSender) EXPECT() *MockSenderMockRecorder {
	return m.recorder
}

// Base Method Mock
func (m *MockSender) SendPackets(ctx context.Context, in <-chan *BufferData) (<-chan interface{}, <-chan error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "SendPackets", ctx, in)

	ret0, _ := ret[0].(<-chan interface{})
	ret1, _ := ret[1].(<-chan error)
	return ret0, ret1
}

func (mr *MockSenderMockRecorder) SendPackets(ctx, in interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "SendPackets", reflect.TypeOf((*MockSender)(nil).SendPackets), ctx, in)
}

type MockWriter struct {
	ctrl     *gomock.Controller
	recorder *MockWriterMockRecorder
}

type MockWriterMockRecorder struct {
	mock *MockWriter
}

func NewMockWriter(ctrl *gomock.Controller) *MockWriter {
	mock := &MockWriter{ctrl: ctrl}
	mock.recorder = &MockWriterMockRecorder{mock}
	return mock
}

func (m *MockWriter) EXPECT() *MockWriterMockRecorder {
	return m.recorder
}

// Base Method Mock
func (m *MockWriter) WritePacketData(pkt []byte) error {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "WritePacketData", pkt)
	ret0, _ := ret[0].(error)
	return ret0
}

func (mr *MockWriterMockRecorder) WritePacketData(pkt interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "WritePacketData", reflect.TypeOf((*MockWriter)(nil).WritePacketData), pkt)
}
