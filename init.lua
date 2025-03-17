-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({
        })
      end,
    },
  },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
------------------------------------baseConfig------------------
vim.cmd.colorscheme = ""
-- VSCode extension
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- jk移动时光标下上方保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
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
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- smaller updatetime

vim.o.updatetime = 300
-- 等待mappings
vim.o.timeoutlen = 700
vim.opt.clipboard = 'unnamedplus'
-- disable auto comment in new line
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = general,
  desc = "Disable New Line Comment",
})
-- vim.cmd([[
--     autocmd InsertEnter * call jobstart("C:\\Users\\allworldg\\im-select.exe 2052")
--     autocmd InsertLeave * call jobstart("C:\\Users\\allworldg\\im-select.exe 3081")
--   ]])
----------------------------------------------keybindings-----------
local ok, vscode = pcall(require, "vscode")

if not ok then
  vim.notify("vscode not found")
  return
end
local opt = {
  noremap = true,
  silent = true,
}
-- quick select all
vim.keymap.set('n', '<leader>a', 'ggVG', opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
vim.keymap.set("n", "<c-u>", "10k", opt)
vim.keymap.set("n", "<c-d>", "10j", opt)
--visual模式下缩进代码
vim.keymap.set("v", "<", "<gv", opt)
vim.keymap.set("v", ">", ">gv", opt)
vim.keymap.set('v', "p", "P", {})
vim.keymap.set("n", "<leader>w", ":w<CR>", opt)

if vim.g.vscode then
  vim.keymap.set('n', "<leader>f", function() vscode.call('editor.action.formatDocument') end, {})
  vim.keymap.set('i', "<c-k>", function() vscode.call('editor.action.triggerParameterHints') end, {})
  vim.keymap.set('n', "<leader>bo", function() vscode.call('workbench.action.closeOtherEditors') end, {})
  vim.keymap.set('n', "<leader>se", function() vscode.call('editor.action.showHover') end, {})
  vim.keymap.set('n', "<leader>rn", function() vscode.call('editor.action.rename') end, {})
  vim.keymap.set('n', "<leader>h", function() vscode.call('workbench.action.navigateLeft') end, {})
  vim.keymap.set('n', "<leader>l", function() vscode.call("workbench.action.navigateRight") end, {})
  vim.keymap.set('n', "K", function() vscode.call('editor.action.showHover') end, {})
  vim.keymap.set('n', "qq", function() vscode.call("workbench.action.closeActiveEditor") end, {})
  vim.keymap.set('n', 'gd', function() vscode.call("editor.action.revealDefinition") end, {})
  vim.keymap.set('n', 'gr', function() vscode.call("editor.action.goToReferences") end, {})
  vim.keymap.set('n', "gi", function() vscode.call("editor.action.goToImplementation") end, {})
  vim.keymap.set('n', 'zM', function() vscode.call("editor.foldAll") end, { noremap = true, silent = true })
  vim.keymap.set('n', 'zR', function() vscode.call("editor.unfoldAll") end, { noremap = true, silent = true })
  vim.keymap.set('n', 'zc', function() vscode.call("editor.fold") end, { noremap = true, silent = true })
  vim.keymap.set('n', 'zC', function() vscode.call("editor.foldRecursively") end, { noremap = true, silent = true })
  vim.keymap.set('n', 'zo', function() vscode.call("editor.unfold") end, { noremap = true, silent = true })
  vim.keymap.set('n', 'zO', function() vscode.call("editor.unfoldRecursively") end, { noremap = true, silent = true })
  vim.keymap.set('n', 'za', function() vscode.call("editor.toggleFold") end, { noremap = true, silent = true })
end
