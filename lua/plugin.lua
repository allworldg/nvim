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


require("lazy").setup({

  --lsp
  {
    "williamboman/mason.nvim",
    config = function()
      require("plugin-config.mason")
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugin-config.mason-lspconfig")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp.lspconfig")
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("lsp.null-ls")
    end
  },


  -- theme
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('colorscheme.github-nvim-theme')
    end,
    cond = true,
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require("plugin-config.nvim-lualine")
    end,
    -- cond = false
  },

  -- find file

  {
    'nvim-telescope/telescope.nvim',
    tag = "0.1.1",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("plugin-config.telescope")
    end,
  },


  -- highlight
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require("plugin-config.nvim-treesiter")
    end
  },
  'nvim-treesitter/playground',

  -- file System
  {
    'nvim-tree/nvim-tree.lua',
    version = "nightly", -- optional, updated every week. (see issue #1193)
    config = function()
      require("plugin-config.nvim-tree")
    end
  },

  -- auto complete

  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      "hrsh7th/cmp-nvim-lsp-signature-help",
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require("plugin-config.nvim-cmp")
    end,
  },
  --snip and snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin-config.nvim-autopairs")
    end
  },
  -- autotag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("plugin-config.nvim-ts-autotag")
    end
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugin-config.comment")
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("plugin-config.nvim-surround")
    end
  },

  {
    'RRethy/vim-illuminate',
    -- cond = false,
    config = function()
      require("plugin-config.vim-illuminate")
    end
  },
  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup", border = 'single' }
    end
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      return require("plugin-config.toggleterm")
    end
  }
}
)
