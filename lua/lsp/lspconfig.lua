local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end


local servers = {
  "lua_ls",
  "tsserver",
  "pyright",
  "html",

}

local isOk, handler = pcall(require, "lsp.handlers")
if not isOk then
  return
end
handler.setup()

local opts = {}
for key, serverName in pairs(servers) do
  opts = {
    on_attach = handler.on_attach,
    capabilities = handler.capabilities,
  }

  -- maybe serverName is "username@servername"
  serverName = vim.split(serverName, "@")[1]

  local isSet, server_conf = pcall(require, "lsp.server-settings." .. serverName)
  if isSet then
    opts = vim.tbl_deep_extend("force", server_conf, opts)  -- merge two opts
  end
  lspconfig[serverName].setup(opts)
end
