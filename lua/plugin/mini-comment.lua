vim.pack.add({{ src = "git@github.com:nvim-mini/mini.comment"}}, { conform = false })
require("mini.comment").setup()

vim.keymap.set("n", "<c-_>", "gcc", { remap = true })
vim.keymap.set("v", "<c-_>", "gc", { remap = true })
-- return {
--   'nvim-mini/mini.comment',
--   version = false,
--   config = function()
--     require('mini.comment').setup()
--   end,
--   keys = {
--     { "<c-_>", "gcc", mode = { "n" }, remap = true },
--     { "<c-_>", "gc",  mode = { "v" }, remap = true },
--   },
-- }
