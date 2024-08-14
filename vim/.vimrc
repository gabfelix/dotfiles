" My vim config is meant to be simple and hyper focused on text editing
" No fancy LSPs or tooling to get in the way such as linting or spell-checking
" No debugger integration
" Use as little plugins as possible
" File trees are icky and don't belong in vim
" For any of that stuff, I use neovim or vsc*de

filetype on
filetype plugin on
filetype indent on
syntax on

let mapleader = ' '
let localmapleader = ' '

set notermguicolors
colorscheme peachpuff

set nocompatible
set shiftwidth=4
set tabstop=4
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
" delete trailing whitespace on save
"match TrailingWhitespace /\s\+$/

" Plugins
call plug#begin()
Plug 'tpope/vim-fugitive'
call plug#end()

" Plugin-specific configuration
" fugitive
nnoremap <leader>G :Git<cr>
