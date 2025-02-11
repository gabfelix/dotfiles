# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export EDITOR="nvim"

if [ -d "$HOME/.local/bin" ]; then
    PATH="${PATH}:${HOME}/.local/bin"
fi
