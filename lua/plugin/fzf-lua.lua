return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  opts = {},
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
        hidden = true,
      },
      grep = {
        hidden = true,
        no_ignore = false,
      },
    }
    local profile_files = {
      winopts = {
        preview = {
          hidden = true
        }
      },
    }
    local profile_live_grep = {
      winopts = {
        preview = {
          vertical = "down:60%",
          border = { "", "", "", "│", "", "", "", "│" },
        }
      }
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



    local opt = {
      silent = true,
      noremap = true,
    }
    vim.keymap.set("n", "<C-f>", function() require 'fzf-lua'.live_grep(profile_live_grep) end, opt)
    vim.keymap.set("n", "<C-p>", function() require 'fzf-lua'.files(profile_files) end, opt)
    vim.keymap.set("n", "gr", function() require 'fzf-lua'.lsp_references({ winopts = { relative = 'cursor' } }) end, opt)
    vim.keymap.set("n", "gi", function() require 'fzf-lua'.lsp_implementations({ jump_to_single_result = true }) end, opt)
    vim.keymap.set("n", "gd", ":lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>", opt)
    vim.keymap.set("n", "sl", function() require 'fzf-lua'.diagnostics_workspace({}) end, opt)
    vim.keymap.set("n", "gD", ":FzfLua lsp_declarations<CR>", opt)
  end
}
