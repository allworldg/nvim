local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local servers = {
  "lua_ls",
  "tsserver",
}

for key, serverName in pairs(servers) do
  opts = {
    on_attach = nil,
    capabilities = nil,
  }

  -- maybe serverName is "username@servername"
  serverName = vim.split(server, "@")[1]

  local isSet, server_conf = pcall(require, "lsp.server-settings." .. serverName)
  if isSet then
    opts = vim.tbl_deep_extend("force", server_conf, opts) -- merge two opts
  end
  lspconfig[serverName].setup(opts)
end






------------------------before-------------------------
local config = {
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single",
})
-- keymappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>se', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>gp', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>gn', vim.diagnostic.goto_next, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}


-- Lsp Config
local nvim_lsp = require('lspconfig')
local servers = { 'tsserver', 'pyright', 'clangd', 'sumneko_lua', 'quick_lint_js', 'html' }
for _, server in ipairs(servers) do
  nvim_lsp[server].setup {
    on_attach = on_attach,
    flags = lsp_flags,
  }
end
