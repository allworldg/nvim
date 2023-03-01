local status,mason_lspconfig = pcall(require,"mason-lspconfig")
if not status then
  vim.notify("not found mason-lspconfig")
end


mason_lspconfig.setup()
