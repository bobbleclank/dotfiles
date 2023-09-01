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
Plug 'bluz71/nvim-linefly'
Plug 'nanozuki/tabby.nvim'

" Indicate added, modified and removed lines in the sign column
Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'

" Call any arbitrary Git command
Plug 'tpope/vim-fugitive'

" General-purpose command-line fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Configs for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Themes
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-nightfly-colors'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim',

" Icons
Plug 'nvim-tree/nvim-web-devicons'

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
" Color scheme
"-------------------------------------------------------------------------------

set background=dark
set termguicolors

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

"-------------------------------------------------------------------------------
" UI settings
"-------------------------------------------------------------------------------

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
set laststatus=3

lua << EOF
require('tabby.tabline').use_preset('active_wins_at_tail', {
  nerdfont = true,
})
EOF

lua << EOF
vim.g.linefly_options = {
  separator_symbol = "",
  progress_symbol = "↓",
  active_tab_symbol = "▪",
  git_branch_symbol = "",
  error_symbol = "E",
  warning_symbol = "W",
  information_symbol = "I",
  tabline = false,
  winbar = true,
  with_file_icon = true,
  with_git_branch = true,
  with_git_status = true,
  with_diagnostic_status = true,
  with_session_status = false,
  with_macro_status = true,
  with_search_count = true,
  with_spell_status = true,
  with_indent_status = false,
}
EOF

let g:gitgutter_enabled = 0
let g:gitgutter_signs = 1
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0

lua << EOF
require'gitsigns'.setup {
  signs = {
    delete = { show_count = true },
    topdelete = { show_count = true },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
}
EOF

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_preview_window = ['up,50%', 'ctrl-/']

lua << EOF
require'lspconfig'.clangd.setup {
}
EOF

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
let g:better_whitespace_guicolor = 'green'
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

let mapleader = '\'

nnoremap <F5> :set spell! spell?<CR>
nnoremap <F6> :set list! list?<CR>
nnoremap <F7> :ToggleWhitespace<CR>
nnoremap <F8> :nohlsearch<CR>

nnoremap <F9> :set paste! paste?<CR>
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

" fugitive mappings
nnoremap <silent> <leader>gg :Git<CR>
nnoremap <silent> <leader>gl :Git log<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gd :Git diff<CR>
nnoremap <silent> <leader>gs :Git diff --cached<CR>
nnoremap <silent> <leader>ga :Git add<CR>
nnoremap <silent> <leader>gu :Git add --update<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gm :Git commit --amend<CR>
nnoremap          <leader>gr :Git rebase --interactive<space>
nnoremap <silent> <leader>gt :Git rebase --continue<CR>

nnoremap <silent> <leader>gf :Gdiffsplit<CR>
nnoremap <silent> <leader>gv :Gvdiffsplit<CR>
nnoremap <silent> <leader>gh :Ghdiffsplit<CR>

" fzf mappings
nnoremap <silent> <C-p>     :Files<CR>
nnoremap <silent> <leader>f :GFiles<CR>
nnoremap <silent> <leader>g :GFiles?<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>

nnoremap          <leader>s :Rg<space>
nnoremap <silent> <leader>w :Rg <C-r><C-w><CR>
xnoremap <silent> <leader>v y:Rg <C-r>"<CR>

nnoremap <silent> <leader>l :Lines<CR>
nnoremap <silent> <leader>k :BLines<CR>

nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>x :BCommits<CR>

nnoremap <silent> <leader>m :Commands<CR>
nnoremap <silent> <leader>t :Helptags<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <C-x><C-k> <plug>(fzf-complete-word)
imap <C-x><C-f> <plug>(fzf-complete-path)
imap <C-x><C-l> <plug>(fzf-complete-line)

" lsp mappings
lua << EOF
-- Global mappings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gc', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

    vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
      group = 'UserLspConfig',
      callback = function() vim.lsp.buf.document_highlight() end,
    })
    vim.api.nvim_create_autocmd({'CursorMoved'}, {
      group = 'UserLspConfig',
      callback = function() vim.lsp.buf.clear_references() end,
    })
  end,
})
EOF

nnoremap <silent> <leader>ia :<C-u>ClangdSwitchSourceHeader<CR>

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

  " Return to last edit position when opening files
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
               \ |   exe "normal! g`\""
               \ | endif

  " Resize splits when the window is resized
  au VimResized * exe "normal! \<C-w>="

  " Format cpp files on write
  au BufWritePre *.h,*.hpp,*.c,*.cc,*.cpp call ClangFormatOnWrite()

augroup END
