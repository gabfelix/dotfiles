let mapleader=' '
let localmapleader=' '

set mouse=a
set hlsearch
set incsearch
set ignorecase
set smartcase
set splitright
set splitbelow

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary' " gcc to comment lines
Plug 'tpope/vim-vinegar'
" vim-surround reference:
" ds': delete surrounding '
" cs"': change surrounding " to '
" ysiw): add () to surround the word under the cursor
Plug 'tpope/vim-surround' " new motions for messing with surrounding characters
Plug 'romainl/vim-cool' " disables highlight after you finish searching (make sure 'hlsearch' is set)
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'markonm/traces.vim'
call plug#end()

" tab navigation
nnoremap <leader>tt :tabnew<cr>
nnoremap <leader>tx :tabclose<cr>
nnoremap ]t :tabnext<cr>
nnoremap [t :tabprevious<cr>

colorscheme mudworld
