local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Noyan
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use 'NLKNguyen/papercolor-theme'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'sainnhe/gruvbox-material'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
  'lewis6991/gitsigns.nvim',
  -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }
  require('gitsigns').setup()

  use "lukas-reineke/indent-blankline.nvim"

  use "ackyshake/Spacegray.vim"

  use "srcery-colors/srcery-vim"

  use "AlessandroYorba/Alduin"

  use "baskerville/bubblegum"

  use "dikiaap/minimalist"

  use "tomasiser/vim-code-dark"

  use "sainnhe/sonokai"

  use "ayu-theme/ayu-vim"

  use "folke/tokyonight.nvim"
  
  use "bluz71/vim-moonfly-colors"

  use "itsjunetime/rose-pine-vim"

  use "aditya-azad/candle-grey"

  use "owickstrom/vim-colors-paramount"

  use "vim-scripts/twilight256.vim"

  use "axvr/photon.vim"

  use "jpo/vim-railscasts-theme"

  use "rstacruz/vim-closer"

  use "joshdick/onedark.vim"

  use "savq/melange-nvim"

  use "phanviet/vim-monokai-pro"

  use "Mofiqul/dracula.nvim"

  -- lsp
  use {
  'VonHeikemen/lsp-zero.nvim',
  requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

