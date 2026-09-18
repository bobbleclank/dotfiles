-- Plugin manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = [[\]]

require('lazy').setup({
  -- Highlight trailing whitespace characters
  {
    'ntpeters/vim-better-whitespace',
    init = function()
      vim.g.better_whitespace_ctermcolor = 'green'
      vim.g.better_whitespace_guicolor = 'green'
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 0
    end,
  },

  -- Format code
  {
    'sbdchd/neoformat',
    init = function()
      vim.g.neoformat_enabled_cpp = { 'clangformat' }
      vim.g.neoformat_only_msg_on_error = true
    end,
  },

  -- Status and tabline
  {
    'bluz71/nvim-linefly',
    init = function()
      vim.g.linefly_options = {
        separator_symbol = "",
        progress_symbol = "↓",
        active_tab_symbol = "▪",
        git_branch_symbol = "",
        error_symbol = "E",
        warning_symbol = "W",
        information_symbol = "I",
        ellipsis_symbol = "…",
        tabline = false,
        winbar = true,
        with_file_icon = true,
        with_git_branch = true,
        with_git_status = true,
        with_diagnostic_status = true,
        with_session_status = true,
        with_attached_clients = true,
        with_lsp_status = true,
        with_macro_status = true,
        with_search_count = true,
        with_spell_status = true,
        with_indent_status = false,
      }
    end,
  },
  {
    'nanozuki/tabby.nvim',
    config = function()
      require('tabby.tabline').use_preset('active_wins_at_tail', {
        nerdfont = true,
      })
    end,
  },

  -- Indicate added, modified and removed lines in the sign column
  {
    'airblade/vim-gitgutter',
    init = function()
      vim.g.gitgutter_enabled = 0
      vim.g.gitgutter_signs = 1
      vim.g.gitgutter_highlight_linenrs = 0
      vim.g.gitgutter_highlight_lines = 0
      vim.g.gitgutter_map_keys = 0
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          delete = { show_count = true },
          topdelete = { show_count = true },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
      })
    end,
  },

  -- Call any arbitrary Git command
  { 'tpope/vim-fugitive' },

  -- General-purpose command-line fuzzy finder
  {
    'ibhagwan/fzf-lua',
    opts = {
      keymap = {
        builtin = { true, ['<C-/>'] = 'toggle-preview' },
        fzf = { true, ['ctrl-/'] = 'toggle-preview' },
      },
      history = { cwd_only = true },
      lsp = { workspace_symbols = { cwd_only = true } },
    },
  },

  -- Configs for the Nvim LSP client
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').clangd.setup({ cmd = { 'clangd', '--log=error' } })
    end,
  },

  -- Treesitter configurations and abstraction layer
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "bash",
          "cmake",
          "cpp",
          "lua",
          "markdown",
          "markdown_inline",
          "vim",
          "vimdoc",
        },
        sync_install = false,
        auto_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['if'] = '@function.inner',
              ['af'] = '@function.outer',
              ['ic'] = '@class.inner',
              ['ac'] = '@class.outer',
            },
          },
        },
      })
    end,
  },

  -- Themes
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    lazy = true,
    init = function()
      vim.g.moonflyItalics = true
      vim.g.moonflyTransparent = true
      vim.g.moonflyUndercurls = false
    end,
  },
  {
    'bluz71/vim-nightfly-colors',
    name = 'nightfly',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.nightflyItalics = true
      vim.g.nightflyTransparent = true
      vim.g.nightflyUndercurls = false
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
          },
        },
      })
    end,
  },
  {
    'tiagovla/tokyodark.nvim',
    lazy = true,
    opts = {
      transparent_background = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        identifiers = { italic = false },
        functions = {},
        variables = {},
      },
    },
  },

  -- Icons
  { 'nvim-tree/nvim-web-devicons' },
})

-- Text formatting

vim.o.tabstop = 8
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.shiftround = true

vim.o.autoindent = true
vim.o.smartindent = false
vim.o.cindent = true
vim.opt.cinoptions = { ':0', 'l1', 'g0' }

-- Color scheme

vim.o.background = 'dark'
vim.o.termguicolors = true

vim.cmd [[colorscheme nightfly]]

-- UI settings

vim.o.cursorline = false
vim.o.foldenable = false
vim.o.showmode = false
vim.o.ruler = false
vim.o.number = true
vim.o.numberwidth = 5
vim.o.signcolumn = 'yes'
vim.opt.colorcolumn = { 81, 82 }
vim.o.showcmd = true
vim.o.modeline = true
vim.o.cmdheight = 0
vim.o.showtabline = 2
vim.o.laststatus = 3

-- Visual cues

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.listchars = { tab = '▸ ', trail = '‧', extends = '»', precedes = '«' }
vim.o.list = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = '↳'
vim.o.breakindent = true
vim.o.showmatch = true
vim.o.matchtime = 3
vim.o.scrolloff = 3

-- Behavioural settings

vim.o.autoread = true
vim.o.hidden = true
vim.o.ttimeoutlen = 0
vim.o.updatetime = 100
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.o.startofline = false
vim.opt.completeopt = { 'menuone', 'longest' }
vim.opt.shortmess:append({ c = true, I = true })
vim.opt.wildignore:prepend({ '*.o' })
vim.o.path = vim.env.PWD .. '/**'

vim.o.undofile = true
vim.o.swapfile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.spelllang = 'en'
vim.o.spell = false

-- Key mappings

local fzf_lua = require('fzf-lua')

vim.keymap.set('n', '<F5>', ':set spell!<CR>', { silent = true })

