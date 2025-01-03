syntax on
set number
set visualbell
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set mouse=a
set mousehide
set wildmenu
set foldmethod=syntax
set foldlevelstart=99
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set foldlevel=99
set filetype=on
set laststatus=2
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set cc=80
set completeopt-=preview
set cmdheight=2
set cursorline
"set hlsearch
set undofile
set undodir=~/.vimundo/
set t_Co=256
"set term=xterm
autocmd FileType cpp set keywordprg=cppman
set ignorecase
set autowrite
set viminfo='10,\"100,:20,%,n~/.viminfo
set splitright
set cino=N-s
set updatetime=250
set encoding=utf-8
set ttyfast
set lazyredraw

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'dracula/vim', { 'name': 'dracula' }

call vundle#end()
filetype plugin indent on

colorscheme dracula
set background=dark

