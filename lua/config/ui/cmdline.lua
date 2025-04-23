local M = {}
local log = require("config.ui.log")
local winid = nil
local bufid = nil
---@type vim.api.keyset.win_config
local win_config = {
  split = 'below',
  height = 1,
  width = vim.o.columns,
  style = 'minimal',
}
M.events = {
  ---@param content ([integer,string][])[]
  ---@param pos integer
  ---@param firstc ":" | "?" | "/" | "="
  ---@param prompt string
  ---@param indent integer
  ---@param level integer
  ---@param hl_id integer
  cmdline_show = function(content, pos, firstc, prompt, indent, level, hl_id)
    if buf==nil and winid == nil then
    end
  end,
  cmdline_pos = function(pos, level)
  end,
  cmdline_special_char = function(c, shift, level)
  end,
  cmdline_hide = function(abort)
  end,
  cmdline_block_show = function(lines) end,
  cmdline_block_append = function(line) end,
  cmdline_block_hide = function()
  end,
}
M.state = {

}

return M;
