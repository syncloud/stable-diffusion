#!/bin/sh -ex
apt update -y
apt install -y wget
wget https://github.com/cyberb/stable-diffusion-webui/archive/refs/heads/master.tar.gz --progress=dot:giga
tar xf master.tar.gz
mv stable-diffusion-webui-* webui
cd webui
python -c 'from modules import launch_utils; launch_utils.prepare_environment()'
#pip install -r /requirements.txt
rm -rf /var/lib/apt/lists/*
