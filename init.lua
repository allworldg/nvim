if vim.g.vscode then
	require("vscode")
else
require("base")
require("keybindings")
require("plugin")
require("highlight")
end
