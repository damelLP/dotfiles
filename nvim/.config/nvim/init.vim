set encoding=utf-8
set nocompatible
set nrformats+=alpha

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

function! ToggleCopyMode()
    " check if mouse is enabled
    if &mouse == 'a'
        set mouse= norelativenumber nonumber
    else
        set mouse=a relativenumber number
    endif
    execute "IndentLinesToggle"
endfunc

command! ToggleCopyMode call ToggleCopyMode()
map <leader>e :ToggleCopyMode<CR>

set wildmode=longest,list,full
set wildmenu
set completeopt+=longest
set nohlsearch

set splitbelow
set splitright

map <leader>bp :bp<CR>
map <leader>bn :bn<CR>
