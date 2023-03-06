local ok, bufferline = pcall(require, "bufferline")
if not ok then
  vim.notify("bufferline not found")
  return
end

bufferline.setup {
  options = {
    number = "none",
    close_command = "bdelete! %d",
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = false, -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    offsets = { { filetype = "NvimTree", text = "", padding = 0 } },
    separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
  highlights = {
    buffer_selected = {
      italic = false,
    }
  }
}

vim.cmd [[
  highlight BufferLineBackGround guibg = #EAEAEA
  highlight BufferLineCloseButton guibg = #EAEAEA
]]
