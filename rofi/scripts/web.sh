#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  exit
fi

urlencode() {
  echo "$1" | jq -Rr '@uri'
}

q=$(urlencode "$*")
url="https://search.brave.com/search?q=$q"

brave "$url"
