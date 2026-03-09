local group = vim.api.nvim_create_augroup("allworldg/commands", {
  clear = true
})

vim.api.nvim_create_user_command("PackList", function(args)
  local namelist = vim.iter(vim.pack.get()):map(function(plugin)
    return plugin.spec.name
  end):totable()
  print(vim.inspect(namelist))
end, {})
