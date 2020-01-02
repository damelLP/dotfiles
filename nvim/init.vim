set encoding=utf-8
set nocompatible

source ~/.config/nvim/plugins.vim

set mouse=a
set tabstop=4
set expandtab
set autoindent
set shiftwidth=4
set ruler
set backspace=indent,eol,start
set number
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusGained,InsertEnter * set norelativenumber
augroup end

set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set splitbelow
set splitright
