// Code generated by MockGen. DO NOT EDIT.
// Source: request_gen.go

// Package scan is a generated GoMock package.
package scan

import (
	context "context"
	net "net"
	reflect "reflect"

	gomock "github.com/golang/mock/gomock"
)

// MockPortGetter is a mock of PortGetter interface.
type MockPortGetter struct {
	ctrl     *gomock.Controller
	recorder *MockPortGetterMockRecorder
}

// MockPortGetterMockRecorder is the mock recorder for MockPortGetter.
type MockPortGetterMockRecorder struct {
	mock *MockPortGetter
}

// NewMockPortGetter creates a new mock instance.
func NewMockPortGetter(ctrl *gomock.Controller) *MockPortGetter {
	mock := &MockPortGetter{ctrl: ctrl}
	mock.recorder = &MockPortGetterMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockPortGetter) EXPECT() *MockPortGetterMockRecorder {
	return m.recorder
}

// GetPort mocks base method.
func (m *MockPortGetter) GetPort() (uint16, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "GetPort")
	ret0, _ := ret[0].(uint16)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// GetPort indicates an expected call of GetPort.
func (mr *MockPortGetterMockRecorder) GetPort() *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "GetPort", reflect.TypeOf((*MockPortGetter)(nil).GetPort))
}

// MockPortGenerator is a mock of PortGenerator interface.
type MockPortGenerator struct {
	ctrl     *gomock.Controller
	recorder *MockPortGeneratorMockRecorder
}

// MockPortGeneratorMockRecorder is the mock recorder for MockPortGenerator.
type MockPortGeneratorMockRecorder struct {
	mock *MockPortGenerator
}

// NewMockPortGenerator creates a new mock instance.
func NewMockPortGenerator(ctrl *gomock.Controller) *MockPortGenerator {
	mock := &MockPortGenerator{ctrl: ctrl}
	mock.recorder = &MockPortGeneratorMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockPortGenerator) EXPECT() *MockPortGeneratorMockRecorder {
	return m.recorder
}

// Ports mocks base method.
func (m *MockPortGenerator) Ports(ctx context.Context, r *Range) (<-chan PortGetter, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "Ports", ctx, r)
	ret0, _ := ret[0].(<-chan PortGetter)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// Ports indicates an expected call of Ports.
func (mr *MockPortGeneratorMockRecorder) Ports(ctx, r interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "Ports", reflect.TypeOf((*MockPortGenerator)(nil).Ports), ctx, r)
}

// MockIPGetter is a mock of IPGetter interface.
type MockIPGetter struct {
	ctrl     *gomock.Controller
	recorder *MockIPGetterMockRecorder
}

// MockIPGetterMockRecorder is the mock recorder for MockIPGetter.
type MockIPGetterMockRecorder struct {
	mock *MockIPGetter
}

// NewMockIPGetter creates a new mock instance.
func NewMockIPGetter(ctrl *gomock.Controller) *MockIPGetter {
	mock := &MockIPGetter{ctrl: ctrl}
	mock.recorder = &MockIPGetterMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockIPGetter) EXPECT() *MockIPGetterMockRecorder {
	return m.recorder
}

// GetIP mocks base method.
func (m *MockIPGetter) GetIP() (net.IP, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "GetIP")
	ret0, _ := ret[0].(net.IP)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// GetIP indicates an expected call of GetIP.
func (mr *MockIPGetterMockRecorder) GetIP() *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "GetIP", reflect.TypeOf((*MockIPGetter)(nil).GetIP))
}

// MockIPGenerator is a mock of IPGenerator interface.
type MockIPGenerator struct {
	ctrl     *gomock.Controller
	recorder *MockIPGeneratorMockRecorder
}

// MockIPGeneratorMockRecorder is the mock recorder for MockIPGenerator.
type MockIPGeneratorMockRecorder struct {
	mock *MockIPGenerator
}

// NewMockIPGenerator creates a new mock instance.
func NewMockIPGenerator(ctrl *gomock.Controller) *MockIPGenerator {
	mock := &MockIPGenerator{ctrl: ctrl}
	mock.recorder = &MockIPGeneratorMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockIPGenerator) EXPECT() *MockIPGeneratorMockRecorder {
	return m.recorder
}

// IPs mocks base method.
func (m *MockIPGenerator) IPs(ctx context.Context, r *Range) (<-chan IPGetter, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "IPs", ctx, r)
	ret0, _ := ret[0].(<-chan IPGetter)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// IPs indicates an expected call of IPs.
func (mr *MockIPGeneratorMockRecorder) IPs(ctx, r interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "IPs", reflect.TypeOf((*MockIPGenerator)(nil).IPs), ctx, r)
}

// MockRequestGenerator is a mock of RequestGenerator interface.
type MockRequestGenerator struct {
	ctrl     *gomock.Controller
	recorder *MockRequestGeneratorMockRecorder
}

// MockRequestGeneratorMockRecorder is the mock recorder for MockRequestGenerator.
type MockRequestGeneratorMockRecorder struct {
	mock *MockRequestGenerator
}

// NewMockRequestGenerator creates a new mock instance.
func NewMockRequestGenerator(ctrl *gomock.Controller) *MockRequestGenerator {
	mock := &MockRequestGenerator{ctrl: ctrl}
	mock.recorder = &MockRequestGeneratorMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockRequestGenerator) EXPECT() *MockRequestGeneratorMockRecorder {
	return m.recorder
}

// GenerateRequests mocks base method.
func (m *MockRequestGenerator) GenerateRequests(ctx context.Context, r *Range) (<-chan *Request, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "GenerateRequests", ctx, r)
	ret0, _ := ret[0].(<-chan *Request)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// GenerateRequests indicates an expected call of GenerateRequests.
func (mr *MockRequestGeneratorMockRecorder) GenerateRequests(ctx, r interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "GenerateRequests", reflect.TypeOf((*MockRequestGenerator)(nil).GenerateRequests), ctx, r)
}

// MockIPContainer is a mock of IPContainer interface.
type MockIPContainer struct {
	ctrl     *gomock.Controller
	recorder *MockIPContainerMockRecorder
}

// MockIPContainerMockRecorder is the mock recorder for MockIPContainer.
type MockIPContainerMockRecorder struct {
	mock *MockIPContainer
}

// NewMockIPContainer creates a new mock instance.
func NewMockIPContainer(ctrl *gomock.Controller) *MockIPContainer {
	mock := &MockIPContainer{ctrl: ctrl}
	mock.recorder = &MockIPContainerMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockIPContainer) EXPECT() *MockIPContainerMockRecorder {
	return m.recorder
}

// Contains mocks base method.
func (m *MockIPContainer) Contains(ip net.IP) (bool, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "Contains", ip)
	ret0, _ := ret[0].(bool)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// Contains indicates an expected call of Contains.
func (mr *MockIPContainerMockRecorder) Contains(ip interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "Contains", reflect.TypeOf((*MockIPContainer)(nil).Contains), ip)
}