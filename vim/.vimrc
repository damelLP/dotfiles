set encoding=utf-8
set nocompatible

call plug#begin('~/.vim/plugged')
" Thirdparty libs
Plug 'alfredodeza/coveragepy.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Chiel92/vim-autoformat'
call plug#end()

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

set mouse=a
set tabstop=4
set expandtab
set autoindent
set shiftwidth=4  "this is the level of autoindent, adjust to taste
set ruler
set number
set backspace=indent,eol,start
set visualbell
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusGained,InsertEnter * set norelativenumber
augroup END

" Uncomment below to make screen not flash on error
set vb t_vb=""
set showmatch
set laststatus=2

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set cursorline

set background=dark
colorscheme solarized


nnoremap <F1> :NERDTreeToggle<CR>

" ctags in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" showfunc
let g:showfuncctagsbin = "/opt/swt/bin/ctags"
map <F2> <Plug>ShowFunc
map! <F2> <Plug>ShowFunc

nnoremap <C-L> :Autoformat<CR>
inoremap <C-L> <ESC>:Autoformat<CR>
vnoremap <C-L> :Autoformat<CR>

set splitbelow
set splitright


"-------- Haskell ---------"

" add ghc-mod 
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" enable haskell completion with necoghc
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let g:ycm_semantic_triggers = {'haskell': ['.']}

" configure nerdtree
map <Leader>n :NERDTreeToggle<CR>

" tabularize
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

