#!/usr/bin/env bash

SESSION_NAME="AyaIndexer$$"
COOKIE_FILE="/tmp/syno_cookies_$SESSION_NAME"
SYNO_RESPONSE=""

################### curl with states

function syno-assert-success() {
  if ! syno-check-success; then
    echo "Error code: $(syno-jq -r '.error.code'), during $1"
    exit 1
  fi
  return 0
}

function syno-check-success() {
  if syno-jq -e '.error' > /dev/null; then
    return 1
  fi
  return 0
}

function syno-jq() {
  echo "$SYNO_RESPONSE" | jq "$@"
}

function syno-curl-set-cookie() {
  SYNO_RESPONSE="$(curl -s -L -c "$COOKIE_FILE" "$@")"
}

function syno-curl-with-cookie() {
  SYNO_RESPONSE="$(curl -s -L -b "$COOKIE_FILE" "$@")"
}

################### Synology API

function syno-assert-login() {
  local user="$1"
  local password="$2"
  syno-curl-set-cookie \
    "$HOST/webapi/auth.cgi?api=SYNO.API.Auth&method=login&version=3&account=$user&passwd=$password&session=$SYNO_SESSION_NAME&format=cookie"
  syno-assert-success "syno-login"
}

function syno-logout() {
  syno-curl-with-cookie \
    "$HOST/webapi/auth.cgi?api=SYNO.API.Auth&method=logout&version=3&session=$SYNO_SESSION_NAME"
  syno-check-success
}
