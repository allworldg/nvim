vim.pack.add({ 'git@github.com:nvim-mini/mini.files.git' }, { confirm = false })
require('mini.files').setup()

local MiniFiles = require('mini.files')

local minifiles_toggle = function()
  if not MiniFiles.close() then MiniFiles.open() end
end

vim.keymap.set("n", "<A-m>",
  function()
    if not MiniFiles.close() then
      MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      MiniFiles.reveal_cwd()
    end
  end,
  { silent = true })
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesExplorerOpen',
  group = vim.api.nvim_create_augroup("minifilesKeymap", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "<C-o>", "<cmd>lua MiniFiles.close()<CR><C-o>",
      { buf = args.buf, desc = "close minifiles and jump back" })
  end
})
