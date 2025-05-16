#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=nvim
export BROWSER=librewolf # Used by my hyprland config

# Select session
if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi
