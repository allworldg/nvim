local ok,_ = pcall(require,"lspconfig")
if not ok then
  vim.notify("lspconfig not found ")
end

require "lsp.lspconfig"
require "lsp.handlers"
