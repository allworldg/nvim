local mason_registry = require("mason-registry")
local vue_language_server = mason_registry.get_package("vue-language-server"):get_install_path() ..
    "/node_modules/typescript/lib"
vim.lsp.config.volar = {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  root_markers = { "package.json" },
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = vue_language_server
    },
  },

}
vim.lsp.enable("volar")
