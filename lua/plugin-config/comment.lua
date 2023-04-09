local status, comment = pcall(require, "Comment")
if not status then
  vim.notify("can not find Comment")
  return
end

comment.setup({{}})

-- ctrl + /
vim.api.nvim_set_keymap("n", "<c-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<c-_>", "gc", { noremap = false })
