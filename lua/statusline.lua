local M = {}

M.disabled_filetypes = { 'NvimTree' }

function M.git()
  local git_info = vim.b.gitinfo or {}
  if not git_info or git_info.branch == "" then
    return ""
  end
  local branch = git_info.branch
  return table.concat({ " ", branch, " " })
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

function M.is_disabled_statusline()
  if vim.api.nvim_win_get_config(0).relative ~= "" then
    -- print("yes will be disalbed") //todo
    return true
  end
  for _, filetype in pairs(M.disabled_filetypes) do
    if vim.bo.filetype == filetype then
      return true
    end
  end
  return false
end

function M.getGitBranch(bufnr)
  coroutine.wrap(function()
    local running_co = coroutine.running()
    vim.system({ "git", "branch", "--show-current" }, { text = true }, function(res)
      local out = (res.code == 0 and res.stdout) and vim.trim(res.stdout) or nil
      ---@diagnostic disable-next-line: param-type-mismatch
      coroutine.resume(running_co, out)
    end)
    local branch = coroutine.yield()
    if not branch or branch == "" then
      vim.system({ "git", "rev-parse", "--short", "HEAD" }, { text = true }, function(res)
        local out = (res.code == 0 and res.stdout) and vim.trim(res.stdout) or ""
        ---@diagnostic disable-next-line: param-type-mismatch
        coroutine.resume(running_co, out)
      end)
      branch = coroutine.yield()
    end
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        local gitinfo = vim.b[bufnr].gitinfo or {}
        gitinfo.branch =branch
        vim.b[bufnr].gitinfo = gitinfo
        vim.cmd("redrawstatus")
      end
    end)
  end)()
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = group,
  desc = "Activate statusline on focus",
  callback = function()
    if M.is_disabled_statusline() then
      vim.opt_local.statusline = " "
      return
    end
    vim.opt_local.statusline = "%!v:lua.require'statusline'.active()"
  end,
})


vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = group,
  desc = "Deactivate statusline when unfocused",
  callback = function()
    if M.is_disabled_statusline() then
      vim.opt_local.statusline = "%#StatuslineDisabled#"
      return
    end
    vim.opt_local.statusline = "%!v:lua.require'statusline'.inactive()"
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = group,
  desc = "get git status",
  callback = function(event)
    M.getGitBranch(event.buf)
  end
})
return M
