M = {}

function M.git()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local head = git_info.head
  local added = git_info.added and ("+" .. git_info.added) or ""
  local changed = git_info.changed and ("~" .. git_info.changed) or ""
  local removed = git_info.removed and ("-" .. git_info.removed) or ""
  return table.concat({ " ", head, added, changed, removed, " " })
end

function M.active()
  -- `%P` shows the scroll percentage but says 'Bot', 'Top' and 'All' as well.
  return table.concat({
    "%#StatuslineFileName#", " %t", "%m ",
    "%#StatuslineGit#", M.git(),
    vim.diagnostic.status(),
    "%#StatuslineMiddle#",
    "%=",
    "%#StatuslineFileType#", " %y ",
    "%#StatuslinePercentage#", " %p%% ",
    "%#StatuslineLocation#", " %l:%c ", })
end

function M.inactive()
  return "%#StatuslineInactive# %t"
end
local group = vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = group,
  desc = "Activate statusline on focus",
  callback = function()
    vim.opt_local.statusline = "%!v:lua.M.active()"
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = group,
  desc = "Deactivate statusline when unfocused",
  callback = function()
    vim.opt_local.statusline = "%!v:lua.M.inactive()"
  end,
})
