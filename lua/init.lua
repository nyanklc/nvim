require("plugins")
require('nvim-tree-filetree')
require("telescope").setup()
require("treesitter")
vim.opt.list = true
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}

-- lsp
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.set_server_config({
  single_file_support = true,
})
-- clangd
lsp.configure('clangd', {
  single_file_support = true,
})
-- add more server configurations here
lsp.setup()
