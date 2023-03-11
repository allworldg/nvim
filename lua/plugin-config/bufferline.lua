local ok, bufferline = pcall(require, "bufferline")
if not ok then
  vim.notify("bufferline not found")
  return
end


vim.keymap.set({'n','i'},'<C-h>','<cmd>BufferLineCyclePrev<cr>')
vim.keymap.set({'n','i'},'<C-l>','<cmd>BufferLineCycleNext<cr>')
local opt = {
  noremap = true,
  silent = true,
}
-- "moll/vim-bbye" 关闭当前 buffer
vim.api.nvim_set_keymap("n", "<C-w>", ":bdelete!<cr>", opt)
-- 关闭左/右侧标签页
vim.api.nvim_set_keymap("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
vim.api.nvim_set_keymap("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)


bufferline.setup {
  options = {
    number = "none",
    close_command = "bdelete! %d",
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = false, -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    offsets = { { filetype = "NvimTree", text = "", padding = 0 } },
    separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
  highlights = {
    buffer_selected = {
      italic = false,
    }
  }
}

vim.cmd [[
  highlight BufferLineBackGround guibg = #EAEAEA
  highlight BufferLineCloseButton guibg = #EAEAEA
]]
