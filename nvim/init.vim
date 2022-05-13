"" PLUGINS
call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'yegappan/mru'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'cocopon/iceberg.vim'

call plug#end()

"" GENERAL SETTINGS

" set colorscheme
colorscheme iceberg

set number relativenumber

" airline show arrows in line
" let g:airline_powerline_fonts = 1

" remap basic navigation to match home row (j - down, k - up, l - left, ; - right)
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

" disable recording key
map q <Nop>

" enable mouse support
set mouse=a

" highlight matching bracket less brighter
highlight MatchParen cterm=bold ctermbg=none ctermfg=white

" jump to specific file
nnoremap <C-P> :Files<cr>
" search whole project
nnoremap \ :Rg<space>

" search for selection with //
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" open NERDTree with <F5>
map <F5> :NERDTreeToggle<CR>
