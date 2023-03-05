local status,mason_lspconfig = pcall(require,"mason-lspconfig")
if not status then
  vim.notify("not found mason-lspconfig")
end


local servers = {
  "lua_ls",
  "tsserver",
}

mason_lspconfig.setup({
  ensure_installed = servers,
})

