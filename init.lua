-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '

vim.opt.nu = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- misc
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
-- vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- neovide
if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font:h13"

    vim.g.neovide_scale_factor = 1.0

    local change_scale = function(delta)
        vim.g.neovide_scale_factor =
            vim.g.neovide_scale_factor * delta
    end

    vim.keymap.set("n", "<C-=>", function() change_scale(1.1) end)
    vim.keymap.set("n", "<C-+>", function() change_scale(1.1) end)
    vim.keymap.set("n", "<C-->", function() change_scale(1/1.1) end)
    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
end

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
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-nvim-lua'},

  -- LSP
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},

  -- completion
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-buffer'},
  {'L3MON4D3/LuaSnip'},
  {'kemiller/vim-ir_black'},
  {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        },
      },
    },
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

-- ======================
-- LSP (Neovim 0.11+ native config)
-- ======================

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "lua_ls",
    },
})

-- capabilities for completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- shared on_attach
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local opts = { buffer = bufnr }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

-- diagnostics (modern API)
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
    },
})

-- ======================
-- LSP SERVER CONFIG (NEW API)
-- ======================

vim.lsp.config("clangd", {
    capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

vim.lsp.enable({ "clangd", "lua_ls" })

-- ======================
-- Completion
-- ======================

local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function()
            -- no snippet engine wired (LuaSnip optional)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),

    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    },
})

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
  args = {'gruvbox'}
}, {})
vim.g['background'] = 'dark'

