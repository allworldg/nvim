return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = "auto",
        icons_enabled = true,
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = { { 'branch', color = { bg = '#cee1f8', fg = '#478fe3' } } },
        lualine_b = { { 'filename', color = { bg = '#0969da', fg = '#ffffff' } } },
        lualine_c = { 'diagnostics' },
        lualine_x = { { 'filetype', color = { bg = '#ffffff', fg = '#478fe3' } } },
        lualine_y = { { 'progress',color = {bg='#cee1f8',fg='#478fe3'} } },
        lualine_z = { { 'location',color = {bg='#0969da',fg='#ffffff'} } }
      }
    }
  end
}
