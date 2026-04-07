-- must install treesitter-cli before
vim.pack.add({ { src = "git@github.com:nvim-treesitter/nvim-treesitter", version = "main" } }, { conform = false })

local parsers = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html", "bash", "vue"
, "typescript", "css", "go" };


require 'nvim-treesitter'.setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require 'nvim-treesitter'.install { parsers }
