#!/bin/zsh

# Append ${HOME}/.local/bin and all subdirectories (follow symlinks for stow compatibility)
export PATH="${PATH}:$(find -L ${HOME}/.local/bin -type d | paste -sd ':' -)"

# Default programs
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="librewolf"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export HISTFILE="${XDG_DATA_HOME}/history"

# Autostart hyprland on tty1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec Hyprland
fi
