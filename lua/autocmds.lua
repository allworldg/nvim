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
