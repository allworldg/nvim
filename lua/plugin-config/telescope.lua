local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end

telescope.setup({
  defaults = {
    results_title = '',
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- vertical , center , cursor,horizontal
    layout_strategy = "vertical", -- 可以写入局部picker来改变具体的picker界面
    layout_config = {
      width = 0.8, -- （猜测） 小于1时是按照百分比，大于的话是按照某个单位
    },
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
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown", -- 可选参数： dropdown, cursor, ivy
      previewer = false,
    },
    live_grep = {
      layout_strategy = "vertical",
      shorten_path = true,
      layout_config = { preview_cutoff = 10 }, -- 放大界面也不会让preview界面消失,
    },
  },
  extensions = {
  },
})
