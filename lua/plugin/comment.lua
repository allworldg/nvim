return {
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      vim.api.nvim_set_keymap("n", "<c-_>", "gcc", { noremap = false })
      vim.api.nvim_set_keymap("v", "<c-_>", "gc", { noremap = false })
      require('Comment').setup()
    end

  }
}
