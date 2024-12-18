return{
    'ThePrimeagen/harpoon',
    dependencies = { {"nvim-lua/plenary.nvim"} },
    branch="harpoon2",
    config=function()
        vim.keymap.set("n", "<A-p>", require("harpoon.ui").toggle_quick_menu, {})
        vim.keymap.set("n", "<A-a>", require("harpoon.mark").add_file, {})
        vim.keymap.set("n", "<c-h>", require("harpoon.ui").nav_prev, { silent = true })
        vim.keymap.set("n", "<c-l>", require("harpoon.ui").nav_next, { silent = true })
    end
}
