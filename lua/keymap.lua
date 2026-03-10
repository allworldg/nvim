-- mode
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   terminal_mode = "t",
--   command_mode = "c",


-- leader key is space
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

map("n", "<leader>w", ":w<CR>", opt)
map("n", "<leader>wq", ":w|q<CR>", opt)
map("n", "<leader>wa", ":wa<CR>", opt)
map("n", "q", "<Nop>", opt)
map("n", "qq", ":q!<CR>", vim.tbl_extend('force', opt, { nowait = true }))
map("n", "<leader>q", ":qa<CR>", opt)

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<c-u>", "10k", opt)
map("n", "<c-d>", "10j", opt)

map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

map("v", "p", 'P', opt)

vim.keymap.set("n", "<c-h>", ":tabp<CR>", { silent = true })
vim.keymap.set("n", "<c-l>", ":tabn<CR>", { silent = true })
vim.keymap.set("n", "<leader>ta", ":tabnew<CR>", { silent = true })
