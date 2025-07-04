-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '

vim.opt.nu = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- clipboard
vim.api.nvim_set_keymap('n', 'y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', 'p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('n', 'P', '"+P', { noremap = true })
vim.api.nvim_set_keymap('n', 'd', '"+d', { noremap = true })
vim.api.nvim_set_keymap('v', 'y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', 'p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', 'P', '"+P', { noremap = true })
vim.api.nvim_set_keymap('v', 'd', '"+d', { noremap = true })
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- misc
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
-- vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- noyan paste
vim.keymap.set('n', '<leader>p', 'viwpyiw')

-- annoying
vim.keymap.set('n', 'K', '')
vim.keymap.set('n', 'J', '')
vim.keymap.set('v', 'K', '')
vim.keymap.set('v', 'J', '')

-- tab/window
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>')
vim.keymap.set('n', '<S-l>', ':tabnext<CR>')
vim.keymap.set('n', '<S-h>', ':tabprevious<CR>')
vim.keymap.set('n', '<leader>|', '<C-w>v')
vim.keymap.set('n', '<leader>-', '<C-w>s')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
  {'marko-cerovac/material.nvim'},
  {'nvim-lualine/lualine.nvim'},
  {'nvim-tree/nvim-web-devicons'},
  {'nvim-lua/plenary.nvim'},
  {'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = { 'nvim-lua/plenary.nvim' }},
  {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
  {'numToStr/Comment.nvim', opts = {}, lazy = false},
  {'lewis6991/gitsigns.nvim'},
  {'zefei/cake16'},
  {'ajgrf/parchment'},
  {'rebelot/kanagawa.nvim'},
  {'wellle/context.vim'},
  -- {'petertriho/nvim-scrollbar'},
  {'nvim-tree/nvim-tree.lua'},
  {'sharkdp/fd'},
  {'NLKNguyen/papercolor-theme'},
  {'catppuccin/nvim'},
  {'projekt0n/github-nvim-theme'},
  {'morhetz/gruvbox'},
  {'tomasr/molokai'},
  {'nanotech/jellybeans.vim'},
  {'bluz71/vim-moonfly-colors'},
  {'savq/melange-nvim'},
  {'jaredgorski/spacecamp'},
  {'kyoz/purify'},
  {'fxn/vim-monochrome'},
  {'altercation/vim-colors-solarized'},
  {'dikiaap/minimalist'},
  {'yorickpeterse/vim-paper'},
  {'lifepillar/vim-solarized8'},

-- LSP
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  {'kemiller/vim-ir_black'},
  {'folke/trouble.nvim', dependencies = {"nvim-tree/nvim-web-devicons"}},
})

-- plugin setup
-- trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
-- context override
vim.keymap.set('n', '<S-h>', ':tabprevious<CR>')
-- require("scrollbar").setup()
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>nn', ':NvimTreeToggle<CR>')
-- LSP
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)
require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {'clangd', 'lua_ls'},
  handlers = {
    lsp_zero.default_setup,
  }
})
require'lspconfig'.jedi_language_server.setup{}
-- remove annoying semantics
lsp_zero.set_server_config({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
-- completion
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})
-- turn off inline diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

-- others
require('lualine').setup({
})
local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- we'll use <leader>ff for formatting
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
require('Comment').setup()
require('gitsigns').setup()

-- colorscheme
vim.opt.termguicolors = true
vim.cmd('syntax on')
vim.api.nvim_cmd({
  cmd = 'colorscheme',
  args = {'ir_black'}
}, {})
vim.g['background'] = 'dark'

