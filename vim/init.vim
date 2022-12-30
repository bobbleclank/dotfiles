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
Plug 'airblade/vim-gitgutter'

" Call any arbitrary Git command
Plug 'tpope/vim-fugitive'

" General-purpose command-line fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Conquer of completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Use fzf instead of coc.nvim built-in fuzzy finder
Plug 'antoinemadec/coc-fzf', { 'branch': 'release' }

" Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Themes
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-nightfly-colors'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

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
set termguicolors

function! ColumnHighlighting() abort
  highlight LineNr ctermfg=darkgray guifg=darkgray
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight ColorColumn ctermbg=darkgray guibg=darkgray
endfunction

function! SignifyHighlighting() abort
  highlight SignifySignAdd ctermfg=green guifg=#00ff00 cterm=NONE gui=NONE
  highlight SignifySignDelete ctermfg=red guifg=#ff0000 cterm=NONE gui=NONE
  highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE
endfunction

function! DefaultThemeHighlighting() abort
  call ColumnHighlighting()
  call SignifyHighlighting()
endfunction

augroup DefaultThemeAutoCommands
  autocmd!
  au ColorScheme default call DefaultThemeHighlighting()
augroup END

colorscheme default

let g:moonflyItalics = v:true
let g:moonflyTransparent = v:true
let g:moonflyUndercurls = v:true

colorscheme moonfly

let g:nightflyItalics = v:true
let g:nightflyTransparent = v:true
let g:nightflyUndercurls = v:true

colorscheme nightfly

lua << EOF
require'nightfox'.setup {
  options = {
    transparent = true,
    styles = {
      comments = "italic",
      keywords = "NONE",
    },
  },
}
EOF

colorscheme nightfox

augroup TokyonightThemeAutoCommands
  autocmd!
  au ColorScheme tokyonight,tokyonight-storm,tokyonight-night,tokyonight-moon
               \ call SignifyHighlighting()
augroup END

lua << EOF
require'tokyonight'.setup {
  style = "night",
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
  },
}
EOF

colorscheme tokyonight

colorscheme carbonfox

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

let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1

let g:signify_disable_by_default = 0
let g:signify_sign_show_count = 1
let g:signify_number_highlight = 0
let g:signify_line_highlight = 0

let g:gitgutter_enabled = 0
let g:gitgutter_signs = 1
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0

let g:coc_global_extensions = ['coc-clangd']

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "cpp" },
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
}
EOF

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

function! ClangFormatOnWrite() abort
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

augroup VimrcAutoCommands
  autocmd!

  " tpp files are actually cpp files
  au BufRead,BufNewFile *.tpp setlocal filetype=cpp

  " Modify default number of spaces that a <Tab> counts for
  au FileType cmake setlocal softtabstop=2
  au FileType cmake setlocal shiftwidth=2

  " Always start editing a file in case a swap file exists
  au SwapExists * let v:swapchoice = 'e'

  " Enable spell checking for Git commit and Markdown files
  au FileType gitcommit,markdown setlocal spell

  " Format cpp files on write
  au BufWritePre *.h,*.hpp,*.c,*.cc,*.cpp call ClangFormatOnWrite()

  " Return to last edit position when opening files
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
               \ |   exe "normal! g`\""
               \ | endif

  " Resize splits when the window is resized
  au VimResized * exe "normal! \<C-w>="

augroup END
