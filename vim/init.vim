"-------------------------------------------------------------------------------
" Plugin manager
"-------------------------------------------------------------------------------

let s:data_dir = stdpath('data') . '/site'
let s:plugin_dir = s:data_dir . '/plugged'
let s:plug_file = s:data_dir . '/autoload/plug.vim'

if empty(glob(s:plug_file))
  silent execute '!curl -fLo ' . s:plug_file . ' --create-dirs -k ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * ++once PlugInstall --sync
                 \ | source $MYVIMRC
endif

call plug#begin(s:plugin_dir)

" Vim help for plugin manager
Plug 'junegunn/vim-plug'

" Highlight trailing whitespace characters
Plug 'ntpeters/vim-better-whitespace'

" Status and tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Indicate added, modified and removed lines in the sign column
Plug 'mhinz/vim-signify'

call plug#end()

"-------------------------------------------------------------------------------
" Text formatting
"-------------------------------------------------------------------------------

set encoding=utf-8

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set shiftround

set autoindent
set nosmartindent
set cindent
set cinoptions=:0,l1,g0

"-------------------------------------------------------------------------------
" UI settings
"-------------------------------------------------------------------------------

set background=dark

colorscheme default

set nocursorline
set nofoldenable
set noshowmode
set noruler
set number
set numberwidth=5
set signcolumn=yes
set colorcolumn=
set showcmd
set modeline
set cmdheight=2
set showtabline=2
set laststatus=2

let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1

highlight LineNr ctermfg=darkgray guifg=darkgray
highlight SignColumn ctermbg=NONE guibg=NONE
highlight ColorColumn ctermbg=darkgray guibg=darkgray

highlight SignifySignAdd ctermfg=green guifg=#00ff00 cterm=NONE gui=NONE
highlight SignifySignDelete ctermfg=red guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE

"-------------------------------------------------------------------------------
" Visual cues
"-------------------------------------------------------------------------------

set hlsearch
set incsearch
set ignorecase
set smartcase

set listchars=tab:▸\ ,precedes:←,extends:→
set list
set wrap
set linebreak
set showbreak=↪
set breakindent
set showmatch
set matchtime=3
set scrolloff=3

let g:better_whitespace_ctermcolor = 'green'
let g:better_whitespace_guicolor='green'
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 0

"-------------------------------------------------------------------------------
" Behavioural settings
"-------------------------------------------------------------------------------

set autoread
set hidden
set ttimeoutlen=0
set updatetime=100
set backspace=indent,eol,start
set nostartofline
set completeopt=menuone,longest
set shortmess+=c
set wildignore+=*.o
set path=$PWD/**

set lazyredraw

set undofile
set swapfile
set nobackup
set nowritebackup
set spelllang=en
set nospell

"-------------------------------------------------------------------------------
" Clang format
"-------------------------------------------------------------------------------

function! ClangFormatOnWrite()
  let l:formatdiff = 1
  py3file ~/clang-format.py
endfunction

"-------------------------------------------------------------------------------
" Key mappings
"-------------------------------------------------------------------------------

nnoremap <F5> :set spell!<CR>
nnoremap <F6> :set list!<CR>
nnoremap <F7> :ToggleWhitespace<CR>
nnoremap <F8> :nohlsearch<CR>

set pastetoggle=<F9>

inoremap jk <ESC>

nnoremap j gj
nnoremap k gk

vnoremap < <gv
vnoremap > >gv

" Map Y to copy to the end of the line
map Y y$

" Remap Q to do nothing instead of entering Ex mode
nnoremap Q <nop>

nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-l> :bnext<CR>

nnoremap <silent> <C-t> :tab split<CR>

"-------------------------------------------------------------------------------
" Auto commands
"-------------------------------------------------------------------------------

augroup vimrc_autocmd
  autocmd!

  " tpp files are actually cpp files
  au BufRead,BufNewFile *.tpp setlocal filetype=cpp

  " Modify default number of spaces that a <Tab> counts for
  au FileType cmake setlocal softtabstop=2
  au FileType cmake setlocal shiftwidth=2

  " Always start editing a file in case a swap file exists
  au SwapExists * let v:swapchoice = 'e'

  " Enable spell checking for Git commit and Markdown files
  au FileType gitcommit setlocal spell
  au FileType markdown setlocal spell

  " Format cpp files on write
  au BufWritePre *.h,*.hpp,*.c,*.cc,*.cpp call ClangFormatOnWrite()

  " Return to last edit position when opening files
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
               \ |   exe "normal! g`\""
               \ | endif

  " Resize splits when the window is resized
  au VimResized * exe "normal! \<C-w>="

augroup END
