local mason_registry = require("mason-registry")
local vue_language_server = mason_registry.get_package("vue-language-server"):get_install_path() ..
    "/node_modules/@vue/language-server"
vim.lsp.config.ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { "vue", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = {
    "tsconfig.json", "package.json", "jsconfig.json", ".git"
  },
  init_options = {
    hostInfo = 'neovim',
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_server,
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
}
vim.lsp.enable("ts_ls", false)
