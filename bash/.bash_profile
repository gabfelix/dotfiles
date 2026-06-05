#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=nvim
export BROWSER=brave-origin

# Add .local/bin to $PATH
[ -d "${HOME}/.local/bin" ] && export PATH="${PATH}:$(find -L ${HOME}/.local/bin -type d | paste -sd ':' -)"
