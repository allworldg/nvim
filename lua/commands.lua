vim.api.nvim_create_user_command("PackList", function(args)
  ---@diagnostic disable-next-line: param-type-mismatch
  local namelist = vim.iter(vim.pack.get()):map(function(plugin)
    return plugin.spec.name
  end):totable()
  print(vim.inspect(namelist))
end, {})
