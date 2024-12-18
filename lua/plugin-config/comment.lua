return {
    {
    "numToStr/Comment.nvim",
    config=function()
        vim.api.nvim_set_keymap("n", "<c-_>", "gcc", { noremap = false })
        vim.api.nvim_set_keymap("v", "<c-_>", "gc", { noremap = false })
    end

    }
}