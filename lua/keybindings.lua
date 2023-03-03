-- mode
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opt = {
  noremap = true,
  silent = true,
}
--
-- -- 本地变量
local map = vim.api.nvim_set_keymap
-- quick select all
map('n', '<leader>a', 'ggVG', opt)
-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_", opt)
map("v", "g_", "$", opt)
map("n", "$", "g_", opt)
map("n", "g_", "$", opt)

-- save and exit
map("n", "<leader>w", ":w<CR>", opt)
map("n", "<leader>wq", ":wqa!<CR>", opt)

-- fix :set wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<c-u>", "10k", opt)
map("n", "<c-d>", "10j", opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- 在visual mode 里粘贴的同时顺利打开附件不要复制
map("v", "p", '"_dp', opt)

-- -- 退出
map("n", "qq", ":q!<CR>", opt)
map("n", "<leader>q", ":qa!<CR>", opt)

-- ------------------------------------------------------------------
-- -- windows 分屏快捷键
-- ------------------------------------------------------------------

map("n", "<leader>sv", ":vsp<cr>", opt)
map("n", "<leader>sh", ":sp<cr>", opt)
-- 关闭当前
map("n", "<leader>sc", "<c-w>c", opt)
-- 关闭其他split
map("n", "<leader>so", "<c-w>o", opt) -- close others
-- <leader> + hjkl 窗口之间跳转
map("n", "<leader>h", "<c-w>h", opt)
map("n", "<leader>j", "<c-w>j", opt)
map("n", "<leader>k", "<c-w>k", opt)
map("n", "<leader>l", "<c-w>l", opt)
-- 左右比例控制
map("n", "<c-left>", ":vertical resize -2<cr>", opt)
map("n", "<c-right>", ":vertical resize +2<cr>", opt)
map("n", "<leader>s,", ":vertical resize -10<cr>", opt)
map("n", "<leader>s.", ":vertical resize +10<cr>", opt)
-- 上下比例
map("n", "<leader>sj", ":resize +10<cr>", opt)
map("n", "<leader>sk", ":resize -10<cr>", opt)
map("n", "<c-down>", ":resize +2<cr>", opt)
map("n", "<c-up>", ":resize -2<cr>", opt)
-- 相等比例
map("n", "<leader>s=", "<c-w>=", opt)

-- terminal相关
map("n", "<A-`>", ":sp | terminal<cr>", opt)
map("n", "<leader>st", ":sp | terminal<cr>", opt)
map("n", "<leader>stv", ":vsp | terminal<cr>", opt)
-- esc 回 normal 模式
map("t", "<esc>", "<c-\\><c-n>", opt)
map("t", "<a-h>", [[ <c-\><c-n><c-w>h ]], opt)
map("t", "<a-j>", [[ <c-\><c-n><c-w>j ]], opt)
map("t", "<a-k>", [[ <c-\><c-n><c-w>k ]], opt)
map("t", "<a-l>", [[ <c-\><c-n><c-w>l ]], opt)
map("t", "<leader>h", [[ <c-\><c-n><c-w>h ]], opt)
map("t", "<leader>j", [[ <c-\><c-n><c-w>j ]], opt)
map("t", "<leader>k", [[ <c-\><c-n><c-w>k ]], opt)
map("t", "<leader>l", [[ <c-\><c-n><c-w>l ]], opt)

---------------------- 插件快捷键(plugin keybinding)----------------------------------------------

-- telescope
map("n", "<C-p>", ":Telescope find_files<cr>", opt)
map("n", "<C-f>", ":Telescope live_grep<cr>", opt)


local pluginKeys = {}
-- nvimtree
map('n', '<A-m>', ':NvimTreeToggle<CR>', opt)
-- 列表快捷键
pluginKeys.nvimTreeList = { -- 打开文件或文件夹
  { key = { "o", "<2-leftmouse>" }, action = "edit" },
  { key = { "<tab>" }, action = "preview" },
  { key = "<cr>", action = "edit" },
  -- v分屏打开文件
  { key = "s", action = "vsplit" },
  -- h分屏打开文件
  -- ignore (node_modules)
  -- hide (dotfiles)
  { key = ".", action = "toggle_dotfiles" },
  -- { key = "r", action = "refresh" },
  -- 文件操作
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "y", action = "copy_name" },
  { key = "y", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "i", action = "toggle_file_info" },
  -- 进入下一级
  { key = { "]" }, action = "cd" },
  -- 进入上一级
  { key = { "[" }, action = "dir_up" },
}

--comment
-- -- see ./lua/plugin-config/comment.lua
pluginKeys.comment = {
  -- normal 模式快捷键
  toggler = {
    line = "gcc", -- 行注释
    block = "gbc", -- 块注释
  },
  -- visual 模式
  opleader = {
    line = "gc",
    bock = "gb",
  },
}
-- ctrl + /
map("n", "<c-_>", "gcc", { noremap = false })
map("v", "<c-_>", "gc", { noremap = false })


-- bufferline
-- 左右tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- "moll/vim-bbye" 关闭当前 buffer
map("n", "<C-w>", ":bdelete!<cr>", opt)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)
-- 关闭选中标签页
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opt)

return pluginKeys
