return {
  "ibhagwan/fzf-lua",
  -- cond = false,
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  opts = {},
  config = function()
    local actions = require("fzf-lua").actions
    require("fzf-lua").setup {
      fzf_colors = {
        ["bg+"] = { "bg", "CursorLine" }, -- the horizontal one.
        ["fg+"] = { "fg", "Normal" },     -- the Normal of horizontal one.
        ["gutter"] = { "bg", "Normal" },  -- the vertical one.
      },
      winopts = {
        fullscreen = true,
        backdrop = 100, --fully transparent
        preview = {
          title = false
        }
      },
      keymap = {
        fzf = {
        }
      },
      files = {
        cwd_prompt = false
      },
    }
  end
}
