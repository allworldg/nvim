local M = {}
local H = {}

H.state = {
  ns = vim.api.nvim_create_namespace("allworldg/doc_highlight"),
  current_range = nil,
  ranges = {},
  bufnr = nil,
  timer = nil,
}

M.setup = function()
  local group = vim.api.nvim_create_augroup("allworldg/doc_highlight", { clear = true })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    callback = function(event)
    end
  })
  vim.api.nvim_create_autocmd("CursorHold", {
    group = group,
    callback = function(event)
      if H.state.bufnr == nil then
        M.highlight(event.buf)
        return
      end
      if H.state.bufnr ~= event.buf then
        H.clearHighlight(H.state.bufnr)
      elseif H.is_in_any_range(H.get_cursor_pos(), H.state.ranges) then
        return
      end
      H.clearHighlight(event.buf)
      M.highlight(event.buf)
    end
  })
end


M.highlight = function(bufnr)
  H.state.ranges = {}
  --highlight
  H.state.bufnr = bufnr

  local winid = vim.api.nvim_get_current_win()
  local params = function(client)
    return vim.lsp.util.make_position_params(winid, client.offset_encoding)
  end
  local cancel = vim.lsp.buf_request_all(bufnr, 'textDocument/documentHighlight', params,
    function(results, _, _)
      for client_id, resultObj in ipairs(results) do
        local result = resultObj["result"]
        if result == nil then return end
        for _, res in ipairs(result) do
          table.insert(H.state.ranges, res)
        end
      end

      vim.api.nvim_buf_clear_namespace(bufnr, H.state.ns, 0, -1)

      for _, range in ipairs(H.state.ranges) do
        vim.api.nvim_buf_set_extmark(bufnr, H.state.ns, range["range"]["start"]["line"],
          range["range"]["start"]["character"],
          {
            end_line = range["range"]["end"]["line"],
            end_col = range["range"]["end"]["character"],
            hl_group = "Visual",
          })
      end
    end)
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
  vim.api.nvim_buf_clear_namespace(bufnr, H.state.ns, 0, -1)
  H.state.ranges = {}
  H.state.current_range = nil
  H.state.bufnr = nil
end







return M
