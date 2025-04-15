-- save origin reference to 'messages'
vim.cmd([[
  if !exists(":OrigMessages")
    command! OrigMessages messages
  endif
]])

local win = nil

vim.api.nvim_create_user_command('Messages', function(params)
  local real_command = 'messages '
  if params.args ~= '' then
    real_command = real_command .. params.args
  end

  local messages = vim.split(vim.fn.execute(real_command), '\n', { trimempty = true })
  if #messages == 0 then
    return
  end
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
    win = nil
  end

  -- create window
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.2)
  local opts = {
    split = "below",
    width = width,
    height = height,
    style = 'minimal',
    -- relative = 'editor',
    -- col = (vim.o.columns - width) / 2,
    -- row = (vim.o.lines - height) / 2 - 1, -- Ajust position to avoid obstruction
    -- border = 'rounded',                   -- style：rounded/single/double/shadow/none
    -- title = '',
    -- title_pos = 'center'
  }

  win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, messages)
  vim.api.nvim_win_set_cursor(win, { #messages, 0 })
  vim.bo[buf].filetype = 'custom-messages' -- for lualine.nvim to disable this type
  vim.bo[buf].modifiable = false
  vim.api.nvim_set_option_value('number', true, { win = win })
  vim.api.nvim_buf_call(buf, function()
    -- highlight ErrorMsg
    vim.cmd('syntax match ErrorMsg /E.*/')
  end)

  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(win),
    once = true,
    callback = function()
      vim.api.nvim_buf_delete(buf, { force = true })
      win = nil
    end
  })
end, {
  nargs = '*',
  complete = function(_, _, _)
    return { 'clear' }
  end
})

-- replace default command :messages
vim.cmd([[
  cnoreabbrev <expr> messages getcmdtype() == ":" && getcmdline() ==# 'messages' ? 'Messages' : 'messages'
]])
