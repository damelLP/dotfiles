call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'Chiel92/vim-autoformat'
    Plug 'kshenoy/vim-signature'
    Plug 'Yggdroot/indentLine'
    Plug 'joshdick/onedark.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Shortcut for NERDTree
nnoremap <F1> :NERDTreeToggle<CR>

" Add config for coc
source ~/.config/nvim/coc_conf.vim

" set colorscheme
colorscheme onedark

nnoremap <C-L> :Format<CR>
vnoremap <C-L> :Format<CR>
inoremap <C-L> <ESC>:Format<CR>
