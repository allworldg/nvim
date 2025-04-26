return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets'},
  version = '1.*',
  event = { "InsertEnter", "CmdlineEnter" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<Enter>'] = { 'select_and_accept', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end, 'fallback'
      }
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    -- snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    cmdline = {
      completion = { menu = { auto_show = true }, list = { selection = { preselect = false } } },
      keymap = {
        ['<Right>'] = { 'fallback' },
        ['<Left>'] = { 'fallback' },
      }
    }
  },
  opts_extend = { "sources.default" },
}
