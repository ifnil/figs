#!/usr/bin/env bash

# $1 ? light/dark : !current

NVIM_THEME_FILE="${FIGS/#~\//$HOME\/}/nvim/lua/config/theme.lua"
NVIM_LUALINE_FILE="${FIGS/#~\//$HOME\/}/nvim/lua/plugins/ui/lualine.lua"

THEME="${1:-dark}"
CURRENT_THEME=$(grep -Po '(?<=")[^"]+(?=")' "${NVIM_THEME_FILE}")
SED=""

function update_nvim() {
  sed -i "s/${CURRENT_THEME}/${THEME}/g" "${NVIM_THEME_FILE}"
  sed -i "s/${CURRENT_THEME}/${THEME}/g" "${NVIM_LUALINE_FILE}"
}

if [[ -z "${FIGS}" ]]; then
  echo "\$FIGS variable not set!"
  exit 1
fi

if ! command -v sed >/dev/null 2>&1; then
  echo "sed is not installed!"
  exit 1
fi

if [[ -z "$1" ]]; then
  if [[ "${CURRENT_THEME}" == "dark" ]]; then
    THEME="light"
  else
    THEME="dark"
  fi
fi

if [[ "${CURRENT_THEME}" == "${THEME}" ]]; then
  echo "theme is already ${THEME}"
  exit 0
fi

echo "changing nvim theme to ${THEME}"
update_nvim
