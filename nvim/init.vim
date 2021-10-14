"" PLUGINS
call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'

call plug#end()

"" GENERAL SETTINGS

set number relativenumber

" remap basic navigation (j - down, k - up, l - left, ; - right)
noremap l h
noremap ; l
noremap h ;

" 4-spaces indentation
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" on pressing tab, insert 4 spaces
set expandtab

" highlight trailing whitespaces
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
