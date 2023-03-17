local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("没有找到 nvim-tree")
  return
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- when open the neovim directory ,auto open the nvim-tree
local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

vim.keymap.set({ 'n', 'i' }, '<A-m>', '<cmd>:NvimTreeToggle<CR>', {})

nvim_tree.setup {
  -- 完全禁止内置netrw
  disable_netrw = true,
  -- 不显示 git 状态图标
  git = {
    enable = true
  },
  filters = {
    -- 隐藏 .文件
    dotfiles = true,
    -- 隐藏 node_modules 文件夹
    -- custom = { "node_modules" },
  },
  renderer = {
    icons = {
      show = {
        git = true,
        file = false,
        folder = false,
        folder_arrow = true,
      }
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  view = {
    -- 隐藏根目录
    hide_root_folder = true,
    mappings = {
      -- 只用内置快捷键
      custom_only = true,
      list = { -- 打开文件或文件夹
        { key = { "o", "<2-leftmouse>" }, action = "edit" },
        { key = { "<tab>" },              action = "preview" },
        { key = "<cr>",                   action = "edit" },
        -- v分屏打开文件
        { key = "s",                      action = "vsplit" },
        -- h分屏打开文件
        -- ignore (node_modules)
        -- hide (dotfiles)
        { key = ".",                      action = "toggle_dotfiles" },
        -- { key = "r", action = "refresh" },
        -- 文件操作
        { key = "a",                      action = "create" },
        { key = "d",                      action = "remove" },
        { key = "r",                      action = "rename" },
        { key = "x",                      action = "cut" },
        { key = "c",                      action = "copy" },
        { key = "p",                      action = "paste" },
        { key = "y",                      action = "copy_name" },
        { key = "y",                      action = "copy_path" },
        { key = "gy",                     action = "copy_absolute_path" },
        { key = "i",                      action = "toggle_file_info" },
        -- 进入下一级
        { key = { "]" },                  action = "cd" },
        -- 进入上一级
        { key = { "[" },                  action = "dir_up" },
      },
    },
  },
  actions = {
    open_file = {
      -- 首次打开大小适配
      resize_window = true,
      -- 打开文件时关闭 tree
      quit_on_open = true,
    },
  },
}
