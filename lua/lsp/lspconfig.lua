-- local signs = {
--   { name = "DiagnosticSignError", text = "" },
--   { name = "DiagnosticSignWarn", text = "" },
--   { name = "DiagnosticSignHint", text = "" },
--   { name = "DiagnosticSignInfo", text = "" },
-- }

vim.cmd [[
  highlight DiagnosticSignInfo  guifg = Black
  highlight DiagnosticSignWarn  guifg = #C4A65E 
  highlight DiagnosticSignError guifg = Red

  highlight DiagnosticUnderlineWarn cterm = underline gui = underline guifg = Grey guibg = White
  highlight DiagnosticUnderlineHint cterm = underline gui = underline guifg = Grey guibg = White
  highlight DiagnosticUnderlineInfo cterm = underline gui = underline guifg = Grey guibg = White
  highlight DiagnosticUnderlineError cterm = underline gui = underline guifg = Red guibg = White

  highlight DiagnosticFloatingHint guifg = Black guibg = #F7F7F7 ctermfg = Black ctermbg = White
  highlight DiagnosticFloatingWarn guifg = Black guibg = White ctermfg = Black ctermbg = White
  highlight DiagnosticFloatingError guifg = Red guibg = white ctermfg = Red ctermbg = Black
  highlight diagnosticfloatingInfo guifg = Black guibg = white ctermfg = Black ctermbg = White



]]


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
