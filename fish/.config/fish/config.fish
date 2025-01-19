# Hide greeting `help` message
set fish_greeting

fish_add_path ~/.local/bin

if status --is-interactive
	fish_vi_key_bindings
end
