return {
  {
    "numToStr/Comment.nvim",
    lazy = true,
    keys = {
      { "<c-_>", "gcc", mode = {"n"}, remap = true },
      { "<c-_>", "gc", mode = {"v"}, remap = true }
    },
    config = function()
      require('Comment').setup()
    end
  }
}
