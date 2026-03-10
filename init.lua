vim.cmd.colorscheme('allworldg-light')
require("settings")
require("keymap")
require("lsp")
require("statusline")
require("tabline")
require("commands")
require("autocmds")

--plugin manager
local pluginNames = vim.iter(vim.api.nvim_get_runtime_file("lua/plugin/*.lua", true)):each(
  function(filePath)
     local requireName = "plugin/" .. vim.fn.fnamemodify(filePath, ":t:r")
     local ok,error = pcall(require,requireName)
     if not ok then 
       print(vim.inspect(error))
     end
  end
)
