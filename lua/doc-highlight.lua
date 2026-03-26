--- *Doc-Highlight* enhance LSP DocumentHighlight
---
--- Apache License

--- Features:
--- - DocumentHighlight(illuminate) by LSP, reduce lsp request times and highlight flicker.
---
--- - The main process is achieved by these two steps :
---   - send "textDocument/documentHighlight" request to LSP, get the highlight ranges
---   - use vim.api.nvim_buf_set_extmark to highlight these ranges
---
--- What it doesn't do:
--- - cannot highlight by using regex or Tree-sitter, only support LSP
---
--- # Setup ~
---
--- This module needs a setup with `require('doc-highlight').setup()`.
--- Use `vim.api.nvim_set_hl(0,'DocHighlight',{bg=xxx,fg=xxx})` to set highlight color
---
---@tag doc-highlight

local M = {}
local H = {}

H.ranges = {}
H.current_range = {}
H.request_id = 0
H.bufnr = vim.api.nvim_get_current_buf()
H.timer = vim.uv.new_timer()
H.cancel_fn = nil
H.ns_id = vim.api.nvim_create_namespace("allworldg/doc-highlight")

--- Module setup
---@usage >lua
--- require("doc-highlight").setup()
--- <
M.setup = function()
  H.timer = vim.uv.new_timer()
  local group = vim.api.nvim_create_augroup("allworldg/doc-highlight", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(event)
      if vim.b[event.buf].canHighlight ~= nil then return end
      vim.b[event.buf].canHighlight = H.check_capability(event.buf, "textDocument/documentHighlight")
    end
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "TextChanged", "TextChangedI" }, {
    group = group,
    callback = function(event)
      if vim.b[event.buf].canHighlight ~= true then
        return
      end
      if not vim.tbl_isempty(H.ranges) then
        if event.event == "TextChanged"
            or event.event == "TextChangedI"
            or H.bufnr ~= event.buf
            or not H.is_in_any_range(H.get_cursor_pos(), H.ranges) then
          H.clearHighlight(H.bufnr)
        else
          return
        end
      end
      H.bufnr = event.buf
      H.request_id = H.update_id(H.request_id)
      H.highlight(event.buf, H.request_id)
    end
  })
end

---update id for version control
---@param id integer
---@return integer
H.update_id = function(id)
  if id == 1e9 then
    id = 0
  end
  id = id + 1
  return id
end

---the core implementation
---@param bufnr integer
---@param id integer
H.highlight = function(bufnr, id)
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

      H.apply_highlight(bufnr, H.ranges)
      -- should render the latest ranges
    end)
  H.cancel_fn = cancel_fn
end

---highlight the ranges
---@param bufnr integer
---@param ranges table
H.apply_highlight = function(bufnr, ranges)
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

---check if the postion is in the range
---@param pos table<integer>
---@param range table<integer>
---@return boolean
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



---check if the postion is in any ranges
---@param pos table<integer>
---@param ranges table
---@return boolean
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

---@return table
H.get_cursor_pos = function()
  local pos = vim.api.nvim_win_get_cursor(0);
  -- the pos is (1,0)-indexed
  return { pos[1] - 1, pos[2] }
end

---clear current highlights
---@param bufnr integer
H.clearHighlight = function(bufnr)
  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_clear_namespace(bufnr, H.ns_id, 0, -1)
  end
  H.ranges = {}
  H.current_range = {}
end

---@param bufnr integer
---@param capability string
---@return boolean
H.check_capability = function(bufnr, capability)
  local client = vim.lsp.get_clients({ bufnr = bufnr, method = capability })
  return #client ~= 0
end

return M
