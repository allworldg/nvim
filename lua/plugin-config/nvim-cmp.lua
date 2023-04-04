-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/onsails/lspkind-nvim
local status, cmp = pcall(require, "cmp")
if not status then
  vim.notify("cmp not found")
  return
end

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

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#F7F7F7" })



cmp.setup({
  -- preselect = cmp.PreselectMode.Item,
  completion = {
    completeopt = "" -- default
  },
  window = {
    completion = {
      border = { "", "", "", "│", "", "", "", "│" },
      side_padding = 1,
      col_offset = 0,
      winhighlight = "Normal:CmpNormal"
    },
    documentation = false,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  -----keybindings
  -- 上一个
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    -- 下一个
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- 出现补全
    ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- 取消
    ["<A-,>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- accept currently selected item. if none selected, `select` first item.
    -- set `select` to `false` to only confirm explicitly selected items.
    ["<cr>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.replace,
    }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    -- super tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
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
})
