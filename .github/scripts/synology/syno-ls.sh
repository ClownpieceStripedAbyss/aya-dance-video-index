#!/usr/bin/env bash

set -e -o pipefail
HOST="$1"
USER="$2"
LS_PATH="$3"
PASSWORD="${4:-$PASSWORD}"

if [[ -z "$HOST" || -z "$USER" || -z "$LS_PATH" || -z "$PASSWORD" ]]; then
  echo "Usage: $0 <host> <user> <path> [password or env \$PASSWORD]"
  exit 1
fi

SELF="$(dirname "$(readlink -f "$0")")"
source "$SELF/syno-common.sh"

### Login
syno-assert-login "$USER" "$PASSWORD"

### List
ESCAPED_PATH=$(echo "$LS_PATH" | sed 's/\//%2F/g')

syno-curl-with-cookie \
  "$HOST/webapi/entry.cgi?api=SYNO.FileStation.List&method=list&version=2&folder_path=%22$ESCAPED_PATH%22"
syno-assert-success "listing files"

syno-jq '.data.files[] | .name'

### Logout
syno-logout

# always return success
exit 0
