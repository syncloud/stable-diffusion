#!/bin/bash -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )
export stable-diffusion_LDAP_ENABLED="true"
export stable-diffusion_LDAP_URI="ldap://localhost:389"
export stable-diffusion_LDAP_BIND_DN="cn={username},ou=users,dc=syncloud,dc=org"
export stable-diffusion_LDAP_ADMIN_GROUP_DN="cn=syncloud,ou=groups,dc=syncloud,dc=org"
export stable-diffusion_LDAP_ADMIN_GROUP_FILTER="(memberUid={username})"
export stable-diffusion_LDAP_ADMIN_GROUP_ATTRIBUTE="memberUid"

exec ${DIR}/python/bin/python -u ${DIR}/python/webui/launch.py \
  --skip-prepare-environment \
  --ldap-uri="ldap://localhost:389" \
  --ldap-bind-dn="cn={username},ou=users,dc=syncloud,dc=org"