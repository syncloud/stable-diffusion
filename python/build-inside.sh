#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )

apt update -y
apt install -y wget git build-essential libgl1 libglib2.0-0
wget https://github.com/cyberb/stable-diffusion-webui/archive/refs/heads/master.tar.gz --progress=dot:giga
tar xf master.tar.gz
mv stable-diffusion-webui-* webui
cd $DIR/webui
export COMMANDLINE_ARGS="--skip-torch-cuda-test"
python -c 'from modules import launch_utils; launch_utils.prepare_environment()'
cd /usr/local/lib/python3*/site-packages
git apply --ignore-space-change --ignore-whitespace /patch/gradio.patch


mkdir -p $DIR/models/Stable-diffusion
wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors -O $DIR/models/Stable-diffusion/v1-5-pruned-emaonly.safetensors

cd $DIR/webui
cd repositories
git clone https://github.com/facebookresearch/xformers.git
cd xformers
git submodule update --init --recursive
pip install -r requirements.txt
pip install -e .

python -m pip cache purge
rm -rf /var/lib/apt/lists/*
