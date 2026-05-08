#!/usr/bin/env bash

if [[ -z "$SSH_CLIENT" ]]; then
  echo "#b3e0c5"
else
  echo "#FFD7AA"
fi
