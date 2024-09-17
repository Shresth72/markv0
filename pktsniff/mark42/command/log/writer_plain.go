package log

import (
	"fmt"
	"io"

	"github.com/Shresth72/mark42/pkg/scan"
)

type PlainResultWriter struct{}

func (*PlainResultWriter) Write(w io.Writer, result scan.Result) error {
	_, err := fmt.Fprintf(w, "%s\n", result.String())
	return err
}
