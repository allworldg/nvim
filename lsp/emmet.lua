vim.lsp.config.emmet = {
  cmd = { 'emmet-language-server', '--stdio' },
  filetypes = {
    'css',
    'eruby',
    'html',
    'vue',
    'htmldjango',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'typescriptreact',
    'htmlangular',
  },
  root_markers = { '.git' },
}
vim.lsp.enable("emmet", true)
