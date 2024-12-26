return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { "c", "lua", "vim", "help", "python", "javascript", "html", "bash" },
    sync_install = false,
    auto_install = false,
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      -- disable in big file
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
        },
      }
    end
  }
}
