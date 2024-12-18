return {
    {
        "windwp/nvim-autopairs",
        config=function()
            local handlers = require('nvim-autopairs.completion.handlers')
            -- If you want insert `(` after select function or method item
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if cmp_status_ok then
              local cmp_autopairs = require("nvim-autopairs.completion.cmp")
              cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done(
                {
                  filetypes = {
                    css = {
                      ["{"] = {
                        kind = {
                          cmp.lsp.CompletionItemKind.Function,
                          cmp.lsp.CompletionItemKind.Method
                        },
                        handler = handlers["*"]
                      }
                    }
                  },
                  map_char = { tex = "" }
                }))
            end
            return {
                check_ts = true,
                ts_config = {
                  lua = { "string", "source" }, -- it will not add a pair on that treesitter node
                  javascript = { "template_string" },
                  java = false,                 -- don't check treesitter on java
                },
                disable_filetype = { "TelescopePrompt" },
            }
        end
    }
}
