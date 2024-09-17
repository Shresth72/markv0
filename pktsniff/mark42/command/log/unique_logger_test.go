package log

import (
	"bytes"
	"context"
	"net"
	"strings"
	"testing"
	"time"

	"github.com/Shresth72/mark42/pkg/scan"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestUniqueLoggerResults(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name     string
		expected []byte
		results  []scan.Result
	}{
		{
			name:     "emptyResults",
			expected: nil,
			results:  nil,
		},
		{
			name:     "oneResult",
			expected: []byte(newScanResult(net.IPv4(192, 168, 0, 3).To4()).String() + "\n"),
			results: []scan.Result{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
			},
		},
		{
			name: "twoDifferentResults",
			expected: []byte(strings.Join([]string{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()).String(),
				newScanResult(net.IPv4(192, 168, 0, 5).To4()).String(),
			}, "\n") + "\n"),
			results: []scan.Result{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
				newScanResult(net.IPv4(192, 168, 0, 5).To4()),
			},
		},
		{
			name:     "twoEqualResults",
			expected: []byte(newScanResult(net.IPv4(192, 168, 0, 3).To4()).String() + "\n"),
			results: []scan.Result{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
			},
		},
		{
			name: "twoEqualResultsWithOneBetween",
			expected: []byte(strings.Join([]string{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()).String(),
				newScanResult(net.IPv4(192, 168, 0, 5).To4()).String(),
			}, "\n") + "\n"),
			results: []scan.Result{
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
				newScanResult(net.IPv4(192, 168, 0, 5).To4()),
				newScanResult(net.IPv4(192, 168, 0, 3).To4()),
			},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			var buf bytes.Buffer
			plainLogger, err := NewLogger(&buf, "arp")
			require.NoError(t, err)
			logger := NewUniqueLogger(plainLogger)

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

func TestUniqueLoggerContextExit(t *testing.T) {
	t.Parallel()

	done := make(chan interface{})
	go func() {
		defer close(done)

		ctx, cancel := context.WithCancel(context.Background())
		cancel()

		var buf bytes.Buffer
		logger, err := NewLogger(&buf, "arp", Plain())
		require.NoError(t, err)

		uniqLogger := NewUniqueLogger(logger)
		<-uniqLogger.uniqResults(ctx, nil)
	}()
	select {
	case <-done:
	case <-time.After(3 * time.Second):
		require.Fail(t, "test timeout")
	}
}
