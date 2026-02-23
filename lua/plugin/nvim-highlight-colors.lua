return {
  'brenoprata10/nvim-highlight-colors',
  cond=false,
  config = function()
    require('nvim-highlight-colors').setup({
      render = 'virtual',
      virtual_symbol_position = 'eow',
    })
  end
}
