local lsp_path = vim.fn.stdpath("config") .. "/lua/config/lsp"
---@param file string
for _, file in ipairs(vim.fn.readdir(lsp_path)) do
  if file:match("%.lua$") and file ~= "init.lua" then
    local module_name = "config.lsp." .. file:gsub("%.lua$", "")
    require(module_name)
  end
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
  return signature_help({
    border = "single",
  })
end

local hover_help = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover_help({
    border = "single"
  })
end

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = ""
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    }
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "single",
    source = true,
    header = "",
    prefix = "",
  },
})
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local bufnr = event.buf
    local opts = { buffer = bufnr }
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    vim.keymap.set('n', '<leader>se', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>k', function()
      vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = vim.api.nvim_create_augroup("virtual-lines", { clear = true }),
        callback = function()
          vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
          return true
        end
      })
    end, opts)

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- use by other tools
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) -- use by other tools
    -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    --use same keybinding by fzflua.references
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- use conform.nvim to format
    -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  end
})
