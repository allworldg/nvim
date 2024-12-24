return {

  'nvim-telescope/telescope.nvim',
  tag = "0.1.8",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local keymap = vim.keymap.set
    local builtin = require('telescope.builtin')
    keymap('n', 'gr', builtin.lsp_references, {})
    keymap('n', 'gd', builtin.lsp_definitions, {})
    keymap("n", "<C-p>", builtin.find_files, {})
    keymap({ 'n', 'i' }, "<C-f>", builtin.live_grep, {})
    require("telescope").setup({
      defaults = {
        results_title = '',
        prompt_title = '',
        -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
        initial_mode = "insert",
        -- vertical , center , cursor,horizontal
        layout_strategy = "vertical", -- 可以写入局部picker来改变具体的picker界面
        path_display = { "smart" },
        -- 窗口内快捷键
        mappings = {
          i = {
            -- 上下移动
            ["<c-n>"] = "move_selection_next",
            ["<c-p>"] = "move_selection_previous",
            -- 历史记录
            ["<down>"] = "cycle_history_next",
            ["<up>"] = "cycle_history_prev",
            -- 关闭窗口
            -- ["<esc>"] = actions.close,
            ["<c-c>"] = "close",
            -- 预览窗口上下滚动
            ["<c-u>"] = "preview_scrolling_up",
            ["<c-d>"] = "preview_scrolling_down",
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          results_title = '',
          prompt_title = "",
          previewer = false,
          path_display = { "truncate" },
        },
        live_grep = {
          -- remember install ripgrep before use
          results_title = '',
          prompt_title = "",
          shorten_path = true,
          path_display = { "truncate" },
          layout_strategy = "vertical",
          layout_config = {
            width = 0.99,
            height = 0.99,
            preview_cutoff = 10,
          },
        },
        lsp_references = {
          theme = "cursor",
          shorten_path = true,
          prompt_title = '',
          path_display = { "truncate" },
          previewer = false,
          layout_config = {
            width = 0.8,
            height = 0.5
          },
        },
        lsp_definitions = {
          results_title = '',
          prompt_title = "",
          path_display = { "truncate" },
          layout_config = { preview_cutoff = 10 },
        },
      },
    })
  end
}
