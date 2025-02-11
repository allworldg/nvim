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
  silent = true,
  noremap = true,
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
-- 解释：_d会将选中字符送去黑洞寄存器，然后P在当前光标前进行paste，如果用"_dp,
-- 则是先送去黑洞寄存器，此时后面的字符往前移动，p粘贴到当前光标之后，所以会出现问题。
map("v", "p", '"_dP', opt)
-- buffer
map("n", "<leader>bl", ":buffers<CR>:buffer<Space>", {})



-- ------------------------------------------------------------------
-- -- windows 分屏快捷键
-- ------------------------------------------------------------------

map("n", "<leader>sv", ":vsp<cr>", opt)
map("n", "<leader>sh", ":sp<cr>", opt)
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
