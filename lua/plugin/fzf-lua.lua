vim.pack.add({ "git@github.com:ibhagwan/fzf-lua.git" }, { conform = false })
require("fzf-lua").setup({
  fzf_colors = {
    ["bg+"] = { "bg", "CursorLine" }, -- the horizontal one.
    ["fg+"] = { "fg", "Normal" },     -- the Normal of horizontal one.
    ["gutter"] = { "bg", "Normal" },  -- the vertical one.
    ["hl"] = "#0550ae:bold",
    ["hl+"] = "#0550ae:bold"
  },
  winopts = {
    height = 1,
    fullscreen = false,
    backdrop = 100, --completely transparent
    title_flags = false,
    preview = {
      title = false,
      layout = "vertical"
    }
  },
  keymap = {
    builtin = {
      ["<C-j>"] = "preview-down",
      ["<C-k>"] = "preview-up",
    },
  },
  files = {
    cwd_prompt = false,
    no_ignore = false,
    hidden = true
  },
  grep = {
    hidden = true,
    no_ignore = false,
  },

})
vim.keymap.set('n', "<C-f>", function()
  require 'fzf-lua'.live_grep({
    winopts = {
      title = "",
      preview = {
        vertical = "down:60%",
        border = { "", "", "", "│", "", "", "", "│" },
      }
    }
  })
end, {})
vim.keymap.set("n", "<C-p>", function()
  require 'fzf-lua'.files({
    winopts = {
      title = "",
      preview = {
        hidden = true,
      }
    },
  })
end)
vim.keymap.set("n", "gr",
  function()
    require 'fzf-lua'.lsp_references(
      {
        winopts = {
          height = 0.6,
          relative = 'cursor',
          preview = { layout = 'horizontal', horizontal = "left:50%" }
        },
      }
    )
  end,
  {
    nowait = true
  }
)

vim.keymap.set("n", "gi", function() require 'fzf-lua'.lsp_implementations() end)
vim.keymap.set("n", "gd", function() require 'fzf-lua'.lsp_definitions() end)
vim.keymap.set("n", "<leader>sw", function() require 'fzf-lua'.diagnostics_workspace() end)
vim.keymap.set("n", "<leader>sD", function() require 'fzf-lua'.diagnostics_document() end)
vim.keymap.set("n", "gD", function() require 'fzf-lua'.lsp_declarations() end)

