package main

import "fmt"

var (
	version = "dev"
	commit  = ""
)

func main() {
	// command
}

func buildVersion(version, commit string) string {
	result := version
	if commit != "" {
		result = fmt.Sprintf("%s\n", result)
	}
	return result
}
