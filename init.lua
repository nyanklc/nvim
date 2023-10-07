vim.g.mapleader = ' '

vim.opt.nu = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
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
-- vim.g.clipboard = 'unnamedplus'


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
  {'nvim-lua/plenary.nvim'},
  {'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = { 'nvim-lua/plenary.nvim' }},
  {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
  {'numToStr/Comment.nvim', opts = {}, lazy = false},
  {'lewis6991/gitsigns.nvim'},
  {'zefei/cake16'},
  {'ajgrf/parchment'},
  {'rebelot/kanagawa.nvim'},
  {'wellle/context.vim'},

-- LSP
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
})

-- plugin setup
-- context override
vim.keymap.set('n', '<S-h>', ':tabprevious<CR>')
-- LSP
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)
require('lspconfig').lua_ls.setup({})
require('lspconfig').clangd.setup{}
-- others
require('lualine').setup({
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
require('Comment').setup()
require('gitsigns').setup()

-- colorscheme
vim.opt.termguicolors = true
vim.g.material_style = 'darker'
vim.cmd.colorscheme('material')

-- neovide
-- macos only
--   -- Helper function for transparency formatting
--   local alpha = function()
--     return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
--   end
--   -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
--   vim.g.neovide_transparency = 0.0
--   vim.g.transparency = 0.8
--   vim.g.neovide_background_color = "#0f1117" .. alpha()
-- neovide only
if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
  -- vim.o.guifont = "Source Code Pro:h14"
  vim.api.nvim_set_keymap("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end
-- generic
-- vim.g.neovide_transparency = 0.5
vim.g.neovide_hide_mouse_when_typing = true
