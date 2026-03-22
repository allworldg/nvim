local M = {}
local H = {}

H.state = {
  ns            = nil,
  current_range = nil,
  ranges        = {},
  bufnr         = nil,
  timer         = nil,
  cancel_fn     = nil,
  request_id    = 0,
}

M.setup = function()
  H.state.ns = vim.api.nvim_create_namespace("allworldg/doc_highlight")
  H.state.timer = vim.uv.new_timer()
  local group = vim.api.nvim_create_augroup("allworldg/doc_highlight", { clear = true })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    callback = function(event)
      local has_highlight = not vim.tbl_isempty(H.state.ranges)
      if has_highlight then
        if H.state.bufnr ~= event.buf or not H.is_in_any_range(H.get_cursor_pos(), H.state.ranges) then
          H.clearHighlight(H.state.bufnr)
        end
      end
      H.state.bufnr = event.buf
      H.get_highlight_refers(event.buf)
      -- todo: consider put this to bufenter or bufleave?
      vim.uv.timer_start(H.state.timer, 200, 0,
        vim.schedule_wrap(function()
          if vim.uv.is_active(H.state.timer) then
            vim.uv.timer_stop(H.state.timer)
          end
          M.highlight(event.buf)
        end)
      )
    end
  })
end


H.get_highlight_refers = function(bufnr)
  if H.state.cancel_fn ~= nil then
    pcall(H.state.cancel_fn)
  end
  local id = H.state.request_id + 1
  H.state.request_id = id
  local winid = vim.api.nvim_get_current_win()
  local params = function(client)
    return vim.lsp.util.make_position_params(winid, client.offset_encoding)
  end

  local cancel_fn = vim.lsp.buf_request_all(bufnr, 'textDocument/documentHighlight', params,
    function(results, context, config)
      if bufnr ~= H.state.bufnr or H.state.request_id ~= id then
        return
      end

      for client_id, resultObj in pairs(results) do
        local result = resultObj["result"]
        if result == nil then return end
        for _, res in ipairs(result) do
          table.insert(H.state.ranges, res)
        end
      end
      H.state.bufnr = bufnr
    end)
  H.state.cancel_fn = cancel_fn
end

M.highlight = function(bufnr)
  for _, range in ipairs(H.state.ranges) do
    local actual_col = vim.api.nvim_buf_get_lines(bufnr, range["range"]["start"]["line"],
      range["range"]["start"]["line"] + 1, false)[1]
    vim.api.nvim_buf_set_extmark(bufnr, H.state.ns, range["range"]["start"]["line"],
      range["range"]["start"]["character"],
      {
        end_line = range["range"]["end"]["line"],
        end_col = range["range"]["end"]["character"],
        hl_group = "Visual",
      })
  end
end

H.is_in_range = function(pos, range)
  if range == nil then
    return false
  end
  local line, col = pos[1], pos[2]
  if line < range.start.line or line > range["end"].line then
    return false
  elseif line == range.start.line and col < range["start"].character then
    return false
  elseif line == range["end"].line and col > range["end"].character then
    return false
  end
  return true
end


H.is_in_any_range = function(pos, ranges)
  if H.state.current_range and H.is_in_range(pos, H.state.current_range.range) then
    return true
  else
    for _, range in ipairs(ranges) do
      if H.is_in_range(pos, range.range) then
        H.state.current_range = range
        return true
      end
    end
    H.state.current_range = nil
    return false
  end
end

H.get_cursor_pos = function()
  local pos = vim.api.nvim_win_get_cursor(0);
  -- the pos is (1,0)-indexed
  return { pos[1] - 1, pos[2] }
end
H.clearHighlight = function(bufnr)
  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_clear_namespace(bufnr, H.state.ns, 0, -1)
  end
  H.state.ranges = {}
  H.state.current_range = nil
end

return M
