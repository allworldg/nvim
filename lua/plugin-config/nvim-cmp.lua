return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    "hrsh7th/cmp-nvim-lsp-signature-help",
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local _, cmp = pcall(require, "cmp")
    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
      vim.notify("luasnip not found")
      return
    end

    local ok, from_vscode = pcall(require, "luasnip/loaders/from_vscode")
    if not ok then
      vim.notify("luasnip/loaders/from_vscode not found")
      return
    end
    from_vscode.lazy_load()

    vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#F7F7F7" })
    vim.api.nvim_set_hl(0, "CmpCursorLine", { bg = '#D5E5F6' })
    -- Use buffer source for `/`.
    cmp.setup.cmdline("/", {
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':'.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      enabled = function()
        -- Set of commands where cmp will be disabled
        local disabled = {
          MasonInstall = true
        }
        -- Get first word of cmdline
        local cmd = vim.fn.getcmdline():match("%S+")
        -- Return true if cmd isn't disabled
        -- else call/return cmp.close(), which returns false
        return not disabled[cmd] or cmp.close()
      end
    })

    local unlinkgrp = vim.api.nvim_create_augroup(
      'UnlinkSnippetOnModeChange',
      { clear = true }
    )

    vim.api.nvim_create_autocmd('ModeChanged', {
      group = unlinkgrp,
      pattern = { 's:n', 'i:*' },
      desc = 'Forget the current snippet when leaving the insert mode',
      callback = function(evt)
        if
            luasnip.session
            and luasnip.session.current_nodes[evt.buf]
            and not luasnip.session.jump_active
        then
          luasnip.unlink_current()
        end
      end,
    })
    cmp.setup({
      completion = {
        completeopt = "menuone,noselect"   -- default
      },
      window = {
        completion = {
          border = { "", "", "", "│", "", "", "", "│" },
          side_padding = 1,
          col_offset = 0,
          winhighlight = "Normal:CmpNormal,CursorLine:CmpCursorLine"
        },
        documentation = false,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -----keybindings
      -- 上一个
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- accept currently selected item. if none selected, `select` first item.
        -- set `select` to `false` to only confirm explicitly selected items.
        ["<cr>"] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.replace,
        }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        -- super tab
        ["<Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }
        ),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        -- end of super tab
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lua" },
      }),
      -- set cmp-window max width
      formatting = {
        ---@diagnostic disable-next-line: unused-local
        format = function(entry, vim_item)
          vim_item.abbr = string.sub(vim_item.abbr, 1, 40)
          return vim_item
        end
      },
    })
  end
}
