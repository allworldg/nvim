return {
  'nvim-mini/mini.comment',
  version = false,
  config = function()
    require('mini.comment').setup()
  end,
  keys = {
    { "<c-_>", "gcc", mode = { "n" }, remap = true },
    { "<c-_>", "gc",  mode = { "v" }, remap = true },
  },
}
