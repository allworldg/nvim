return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    lazy = true,
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "../config/snippets" } })
      local luasnip = require("luasnip")
      luasnip.setup({
        region_check_events = {
          "CursorMoved"
        }
      })
    end
  },
}
