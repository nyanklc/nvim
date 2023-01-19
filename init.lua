-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- colorscheme
vim.cmd("set background=dark")
vim.cmd("colorscheme alduin")
vim.g.background = "dark"

-- options
vim.g.mapleader = ","
vim.cmd("set clipboard=unnamedplus")
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.incsearch = true
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.swapfile = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 12
vim.o.errorbells = false
vim.o.showtabline = 2
vim.o.guicursor = ""
vim.o.smartindent = true

-- clear mappings
map("n", "<S-j>", "")

-- switch between tabs
map("n", "<S-l>", "gt")
map("n", "<S-h>", "gT")

-- switch between splits
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- new tab
map("n", "<Leader>tn", ":tabnew<CR>")

-- new split
map("n", "<Leader>|", ":vs<CR>")
map("n", "<Leader>-", "<C-w>s<CR>")

-- no highlight
map("n", "<Leader><CR>", ":noh<CR>")

-- file tree
map("n", "<Leader>nn", ":NvimTreeToggle<CR>")

-- fuzzy finder
map("n", "<C-f>", ":Telescope find_files<CR>")

-- search text
map("n", "<Space>", "/")

-- autocomplete
map("i", "<C-Space>", "")

-- terminal
map("t", "<Esc>", "<C-\\><C-n>")

-- format file
map("n", "<Leader>ff", ":LspZeroFormat<CR>")

-- plugins and stuff
require("init")
