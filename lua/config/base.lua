-- utf8
vim.opt.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
-- jk移动时光标下上方保留8行
vim.opt.clipboard = "unnamedplus"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- use line number
vim.wo.number = true
-- 高亮所在行
vim.wo.cursorline = true
vim.wo.cursorlineopt = "line"
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
vim.opt.winblend = 0
-- one tab == 2 blackspace
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
-- >> << 时移动长度
vim.opt.shiftwidth = 2
-- 新行对齐当前行，空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索不要高亮
vim.o.hlsearch = false
-- 边输入边搜索
vim.opt.incsearch = true
-- 使用增强状态栏后不再需要 vim 的模式提示
vim.o.showmode = false
-- 命令行高为0，输入命令时才占用位置
vim.o.cmdheight = 0
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
vim.opt.wrap = false
-- 行结尾可以跳到下一行
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- 鼠标支持
vim.o.mouse = "a"
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- smaller updatetime
vim.o.updatetime = 300
-- 等待mappings
vim.o.timeoutlen = 700
vim.opt.ttimeoutlen = 0
-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true
-- 样式(开启真彩色，防止在gui和终端下颜色不同（大概不需要?）)
vim.opt.termguicolors = true
-- 补全增强
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.pumheight = 10

vim.opt.showtabline = 0

-- remember the last edit cursor
vim.cmd([[
  augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]])
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = general,
  desc = "Disable New Line Comment",
})
