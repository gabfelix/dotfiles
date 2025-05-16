#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[1;36m\][\u@\h \W]\[\033[0m\]\[\033[1;97m\]\$\[\033[0m\] '

# Vi mode
set -o vi

# Shorten commands
alias p='sudo pacman'
alias gst='git status'
alias gac='git add -A && git commit'
alias gap="git add -p"
alias lg='lazygit'
# Alternative programs
alias youtube-dl='yt-dlp'
alias vim='nvim'
alias vi='nvim'
# Settings you're almost always going to want
alias ls='ls --color=auto --group-directories-first -h'
alias grep='grep --color=auto'
alias diff="diff --color=auto"
alias rm='rm -I'
alias yt="yt-dlp --embed-metadata -i" 
alias ytv="yt -S res,ext:mp4:m4a --recode mp4" 
alias yta="yt -x -f bestaudio/best --audio-format mp3" 
alias ytt="yt --skip-download --write-thumbnail" 
alias ffmpeg="ffmpeg -hide_banner"
