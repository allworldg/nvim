return {
  "ibhagwan/fzf-lua",
  opts = {},
  keys = {
    {
      "<C-f>",
      function()
        require 'fzf-lua'.live_grep({
          winopts = {
            title = "",
            preview = {
              vertical = "down:60%",
              border = { "", "", "", "│", "", "", "", "│" },
            }
          }
        })
      end,
      desc = "live_grep"
    },
    {
      "<C-p>",
      function()
        require 'fzf-lua'.files({
          winopts = {
            title = "",
            preview = {
              hidden = true,
            }
          },
        })
      end,
      desc = "files"
    },
    {
      "gr",
      function()
        require 'fzf-lua'.lsp_references(
          {
            winopts = { relative = 'cursor' },
          }
        )
      end,
      nowait=true,
      desc = "lsp_references"
    },
    { "gi", function() require 'fzf-lua'.lsp_implementations() end,   desc = "lsp_implementations" },
    { "gd", function() require 'fzf-lua'.lsp_definitions() end,       desc = "lsp_definitions" },
    { "<leader>sw", function() require 'fzf-lua'.diagnostics_workspace() end, desc = "diagnostics_workspace" },
    { "<leader>sl", function() require 'fzf-lua'.diagnostics_document() end, desc = "diagnostics_workspace" },
    { "gD", function() require 'fzf-lua'.lsp_declarations() end,      desc = "lsp_declarations" },
  },
  config = function()
    require("fzf-lua").setup {
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
        backdrop = 100, --fully transparent
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
    }

    -- change highlight color to head, e.g:"<ctrl-g>" under the input area
    vim.cmd [[highlight FzfLuaHeaderBind guifg=#0969da]]
    -- change highlight color to head, e.g:"Fuzzy Search" under the input area
    vim.cmd [[highlight FzFLuaHeaderText guifg=#0969da]]
    -- vim.cmd [[highlight IncSearch guifg=#000000]]
    -- change highlight in live_grep user input text
    vim.cmd [[highlight  FzFLuaLivePrompt guifg=#000000 gui=bold]]
    vim.cmd [[highlight FzFLuaNormal guifg=#000000 guibg=#f6f8fa]]
    vim.cmd [[highlight FzfLuaPathLineNr guifg=#0550ae]]
  end
}
