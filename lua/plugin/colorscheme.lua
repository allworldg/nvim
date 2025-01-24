return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    cond = true,
    config=function()
      vim.cmd.colorscheme('github_light_default')
      local config = {
        options = {
          styles = {
            comments = "NONE",
            keywords = "NONE",
          }
        }
      }
      -- @diagnostic disable-next-line: unused-local
      -- groups = {
      --   -- NormalFloat = { bg = '#F7F7F7' }
      -- }
      return config
    end
  },

}
