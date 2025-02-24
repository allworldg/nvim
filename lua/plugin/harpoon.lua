vim.keymap.set("n", "<A-p>", function() require("harpoon.ui").toggle_quick_menu() end, {})
vim.keymap.set("n", "<A-a>", function() require("harpoon.mark").add_file() end, {})
vim.keymap.set("n", "<c-h>", function() require("harpoon.ui").nav_prev() end, { silent = true })
vim.keymap.set("n", "<c-l>", function() require("harpoon.ui").nav_next() end, { silent = true })
return {
  'ThePrimeagen/harpoon',
  dependencies = { { "nvim-lua/plenary.nvim" } },
  cond = true,
  lazy = true,
  branch = "harpoon2",
  config = function()
    require("harpoon").setup({
      tabline = true
    })
    vim.cmd('highlight! HarpoonInactive guibg=#ececec guifg=#63698c')
    vim.cmd('highlight! HarpoonActive guibg=#ffffff guifg=#000000')
    vim.cmd('highlight! HarpoonNumberActive guibg=#ffffff guifg=#000000')
    vim.cmd('highlight! HarpoonNumberInactive guibg=#ececec guifg=#000000')
    vim.cmd('highlight! TabLineFill guibg=#f3f3f3 guifg=white')
  end
}
