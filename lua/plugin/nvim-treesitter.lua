return {
  'nvim-treesitter/nvim-treesitter',
  branch = "main",
  build = ':TSUpdate',
  cond=true,
  lazy = false,
  config = function()
    local parsers = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html", "bash", "vue"
    , "typescript", "css", "go" };
    require 'nvim-treesitter'.setup {
      install_dir = vim.fn.stdpath('data') .. '/site'
    }
    require 'nvim-treesitter'.install { parsers }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = parsers,
      callback = function(event)
        local max_fileSize = 100 * 1024 -- 100kb
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(event.buf))
        if ok and stats and stats.size < max_fileSize then
          vim.treesitter.start()
        end
      end,
    })
  end
}
