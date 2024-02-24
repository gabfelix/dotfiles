#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="${HOME}/.local/bin:${PATH}"

export TERMINAL="foot"
export BROWSER="librewolf"
export EDITOR="nvim"
export VISUAL="nvim"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

# Don't forget to enable the ssh-agent service as a user!
# systemctl --user enable ssh-agent.service
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec sway
fi
