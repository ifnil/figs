#!/usr/bin/env bash

export GUM_INPUT_CURSOR_FOREGROUND="#f4ac45"
export GUM_INPUT_PROMPT_FOREGROUND="#04b675"
export GUM_INPUT_WIDTH=80

EXCLUDE=(".git" "scripts")
FIGS=()

for dir in */; do
  dir="${dir%/}"
  if [[ ! " ${EXCLUDE[*]} " =~ ${dir} ]]; then
    FIGS+=("$dir")
  fi
done

FIG=$(gum choose --height 10 --limit 10 ${FIGS[*]})
echo "${FIG}"

# FIG=$(gum filter ${FIGS[*]})
# echo "${FIG}"
