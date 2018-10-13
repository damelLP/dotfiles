" enable syntax highlighting
execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible
set clipboard=unnamedplus,autoselect

" set the color scheme
colorscheme alduin

" show line numbers
set showmode
set nowrap

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup end

" make tabs smarter
set smarttab

" expand tabs into spaces
set expandtab

set smartcase
set softtabstop=2

" indent when moving to the next line while writing code
set autoindent
set smartindent

" enable the unicode fonts
set guifont=Font\ Awesome\ 14

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=2

" show a visual line under the cursor's current line 
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" use incremental searches
set incsearch

set history=1000

set t_Co=256

" enable mouse control
set mouse=a

" enable the status bar
set laststatus=2

" navigate across split screens
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

" configure syntastic
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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

