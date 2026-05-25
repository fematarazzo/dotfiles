" ~/.vimrc — fallback for when only vim is available
" I want to feel at home on any server

set nocompatible
filetype plugin indent on
syntax enable

" ── basics ─────────────────────────────────────────────
set number
set expandtab
set shiftwidth=4
set tabstop=4
set smartindent
set autoindent
set scrolloff=8
set sidescrolloff=8
set signcolumn=yes
set ignorecase
set smartcase
set incsearch
set hlsearch
set wildmenu
set wildmode=longest:full,full
set mouse=
set clipboard=unnamedplus
set backspace=indent,eol,start
set hidden
set noswapfile
set nobackup
set undofile
set undodir=~/.cache/vim/undo
silent! call mkdir(expand('~/.cache/vim/undo'), 'p')

" ── leader ─────────────────────────────────────────────
let mapleader = " "

" ── mappings ───────────────────────────────────────────
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader><leader> <C-^>

" center after search
nnoremap n nzzzv
nnoremap N Nzzzv

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

" ── colorscheme ────────────────────────────────────────
set background=dark
silent! colorscheme habamax
