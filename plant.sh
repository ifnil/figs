#!/usr/bin/env bash

shopt -s nullglob

function make_backup() {
  mv "$1" "$1.bak"
}

function delete_existing() {
  echo "would you like to delete the existing configuration?"
  gum confirm && rm -rf "$1" || (echo "okay then!" && exit 0)
}

valid_figs=()
exclude=("scripts" ".git" "zsh")
configurations=(*/)

# get the valid configs
for fig in "${configurations[@]}"; do
  fig="${fig%/}"
  if [[ ! " ${exclude[*]} " =~ ${fig} ]]; then
    valid_figs+=("$fig")
  fi
done

# choose wisely
choice=$(gum filter --height 10 ${valid_figs[*]})
echo "$choice"

# check if existing config is present
destination_path="$HOME/.config/$choice"
if [[ -d "$destination_path" ]]; then
  echo "configuration for $choice already exists!"
  echo "would you like to create a backup? (${choice}.bak)"
  gum confirm && make_backup "$destination_path" || delete_existing "$destination_path"
fi

# create the symlink
ln -s "$PWD/$choice" "$destination_path"
