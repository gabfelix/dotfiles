#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=nvim
export BROWSER=librewolf # Used by my hyprland config

# Add .local/bin to $PATH
export PATH="${PATH}:$(find -L ${HOME}/.local/bin -type d | paste -sd ':' -)"

# Exec hyprland (recommended way by devs)
if uwsm check may-start; then
	exec uwsm start hyprland.desktop
fi
