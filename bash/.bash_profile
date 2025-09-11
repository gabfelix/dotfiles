#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=nvim
export BROWSER=librewolf

# Add .local/bin to $PATH
export PATH="${PATH}:$(find -L ${HOME}/.local/bin -type d | paste -sd ':' -)"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/gabriel/.opam/opam-init/init.sh' && . '/home/gabriel/.opam/opam-init/init.sh' > /dev/null 2> /dev/null || true
# END opam configuration
