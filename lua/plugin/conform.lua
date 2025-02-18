return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        vue = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" }

      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    }
    vim.keymap.set("n", "<leader>f", function() require("conform").format() end)
  end
}
