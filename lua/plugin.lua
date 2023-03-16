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

  -- Packer can manage itself
  'wbthomason/packer.nvim',
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",


  -- theme
  'projekt0n/github-nvim-theme',

  'nvim-lualine/lualine.nvim',

  -- find file

  {
    'nvim-telescope/telescope.nvim',
    version = "0.1.1",
    dependencies = { 'nvim-lua/plenary.nvim' },
  },


  -- highlight

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },

  'nvim-treesitter/playground',

  -- file System
  {
    'nvim-tree/nvim-tree.lua',
    version = "nightly" -- optional, updated every week. (see issue #1193)
    -- commit = "16a0e3c"
  },

  -- auto complete
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lua',
  "hrsh7th/cmp-nvim-lsp-signature-help",

  --snip and snippets
  {
    "L3MON4D3/LuaSnip",
    -- install jsregexp (optional!:).
    cms = "make install_jsregexp"
  },
  { 'saadparwaiz1/cmp_luasnip' },
  'rafamadriz/friendly-snippets',

  -- autopairs
  "windwp/nvim-autopairs",

  -- autotag
  "windwp/nvim-ts-autotag",

  -- Comment
  "numToStr/Comment.nvim",

  {
    "kylechui/nvim-surround",
    version = "*",
  },


  -- using packer.nvim
  { 'akinsho/bufferline.nvim', version = "v3.*" },

  { 'RRethy/vim-illuminate' },
}
)
