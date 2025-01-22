vim.cmd [[
  highlight SnacksIndent guifg=#d3d3d3
]]
vim.api.nvim_create_user_command(
  'Dashboard', -- 命令名称 :Test
  function()
    vim.cmd('lua Snacks.dashboard()')
  end,
  { nargs = 0 } -- 参数配置（这里是 0 表示不接受参数）
)
return {
  "folke/snacks.nvim",
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- words = {enabled = true},
    dim = {},
    -- notifier={},
    indent = {
      animate = { enabled = false },
      indent = {
        priority = 1,
        enabled = true,     -- enable indent guides
        char = "│",
        only_scope = false, -- only show indent guides of the scope
        hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
      },
    },
    dashboard = {
      preset = {
        header = [[allworldg]]
      },
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      sections = {
        { section = "startup" },
        { section = "header", padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      },
    },
    picker = {
      win = {
        input = {
          keys = {
            ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
          }
        }
      }
    },
  },
  keys = {
    -- picker
    { "<c-f>",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
    { "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
    { "<c-p>",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
    -- git
    { "<leader>gc", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
    -- LSP
    { "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
    { "gr",         function() Snacks.picker.lsp_references() end,                          nowait = true,                  desc = "References" },
    { "gi",         function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
    { "gD",         function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
  },
}
