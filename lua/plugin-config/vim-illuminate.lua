local ok, illuminate = pcall(require, "illuminate")

if not ok then
  vim.notify("vim-illuminate not found")
  return
end

illuminate.configure({
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  -- delay: delay in milliseconds
  delay = 100,
  filetype_overrides = {},
  filetypes_denylist = {
    -- 'html',
    'dirvish',
    'fugitive',
  },
  under_cursor = false,
  large_file_cutoff = nil,
  large_file_overrides = nil,
  min_count_to_highlight = 1,
})
vim.cmd[[
  highlight  IlluminatedWordWrite guibg=#FCE8F4 gui= none "declaration
  highlight  IlluminatedWordRead guibg=#EDEBFC gui = none "reference
]]
