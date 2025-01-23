# Hide greeting `help` message
set fish_greeting

fish_add_path ~/.local/bin

# prompt
if type -q starship
	starship init fish | source
end

if status --is-interactive
	fish_vi_key_bindings
end
