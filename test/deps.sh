#!/bin/bash -e
DIR=$( cd "$( dirname "$0" )" && pwd )

while ! apt-get update; do
  sleep 2
  echo "retry"
done
apt-get install -y sshpass openssh-client
pip install -r requirements.txt