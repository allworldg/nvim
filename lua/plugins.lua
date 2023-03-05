local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    vim.notify('start to install packer')
    return true
  end
  return false
end

ensure_packer()

local status, packer = pcall(require, "packer")
if not status then
  vim.notify("packer not found")
  return
end
-- if you have opt options
vim.cmd [[packadd packer.nvim]]

packer.init(
  {
    snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshot")
  }
)

return packer.startup({ function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --lsp
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- theme
  use({ 'projekt0n/github-nvim-theme' })
  use {
    'nvim-lualine/lualine.nvim',
  }
  use({ 'tjdevries/colorbuddy.nvim' })


  -- find file
  use {
    'nvim-telescope/telescope.nvim', tag = "0.1.1",
    requires = { 'nvim-lua/plenary.nvim' },
  }

  -- highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- file System
  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- auto complete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use("hrsh7th/cmp-nvim-lsp-signature-help")

  --snip and snippets
  use({
    "L3MON4D3/LuaSnip",
    -- install jsregexp (optional!:).
    run = "make install_jsregexp"
  })
  use { 'saadparwaiz1/cmp_luasnip' }
  use 'rafamadriz/friendly-snippets'

  -- autopairs
  use("windwp/nvim-autopairs")

  -- autotag
  use("windwp/nvim-ts-autotag")

  -- Comment
  use("numToStr/Comment.nvim")

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  })


-- using packer.nvim
use {'akinsho/bufferline.nvim', tag = "v3.*"}

end,
  config = {
    -- snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshot")
  }
}
)
