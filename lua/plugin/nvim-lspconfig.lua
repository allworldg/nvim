return {
  "neovim/nvim-lspconfig",
  config = function()
    local _, lspconfig = pcall(require, "lspconfig")
    local lspconfig_defaults = lspconfig.util.default_config
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities(capabilities)
    )
    vim.diagnostic.config({
      -- disable virtual text
      virtual_text = true,
      -- show signs
      signs = true,
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "single",
        source = true,
        header = "",
        prefix = "",
      },
    })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single"
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single"
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local bufnr = event.buf
        local opts = { buffer = bufnr }
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client and client.server_capabilities.documentHighlightProvider then
        --   vim.api.nvim_create_augroup("lsp_document_hightlight", { clear = true })
        --   vim.api.nvim_create_autocmd("CursorHold", {
        --     callback = function()
        --       vim.defer_fn(function()
        --         vim.lsp.buf.document_highlight()
        --       end, 100)
        --     end,
        --     buffer = bufnr,
        --     group = "lsp_document_hightlight",
        --     desc = "highlight lsp document highlight"
        --   })
        --   vim.api.nvim_create_autocmd("CursorMoved", {
        --     callback = function()
        --       vim.defer_fn(function()
        --         vim.lsp.buf.clear_references()
        --       end, 100)
        --     end,
        --     buffer = bufnr,
        --     group = "lsp_document_hightlight",
        --     desc = "clear lsp document hightlight"
        --   })
        -- end

        vim.keymap.set('n', '<space>se', vim.diagnostic.open_float, opts)
        -- Enable completion triggered by <c-x><c-o>
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- use by other tools
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) -- use by other tools
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) --use same keybinding by telescople.references
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
      end
    })


    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files and plugins
            library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
            checkThirdParty = false,
          },
        },
      },
    })
    lspconfig.volar.setup {
      -- add filetypes for typescript, javascript and vue
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    }
    lspconfig.ts_ls.setup {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            --run @vue/language-server in conjunction with a TypeScript server that employs @vue/typescript-plugin
            location = "/home/allworldg/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
            languages = { "javascript", "typescript", "vue" },
          },
        },
      },
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
    }
    lspconfig.emmet_language_server.setup({})
  end
}
