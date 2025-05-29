" bootstrap vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
	  silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
	    autocmd VimEnter * silent! PlugInstall
endif

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

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()
command! PU PlugUpdate | PlugUpgrade
" Plugin configs
nnoremap <leader>G :Git<cr>
