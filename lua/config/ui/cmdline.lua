local M = {}
local log = require("config.ui.log")
M.events = {
  ---@param content ([integer,string][])[]
  ---@param pos integer
  ---@param firstc ":" | "?" | "/" | "="
  ---@param prompt string
  ---@param indent integer
  ---@param level integer
  ---@param hl_id integer
  cmdline_show = function(content, pos, firstc, prompt, indent, level, hl_id)
    log.set_logData(content[1][2])
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

local winid = nil
local bufid = nil
