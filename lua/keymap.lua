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
-- quick select all
map('n', '<leader>a', 'ggVG', opt)
-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_", opt)
map("v", "g_", "$", opt)
map("n", "$", "g_", opt)
map("n", "g_", "$", opt)
-- save and exit
map("n", "<leader>w", ":w<CR>", opt)
map("n", "<leader>wq", ":w|q!<CR>", opt)
map("n","<leader>wa", ":wa<CR>",opt)

-- -- exit
map("n", "q", "<Nop>", opt)
map("n", "qq", ":q!<CR>", vim.tbl_extend('force', opt, { nowait = true }))
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

map("v", "p", 'P', opt)
-- buffer
map("n", "<leader>bl", ":buffers<CR>:buffer<Space>", {})

vim.keymap.set("n", "<c-h>", ":tabp<CR>", { silent = true })
vim.keymap.set("n", "<c-l>", ":tabn<CR>", { silent = true })
vim.keymap.set("n", "<leader>ta", ":tabnew<CR>", { silent = true })



-- ------------------------------------------------------------------
-- -- windows 分屏快捷键
-- ------------------------------------------------------------------
-- 左右比例控制
map("n", "<c-left>", ":vertical resize -2<cr>", opt)
map("n", "<c-right>", ":vertical resize +2<cr>", opt)
-- 上下比例
map("n", "<c-down>", ":resize +2<cr>", opt)
map("n", "<c-up>", ":resize -2<cr>", opt)
