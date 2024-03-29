local null_ls = require("null-ls")
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    diagnostics.shellcheck,
    code_actions.shellcheck,
    formatting.black.with({
      args={"--line-length=120"}
    }),
  },
})
