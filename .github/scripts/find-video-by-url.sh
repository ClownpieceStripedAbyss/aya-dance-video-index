#!/usr/bin/env bash

set -e

URL="$1"

ssh_ip=$REMOTE_IP
ssh_user=$REMOTE_USER
ssh_path=$REMOTE_PATH

if [[ -z "$ssh_ip" || -z "$ssh_user" || -z "$ssh_path" ]]; then
  echo "Missing required environment variables: REMOTE_IP, REMOTE_USER, REMOTE_PATH"
  exit 1
fi

if [[ -z "$URL" ]]; then
  echo "Usage: $0 <url>"
  exit 1
fi

KW=""
if [[ "$URL" == *youtube.com* ]]; then
  KW="${URL##*v=}"
fi

if [[ -z "$KW" ]]; then
  echo "URL not recognized: $URL"
  exit 1
fi

result=$(
  ssh \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -o LogLevel=ERROR \
    "$ssh_user@$ssh_ip" \
    "find ""$ssh_path"" -name metadata.json -exec grep -B20 -A20 ""$KW"" {} \;"
)

if [[ -z "$result" ]]; then
  echo "Video not found: $URL"
  exit 1
fi

echo "$result"
exit 0