vim.keymap.set('i', 'jk', '<ESC>')

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- fugitive mappings
vim.keymap.set('n', '<leader>gg', ':Git<CR>', { silent = true })
vim.keymap.set('n', '<leader>gl', ':Git log<CR>', { silent = true })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { silent = true })
vim.keymap.set('n', '<leader>gd', ':Git diff<CR>', { silent = true })
vim.keymap.set('n', '<leader>gs', ':Git diff --cached<CR>', { silent = true })
vim.keymap.set('n', '<leader>ga', ':Git add<CR>', { silent = true })
vim.keymap.set('n', '<leader>gu', ':Git add --update<CR>', { silent = true })
vim.keymap.set('n', '<leader>gp', ':Git add --patch<CR>', { silent = true })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { silent = true })
vim.keymap.set('n', '<leader>gm', ':Git commit --amend<CR>', { silent = true })
vim.keymap.set('n', '<leader>gr', ':Git rebase --interactive<space>')
vim.keymap.set('n', '<leader>gt', ':Git rebase --continue<CR>', { silent = true })
vim.keymap.set('n', '<leader>go', ':Git mergetool<CR>', { silent = true })
vim.keymap.set('n', '<leader>gk', ':Git checkout<space>')
vim.keymap.set('n', '<leader>g-', ':Git checkout -<CR>', { silent = true })

vim.keymap.set('n', '<leader>gf', ':Gdiffsplit<CR>', { silent = true })
vim.keymap.set('n', '<leader>gv', ':Gvdiffsplit<CR>', { silent = true })
vim.keymap.set('n', '<leader>gh', ':Ghdiffsplit<CR>', { silent = true })

-- fzf mappings
vim.keymap.set('n', '<C-p>', fzf_lua.files)
vim.keymap.set('n', '<leader>f', fzf_lua.git_files)
vim.keymap.set('n', '<leader>F', fzf_lua.git_status)

vim.keymap.set('n', '<leader>b', fzf_lua.buffers)
vim.keymap.set('n', '<leader>h', fzf_lua.history)

vim.keymap.set('n', '<leader>s', fzf_lua.live_grep)
vim.keymap.set('n', '<leader>w', fzf_lua.grep_cword)
vim.keymap.set('x', '<leader>w', fzf_lua.grep_visual)

vim.keymap.set('n', '<leader>l', fzf_lua.lines)
vim.keymap.set('n', '<leader>L', fzf_lua.blines)

vim.keymap.set('n', '<leader>c', fzf_lua.git_commits)
vim.keymap.set({ 'n', 'x' }, '<leader>C', fzf_lua.git_bcommits)

vim.keymap.set('n', '<leader>t', fzf_lua.helptags)
vim.keymap.set('n', '<leader><tab>', fzf_lua.keymaps)

-- lsp mappings

-- Global mappings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', fzf_lua.diagnostics_document)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'gd', fzf_lua.lsp_definitions, opts)
    vim.keymap.set('n', 'gD', fzf_lua.lsp_declarations, opts)
    vim.keymap.set('n', 'gy', fzf_lua.lsp_typedefs, opts)
    vim.keymap.set('n', 'gi', fzf_lua.lsp_implementations, opts)
    vim.keymap.set('n', 'gr', fzf_lua.lsp_references, opts)

    vim.keymap.set('n', '<leader>d', fzf_lua.lsp_document_symbols, opts)
    vim.keymap.set('n', '<leader>D', fzf_lua.lsp_live_workspace_symbols, opts)

    vim.keymap.set('n', '<leader>r', fzf_lua.lsp_incoming_calls, opts)
    vim.keymap.set('n', '<leader>R', fzf_lua.lsp_outgoing_calls, opts)

    vim.keymap.set('n', '<leader>z', fzf_lua.lsp_type_super, opts)
    vim.keymap.set('n', '<leader>Z', fzf_lua.lsp_type_sub, opts)

    vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<leader>i', vim.cmd.ClangdSwitchSourceHeader, opts)

    vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
      group = 'UserLspConfig',
      buffer = ev.buf,
      callback = function() vim.lsp.buf.document_highlight() end,
    })
    vim.api.nvim_create_autocmd({'CursorMoved'}, {
      group = 'UserLspConfig',
      buffer = ev.buf,
      callback = function() vim.lsp.buf.clear_references() end,
    })
  end,
})

-- Auto commands

local vimrc_augroup = vim.api.nvim_create_augroup('VimrcAutoCommands', { clear = true })

-- tpp files are actually cpp files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.tpp',
  group = vimrc_augroup,
  command = 'setlocal filetype=cpp',
})

-- Modify default number of spaces that a <Tab> counts for
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cmake', 'lua', 'vim' },
  group = vimrc_augroup,
  command = 'setlocal softtabstop=2',
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cmake', 'lua', 'vim' },
  group = vimrc_augroup,
  command = 'setlocal shiftwidth=2',
})

-- Enable spell checking for Git commit and Markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'markdown' },
  group = vimrc_augroup,
  command = 'setlocal spell',
})

-- Always start editing a file in case a swap file exists
vim.api.nvim_create_autocmd('SwapExists', {
  group = vimrc_augroup,
  command = [[let v:swapchoice = 'e']],
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vimrc_augroup,
  command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})

-- Resize splits when the window is resized
vim.api.nvim_create_autocmd('VimResized', {
  group = vimrc_augroup,
  command = [[exe "normal! \<C-w>="]],
})

-- Format cpp files on write
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.h', '*.hpp', '*.tpp', '*.c', '*.cc', '*.cpp' },
  group = vimrc_augroup,
  command = 'Neoformat',
})
