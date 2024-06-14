filetype on
filetype plugin on
filetype indent on
syntax on

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

highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
