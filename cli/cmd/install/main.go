package main

import (
	"github.com/spf13/cobra"
	"go.uber.org/zap"
	"hooks/installer"
	"hooks/log"
	"os"
)

func main() {
	logger := log.Logger()
	var rootCmd = &cobra.Command{
		Use:          "install",
		SilenceUsage: true,
		RunE: func(cmd *cobra.Command, args []string) error {
			return installer.New(logger).Install()
		},
	}

	err := rootCmd.Execute()
	if err != nil {
		logger.Error("error", zap.Error(err))
		os.Exit(1)
	}
}
