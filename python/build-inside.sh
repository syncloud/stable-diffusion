#!/bin/sh -ex
apt update -y
apt install -y wget git
wget https://github.com/cyberb/stable-diffusion-webui/archive/refs/heads/master.tar.gz --progress=dot:giga
tar xf master.tar.gz
mv stable-diffusion-webui-* webui
cd webui
export COMMANDLINE_ARGS="--skip-torch-cuda-test"
python -c 'from modules import launch_utils; launch_utils.prepare_environment()'
cd /usr/local/lib/python3.8/site-packages
git apply --ignore-space-change --ignore-whitespace /patch/gradio.patch
#pip install -r /requirements.txt
python -m pip cache purge
rm -rf /var/lib/apt/lists/*
