local M = {}
local log = require("config.ui.log")
M.events = {
  ---@param kind string
  ---@param content [integer,string,integer][]
  ---@param replace_last boolean
  ---@param history boolean
  msg_show = function(kind, content, replace_last, history)
  end,

  msg_clear = function() end,
  msg_showmode = function(content) end,
  msg_showcmd = function(content) end,
  msg_ruler = function(content) end,
  msg_history_show = function(entries) end,
  msg_history_clear = function() end,
}
return M
