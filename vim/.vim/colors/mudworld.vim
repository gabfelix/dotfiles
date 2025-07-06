" Put this file in your .vim/colors and you can load it with
" :colorscheme mudworld

if !has('gui_running') " gui versions of Vim don't have 'termguicolors' setting
	set termguicolors " enable true color in terminals
endif

if exists("syntax on")
	syntax reset
endif

set background=dark

colorscheme koehler " base

highlight Normal guifg=#cdaa7d
highlight Comment guifg=#bac4cf
highlight Constant guifg=#cf7044
highlight Identifier guifg=#5b909a
highlight Function guifg=white gui=bold
highlight Special guifg=#a5c5d5
highlight Type guifg=#c78b3d
highlight Statement guifg=#f1c84b
highlight PreProc guifg=#9b6f8d
highlight Todo guibg=NONE guifg=white gui=bold " bg is set to NONE because Todo has a background color by default
highlight StatusLine guifg=#cdaa7d guibg=black 
highlight StatusLineNC guifg=#cdaa7d guibg=black 
highlight Visual guibg=blue guifg=yellow gui=bold
highlight Search guibg=blue guifg=red
highlight WildMenu guibg=White guifg=Black
highlight TabLine guibg=#cdaa7d guifg=black
