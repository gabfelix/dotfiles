#!/bin/zsh

# Append ${HOME}/.local/bin and all subdirectories (follow symlinks for stow compatibility)
export PATH="${PATH}:$(find -L ${HOME}/.local/bin -type d | paste -sd ':' -)"

# Language package/runtime managers
# Ruby
[ ! -z "$(pacman -Q ruby)" ] && export PATH="${PATH}:${HOME}/.local/share/gem/ruby/3.0.0/bin"

# Node (requires AUR package)
nvm_location="/usr/share/nvm/init-nvm.sh"
[ -f "$nvm_location" ] && source "$nvm_location"

# Default programs
export TERMINAL="kitty"
export TERMINAL_PROG="$TERMINAL"
export BROWSER="librewolf"
export EDITOR="nvim"
export VISUAL="nvim"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_DATA_HOME/history"

# Don't forget to enable the ssh-agent service as a user:
# systemctl --user enable ssh-agent.service
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# Autostart WM on TTY1 (this should be last)
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec Hyprland
fi
