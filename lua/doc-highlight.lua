local M = {}
local H = {}

H.ranges = {}
H.current_range = {}
H.request_id = 0
H.bufnr = vim.api.nvim_get_current_buf()
H.timer = vim.uv.new_timer()
H.cancel_fn = nil

H.ns_id = vim.api.nvim_create_namespace("allworldg/doc-highlight")

M.setup = function()
  H.timer = vim.uv.new_timer()
  local group = vim.api.nvim_create_augroup("allworldg/doc-highlight", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter", "TextChanged", "TextChangedI" }, {
    group = group,
    callback = function(event)
      if vim.tbl_isempty(H.ranges) then
        if event.event == "TextChanged" or event.event == "TextChangedI" or H.bufnr ~= event.buf or not H.is_in_any_range(H.get_cursor_pos(), H.ranges) then
          H.clearHighlight(H.bufnr)
        end
      end

      H.bufnr = event.buf
      H.request_id = H.update_id(H.request_id)
      H.get_highlight_refers(event.buf, H.request_id)
      vim.uv.timer_start(H.timer, 200, 0,
        vim.schedule_wrap(function()
          if vim.uv.is_active(H.timer) then
            vim.uv.timer_stop(H.timer)
          end
          H.highlight(event.buf, H.ranges)
        end)
      )
    end
  })
end

H.update_id = function(id)
  if id == 1e9 then
    id = 0
  end
  id = id + 1
  return id
end

H.has_highlight = function(ranges)
  return vim.tbl_isempty(ranges)
end


H.get_highlight_refers = function(bufnr, id)
  if H.cancel_fn ~= nil then
    pcall(H.cancel_fn)
  end
  local winid = vim.api.nvim_get_current_win()
  local params = function(client)
    return vim.lsp.util.make_position_params(winid, client.offset_encoding)
  end

  local cancel_fn = vim.lsp.buf_request_all(bufnr, 'textDocument/documentHighlight', params,
    function(results, context, config)
      if bufnr ~= H.bufnr or H.request_id ~= id then
        return
      end

      for client_id, resultObj in pairs(results) do
        local result = resultObj["result"]
        if result == nil then return end
        local ranges = {}
        for _, res in ipairs(result) do
          table.insert(ranges, res)
        end
        H.ranges = ranges
      end

      -- should render the latest ranges
      H.is_rendered = false
    end)
  H.cancel_fn = cancel_fn
end

H.highlight = function(bufnr, ranges)
  for _, range in ipairs(ranges) do
    vim.api.nvim_buf_set_extmark(bufnr, H.ns_id, range["range"]["start"]["line"],
      range["range"]["start"]["character"],
      {
        end_line = range["range"]["end"]["line"],
        end_col = range["range"]["end"]["character"],
        hl_group = "DocHighlight",
      })
  end
end

H.is_in_range = function(pos, range)
  if vim.tbl_isempty(range) then
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
  if not vim.tbl_isempty(H.current_range) and H.is_in_range(pos, H.current_range.range) then
    return true
  else
    for _, range in ipairs(ranges) do
      if H.is_in_range(pos, range.range) then
        H.current_range = range
        return true
      end
    end
    return false
  end
end

H.get_cursor_pos = function()
  local pos = vim.api.nvim_win_get_cursor(0);
  -- the pos is (1,0)-indexed
  return { pos[1] - 1, pos[2] }
end
H.clearHighlight = function(bufnr)
  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_clear_namespace(bufnr, H.ns_id, 0, -1)
  end
  H.ranges = {}
  H.current_range = {}
  H.is_rendered = false
end

return M
