#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias "vim"="nvim"
alias "vi"="nvim"
alias "v"="$EDITOR"

alias "g"="git"
alias "ga"="git add -A"
alias "gac"="git add -A && git commit"
alias "gap"="git add -p"
alias "gco"="git commit"
alias "gst"="git status"

alias "p"="sudo pacman"

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv" 
alias mv="mv -iv" 
alias rm="rm -vI" 
alias bc="bc -ql" 
alias rsync="rsync -vrPlu" 
alias mkdir="mkdir -v" 
alias yt="yt-dlp --embed-metadata -i" 
alias ytv="yt -S res,ext:mp4:m4a --recode mp4" 
alias yta="yt -x -f bestaudio/best --audio-format mp3" 
alias ytt="yt --skip-download --write-thumbnail" 
alias ffmpeg="ffmpeg -hide_banner"
alias stow="stow -v"

alias ls="ls --color=auto --group-directories-first -h"
alias grep="grep --color=auto"
alias diff="diff --color=auto"

# Vi keys
set -o vi

PS1='[\u@\h \W]\$ '
