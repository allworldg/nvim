-- lazy.nvim

vim.api.nvim_create_user_command(
  'Dashboard', -- 命令名称 :Test
  function()
    vim.cmd('lua Snacks.dashboard()')
  end,
  { nargs = 0 } -- 参数配置（这里是 0 表示不接受参数）
)
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      sections = {
        { section = "startup" },
        { section = "header" },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      },
    }
  },
}
