package main

import (
	"fmt"
	"github.com/spf13/cobra"
	"hooks/installer"
	"os"
)

func main() {
	var rootCmd = &cobra.Command{
		Use:          "install",
		SilenceUsage: true,
		RunE: func(cmd *cobra.Command, args []string) error {
			return installer.New().Install()
		},
	}

	err := rootCmd.Execute()
	if err != nil {
		fmt.Print(err)
		os.Exit(1)
	}
}
