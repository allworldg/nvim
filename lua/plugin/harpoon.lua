return {
  'ThePrimeagen/harpoon',
  dependencies = { { "nvim-lua/plenary.nvim" } },
  branch = "harpoon2",
  config = function()
    vim.keymap.set("n", "<A-p>", require("harpoon.ui").toggle_quick_menu, {})
    vim.keymap.set("n", "<A-a>", require("harpoon.mark").add_file, {})
    vim.keymap.set("n", "<c-h>", require("harpoon.ui").nav_prev, { silent = true })
    vim.keymap.set("n", "<c-l>", require("harpoon.ui").nav_next, { silent = true })
    require("harpoon").setup({
      tabline = true
    })
    vim.cmd('highlight! HarpoonInactive guibg=#ececec guifg=#63698c')
    vim.cmd('highlight! HarpoonActive guibg=whilte guifg=#000000')
    vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
    vim.cmd('highlight! HarpoonNumberInactive guibg=#ececec guifg=#7aa2f7')
    vim.cmd('highlight! TabLineFill guibg=#f3f3f3 guifg=white')
  end
}
