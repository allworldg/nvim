require("config.ui.cmdline")

vim.api.nvim_create_autocmd("VimLeave", {
  group = vim.api.nvim_create_augroup("vimLeaveGroup", { clear = true }),
  callback = function()
    local log = require("config.ui.log")
    log.write()
  end
})

local modules = {
  cmdline = require("config.ui.cmdline"),
  message = require("config.ui.message")
}

local event_module_map = {
  cmdline_show = "cmdline",
  cmdline_pos = "cmdline",
  cmdline_special_char = "cmdline",
  cmdline_hide = "cmdline",
  cmdline_block_show = "cmdline",
  cmdline_block_app = "cmdline",
  cmdline_block_hide = "cmdline",

  msg_show = "message",
  msg_clear = "message",
  msg_showmode = "message",
  msg_showcmd = "message",
  msg_ruler = "message",
  msg_history_show = "message",
  msg_history_clear = "message",
}

local ui_ns = vim.api.nvim_create_namespace("ui_namespace")
vim.ui_attach(ui_ns, {  ext_cmdline = true }, function(event, ...)
  local moduleName = event_module_map[event]
  if not moduleName then return end
  pcall(modules[moduleName].events[event], ...)
end)
