execute pathogen#infect()  
set nocompatible

" File ~/.vim/ftplugin/python.vim
" filetype plugin on
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()

set clipboard=unnamedplus

" let Vundle manage Vundle
" Plugin 'Vundlevim/Vundle.vim'

" enable syntax highlighting
syntax enable

" set the color scheme
colorscheme archery

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" enable the unicode fonts
set guifont=Font\ Awesome\ 14

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line 
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" set background
set background=dark

" enable mouse control
set mouse=a

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" enable the status bar
set laststatus=2

" set how vim should split the screen
set splitbelow
set splitright

" navigate across split screens
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

