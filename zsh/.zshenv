#!/bin/zsh

# Append ${HOME}/.local/bin and all subdirectories (follow symlinks for stow compatibility)
export PATH="${PATH}:$(find -L ${HOME}/.local/bin -type d | paste -sd ':' -)"

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export HISTFILE="${XDG_DATA_HOME}/history"
