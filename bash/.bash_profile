#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=nvim
export BROWSER=librewolf

# Add .local/bin to $PATH
export PATH="${PATH}:$(find -L ${HOME}/.local/bin -type d | paste -sd ':' -)"
