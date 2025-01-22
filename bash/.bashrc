# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Verbosity and settings that you pretty much just always are going to want.
alias ls='ls -h --group-directories-first --color=auto'
alias grep='grep --color=auto'
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

if [ -d "$HOME/.local/bin" ]; then
    PATH="${PATH}:${HOME}/.local/bin"
fi
