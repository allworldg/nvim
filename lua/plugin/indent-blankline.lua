return {
  "lukas-reineke/indent-blankline.nvim",
  cond = false,
  main = "ibl",
  config = function()
    require("ibl").setup {
      -- indent = {
      --   highlight = {
      --     "CursorColumn",
      --     "Whitespace",
      --   }
      -- },
      -- scope = { enabled = false },
      -- whitespace = {
      --   highlight = {
      --     "Whitespace",
      --   },
      --   remove_blankline_trail = true,
      -- },
    }
  end
}
