package installer

import (
	"errors"
	cp "github.com/otiai10/copy"
	"go.uber.org/zap"
	"hooks/platform"
	"os"
	"path"
)

const (
	App       = "stable-diffusion"
	AppDir    = "/snap/stable-diffusion/current"
	DataDir   = "/var/snap/stable-diffusion/current"
	CommonDir = "/var/snap/stable-diffusion/common"
	ModelName = "v1-5-pruned-emaonly.safetensors"
)

type Installer struct {
	newVersionFile     string
	currentVersionFile string
	configDir          string
	database           Database
	logger             *zap.Logger
}

func New(logger *zap.Logger) *Installer {
	configDir := path.Join(DataDir, "config")
	return &Installer{
		newVersionFile:     path.Join(AppDir, "version"),
		currentVersionFile: path.Join(DataDir, "version"),
		configDir:          configDir,
		logger:             logger,
	}
}

func (i *Installer) Install() error {
	err := CreateUser(App)
	if err != nil {
		return err
	}

	err = i.UpdateConfigs()
	if err != nil {
		return err
	}

	err = i.FixPermissions()
	if err != nil {
		return err
	}

	err = i.StorageChange()
	if err != nil {
		return err
	}
	return nil
}

func (i *Installer) Configure() error {
	err := cp.Copy(path.Join(AppDir, ModelName), path.Join(DataDir, ModelName))
	if err != nil {
		return err
	}
	return i.UpdateVersion()
}

func (i *Installer) PreRefresh() error {
	return nil
}

func (i *Installer) PostRefresh() error {
	err := i.UpdateConfigs()
	if err != nil {
		return err
	}

	err = i.ClearVersion()
	if err != nil {
		return err
	}

	err = i.FixPermissions()
	if err != nil {
		return err
	}
	return nil

}
func (i *Installer) StorageChange() error {
	storageDir, err := platform.New().InitStorage(App, App)
	if err != nil {
		return err
	}
	outputDir := path.Join(storageDir, "output")
	if _, err = os.Stat(outputDir); errors.Is(err, os.ErrNotExist) {
		i.logger.Info("creating", zap.String("outputDir", outputDir))
		err = os.Mkdir(outputDir, 0755)
		if err != nil {
			return err
		}
	}
	err = Chown(storageDir, App)
	if err != nil {
		return err
	}
	return nil
}

func (i *Installer) ClearVersion() error {
	return os.RemoveAll(i.currentVersionFile)
}

func (i *Installer) UpdateVersion() error {
	return cp.Copy(i.newVersionFile, i.currentVersionFile)
}

func (i *Installer) UpdateConfigs() error {
	return cp.Copy(path.Join(AppDir, "config"), path.Join(DataDir, "config"))
}

func (i *Installer) FixPermissions() error {
	err := Chown(DataDir, App)
	if err != nil {
		return err
	}
	err = Chown(CommonDir, App)
	if err != nil {
		return err
	}
	return nil
}
