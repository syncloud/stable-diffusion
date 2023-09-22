#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

exec ${DIR}/python/bin/python -u ${DIR}/python/webui/launch.py \
  --skip-prepare-environment \
  --ldap-uri="ldap://localhost:389" \
  --ldap-bind-dn="cn={username},ou=users,dc=syncloud,dc=org"