package main

import (
	"fmt"

	"github.com/Shresth72/mark42/command"
)

// will be injected during release
var (
	version = "dev"
	commit  = ""
)

func main() {
	command.Main(buildVersion(version, commit))
}

func buildVersion(version, commit string) string {
	result := version
	if commit != "" {
		result = fmt.Sprintf("%s\ncommit: %s", result, commit)
	}
	return result
}
