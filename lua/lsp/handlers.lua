local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- add some supported capabilities by nvim-cmp
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)


M.setup = function()
  local config = {
    -- disable virtual text
    virtual_text = true,
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
end




local function lsp_keymap(bufnr)
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<space>se', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>gp', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>gn', vim.diagnostic.goto_next, opts)
  -- Enable completion triggered by <c-x><c-o>
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
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts) use same keybinding by telescople.references
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

--------------- binding keymaps
M.on_attach = function(client, bufnr)
  -- if client.name == "tsserver" then
  -- 	client.server_capabilities.documentFormattingProvider = false
  -- end

  -- if client.name == "" then
  -- 	client.server_capabilities.documentFormattingProvider = false
  -- end

  lsp_keymap(bufnr)
  -- local status_ok, illuminate = pcall(require, "illuminate")
  -- if not status_ok then
  -- 	return
  -- end
  -- illuminate.on_attach(client)
end

return M
