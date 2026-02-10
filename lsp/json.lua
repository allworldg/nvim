vim.lsp.config.jsonls = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git', "tsconfig.json", "package.json", "jsconfig.json" },
}
vim.lsp.enable('jsonls', true)
