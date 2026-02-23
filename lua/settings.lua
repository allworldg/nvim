vim.opt.clipboard = "unnamedplus"
-- jk移动时光标上下左右保留8个
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.opt.number = true
vim.opt.signcolumn = "no"
vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"
-- lineNr左侧图标指示列
vim.opt.winblend = 0
-- 1 tab == 2 blackspace
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
-- >> << 时移动长度
vim.opt.shiftwidth = 2
-- 新行对齐当前行，空格替代tab
vim.opt.expandtab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- search ignore case except have capital word
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- do not highlight except the incsearch result
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.showmode = false
vim.opt.cmdheight = 1
-- 当文件被外部程序修改时，自动加载
vim.opt.autoread = true
vim.opt.wrap = false
vim.opt.whichwrap = 'b,s,<,>,[,],h,l'
-- allow hidden the written buffer
vim.opt.hidden = true
-- enable mouse
vim.opt.mouse = "a"
-- do not create backup file
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
-- smaller updatetime
vim.opt.updatetime = 300
-- the keymap wait time
vim.opt.timeoutlen = 700
vim.opt.ttimeoutlen = 0
-- the location split window will set
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.termguicolors = true
vim.opt.shortmess:append('c')
vim.o.pumheight = 10
vim.opt.showtabline = 1


local group = vim.api.nvim_create_augroup('allworldg/settings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  callback = function(args)
    if args.match == 'text' then
      vim.wo.wrap = true
      vim.wo.linebreak = true
    end
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

require('vim._core.ui2').enable({
  enable = true, -- Whether to enable or disable the UI.
  msg = {        -- Options related to the message module.
    ---@type 'cmd'|'msg' Where to place regular messages, either in the
    ---cmdline or in a separate ephemeral message window.
    target = 'cmd',
    timeout = 4000, -- Time a message is visible in the message window.
  },
})
