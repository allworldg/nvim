vim.api.nvim_create_autocmd("PackChanged",
  {
    group = vim.api.nvim_create_augroup("allworldg/pack", {
      clear = true,
    }),
    callback = function(event)
      local name, kind = event.data.spec.name, event.data.kind
      if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
        vim.cmd("TSUpdate")
      end
    end
  }
)

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup("allworldg/treesitter", { clear = true }),
  callback = function(event)
    local bufnr = event.buf
    if vim.bo[bufnr].buftype ~= "" then return end
    if vim.bo[bufnr].filetype ~= "bigfile" and vim.treesitter.language.add(vim.bo[bufnr].filetype) then
      pcall(vim.treesitter.start, bufnr)
    end
  end,
})
