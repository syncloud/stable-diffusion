#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

export GRADIO_SERVER_NAME=/var/snap/stable-diffusion/common/web.socket
export PATH=$PATH:${DIR}/python/bin
/bin/rm -f $GRADIO_SERVER_NAME
exec ${DIR}/python/bin/python -u ${DIR}/python/webui/launch.py \
  --skip-prepare-environment \
  --data-dir '/var/snap/stable-diffusion/current' \
  --ckpt '$DIR/python/models/Stable-diffusion/v1-5-pruned-emaonly.safetensors'
  --ldap-uri 'ldap://localhost:389' \
  --ldap-bind-dn 'cn={username},ou=users,dc=syncloud,dc=org'
