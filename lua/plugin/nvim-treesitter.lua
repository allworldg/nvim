-- must install treesitter-cli before
vim.pack.add({ { src = "git@github.com:nvim-treesitter/nvim-treesitter", version = "main" } }, { conform = false })

local parsers = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html", "bash", "vue"
, "typescript", "css", "go" };

vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    local max_fileSize = 100 * 1024 -- 100kb
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(event.buf))
    if ok and stats and stats.size > max_fileSize then
      vim.treesitter.stop(event.buf)
    end
  end,
})

require 'nvim-treesitter'.setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require 'nvim-treesitter'.install { parsers }
