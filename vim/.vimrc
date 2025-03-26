" My vim (not neovim) config is meant to be simple and hyper focused around editing text
" No fancy LSPs or tooling such as debuggers, linters or spellcheckers to get in the way
" No debugger integration
" Use as little plugins as possible
" File trees are icky and don't belong in vim
" For any of that stuff, I use neovim or vsc*de

filetype on
filetype plugin on
filetype indent on
syntax on

" Map leaders before anything else
let mapleader = ' '
let localmapleader = ' '

set nocompatible
set noesckeys " Fix small delay when pressing Esc-Shift-o quickly
set shiftwidth=8
set tabstop=8
set incsearch
set hlsearch
set ignorecase
set smartcase
set splitright
set splitbelow
set scrolloff=8
set breakindent " visually indent wrapped lines
set wildmenu
set wildmode=longest,full
set number
set relativenumber

" highlight any trailing whitespace with red
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
" delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

function! IsWindows()
	" Check for WINDIR environment variable
	let l:is_windows = system('echo %WINDIR%') != ''
	return l:is_windows
endfunction

if IsWindows()
	" force block cursor
	let &t_ti.="\e[1 q"
	let &t_SI.="\e[5 q"
	let &t_EI.="\e[1 q"
	let &t_te.="\e[0 q"
endif

" Plugins
if filereadable($HOME . '/.vim/autoload/plug.vim')
	call plug#begin()
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-surround'
	Plug 'ericbn/vim-solarized'
	Plug 'vimwiki/vimwiki'
	call plug#end()
	" Plugin configs
	" fugitive
	nnoremap <leader>G :Git<cr>
	" Shortcut for updating plugins and vim-plug
	command! PU PlugUpdate | PlugUpgrade
	set background=dark
	colorscheme solarized
endif

