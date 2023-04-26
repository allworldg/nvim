local ok,harpoon=pcall(require,"harpoon")
if not ok then
  vim.notify("not find harpoon")
  return
end

harpoon.setup({
  
})
vim.keymap.set("n","<leader>hl",require("harpoon.ui").toggle_quick_menu,{})
vim.keymap.set("n","<leader>ha",require("harpoon.mark").add_file,{})
vim.keymap.set("n","<c-h>",require("harpoon.ui").nav_prev,{silent=true})
vim.keymap.set("n","<c-l>",require("harpoon.ui").nav_next,{silent=true})
