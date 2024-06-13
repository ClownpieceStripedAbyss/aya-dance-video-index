#!/usr/bin/env bash

set -e

syno_ip=$REMOTE_IP
syno_user=$REMOTE_USER
syno_path=$REMOTE_PATH
syno_password=$REMOTE_PASSWORD

if [[ -z "$syno_ip" || -z "$syno_user" || -z "$syno_path" || -z "$syno_password" ]]; then
  echo "Missing required environment variables: REMOTE_IP, REMOTE_USER, REMOTE_PATH, REMOTE_PASSWORD"
  exit 1
fi

SELF="$(dirname "$(readlink -f "$0")")"

bash "$SELF/syno-ls.sh" "$syno_ip" "$syno_user" "$syno_path" "$syno_password"
