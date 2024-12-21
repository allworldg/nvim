return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    local function open_nvim_tree(data)
      -- buffer is a directory
      local directory = vim.fn.isdirectory(data.file) == 1

      if not directory then
        return
      end
      -- change to the directory
      vim.cmd.cd(data.file)
      -- open the tree
      require("nvim-tree.api").tree.open()
    end
    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    vim.cmd [[ hi NvimTreeCursorLine guibg=#D5E5F6]]
    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set({ 'n', 'i' }, '<A-m>', '<cmd>:NvimTreeToggle<CR>', {})
      vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', 'o', api.node.open.edit,opts('open'))
      vim.keymap.set('n', '<2-leftmouse>', api.node.open.edit, opts(''))
      vim.keymap.set('n', '<cr>', api.node.open.edit, opts('open'))
      vim.keymap.set('n', "<tab>", api.node.open.preview, opts('preview'))
      vim.keymap.set('n', 's', api.node.open.horizontal, opts('split'))
      vim.keymap.set('n', 'vs', api.node.open.vertical, opts('vsplit'))
      vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('hide/show dotfiles'))
      vim.keymap.set('n', 'a', api.fs.create, opts('create'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('remove'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('rename'))
      vim.keymap.set('n', 'x', api.fs.cut, opts('cut'))
      vim.keymap.set('n', 'y', api.fs.copy.node, opts('copy'))
      vim.keymap.set('n', 'p', api.fs.paste, opts('paste'))
      vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
      vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
    end
    require("nvim-tree").setup {
      git = {
        enable = true
      },
      filters = {
        -- 隐藏 .文件
        dotfiles = true,
        -- 隐藏 node_modules 文件夹
        -- custom = { "node_modules" },
      },
      renderer = {
        icons = {
          show = {
            git = true,
            file = false,
            folder = false,
            folder_arrow = true,
          }
        },
        root_folder_label = false,
      },
      update_focused_file = {
        enable = true,
        -- update_root = true,
      },
      -- keymapping
      on_attach = my_on_attach,
      actions = {
        open_file = {
          -- 首次打开大小适配
          resize_window = true,
          -- 打开文件时关闭 tree
          quit_on_open = true,
        },
      },
    }
  end,
}
