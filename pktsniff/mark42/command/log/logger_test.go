package log

import (
	"bytes"
	"context"
	"net"
	"strings"
	"testing"
	"time"

	"github.com/Shresth72/mark42/pkg/scan"
	"github.com/Shresth72/mark42/pkg/scan/arp"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func scanResultToJSON(t *testing.T, result scan.Result) string {
	t.Helper()
	data, err := result.MarshalJSON()
	require.NoError(t, err)
	return string(data)
}

func TestJSONLoggerResults(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name     string
		expected []byte
		results  []*arp.ScanResult
	}{
		{
			name:     "emptyResults",
			expected: nil,
			results:  nil,
		},
		{
			name: "oneResult",
			expected: []byte(
				scanResultToJSON(t, newScanResult(net.IPv4(192, 168, 0, 3).To4())) + "\n",
			),
			results: []*arp.ScanResult{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
			},
		},
		{
			name: "twoResults",
			expected: []byte(strings.Join([]string{
				scanResultToJSON(t, newScanResult(net.IPv4(192, 168, 0, 3).To4())),
				scanResultToJSON(t, newScanResult(net.IPv4(192, 168, 0, 5).To4())),
			}, "\n") + "\n"),
			results: []*arp.ScanResult{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
				newScanResult(net.IPv4(192, 168, 0, 5).To4()),
			},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			var buf bytes.Buffer
			logger, err := NewLogger(&buf, "arp", JSON())
			require.NoError(t, err)

			resultCh := make(chan scan.Result, len(tt.results))
			for _, result := range tt.results {
				resultCh <- result
			}
			close(resultCh)
			logger.LogResults(context.Background(), resultCh)

			assert.Equal(t, string(tt.expected), buf.String())
		})
	}
}

func newScanResult(ip net.IP) *arp.ScanResult {
	return &arp.ScanResult{
		IP:     ip.String(),
		MAC:    net.HardwareAddr{0x11, 0x22, 0x33, 0x44, 0x55, 0x66}.String(),
		Vendor: "Sunny Industries",
	}
}

func TestPlainLoggerResults(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name     string
		expected []byte
		results  []*arp.ScanResult
	}{
		{
			name:     "emptyResults",
			expected: nil,
			results:  nil,
		},
		{
			name:     "oneResult",
			expected: []byte(newScanResult(net.IPv4(192, 168, 0, 3).To4()).String() + "\n"),
			results: []*arp.ScanResult{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
			},
		},
		{
			name: "twoResults",
			expected: []byte(strings.Join([]string{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()).String(),
				newScanResult(net.IPv4(192, 168, 0, 5).To4()).String(),
			}, "\n") + "\n"),
			results: []*arp.ScanResult{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
				newScanResult(net.IPv4(192, 168, 0, 5).To4()),
			},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			var buf bytes.Buffer
			logger, err := NewLogger(&buf, "arp", Plain())
			require.NoError(t, err)

			resultCh := make(chan scan.Result, len(tt.results))
			for _, result := range tt.results {
				resultCh <- result
			}
			close(resultCh)
			logger.LogResults(context.Background(), resultCh)

			assert.Equal(t, string(tt.expected), buf.String())
		})
	}
}

func TestLoggerContextExit(t *testing.T) {
	t.Parallel()

	done := make(chan interface{})
	go func() {
		defer close(done)

		ctx, cancel := context.WithCancel(context.Background())
		cancel()

		var buf bytes.Buffer
		logger, err := NewLogger(&buf, "arp", Plain())
		require.NoError(t, err)

		logger.LogResults(ctx, nil)
	}()
	select {
	case <-done:
	case <-time.After(3 * time.Second):
		require.Fail(t, "test timeout")
	}
}
