-- mode
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   terminal_mode = "t",
--   command_mode = "c",


-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opt = {
  noremap = true,
  silent = true,
}
--
local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
-- quick select all
map('n', '<leader>a', 'ggVG', opt)
-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_", opt)
map("v", "g_", "$", opt)
map("n", "$", "g_", opt)
map("n", "g_", "$", opt)
-- save and exit
map("n", "<leader>w", ":w<CR>", opt)
map("n", "<leader>wq", ":wall|qa!<CR>", opt)

-- -- exit
map("n", "qq", ":q!<CR>", opt)
map("n", "<leader>q", ":qa<CR>", opt)

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

-- buffer
map("n", "<leader>bl", ":buffers<CR>:buffer<Space>", {})

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
