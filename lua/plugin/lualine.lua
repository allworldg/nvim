return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event="VeryLazy",
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
        lualine_b = {
          -- { 'filename', color = { bg = '#0969da', fg = '#ffffff' } },
          {
            'tabs',
            mode = 1,
            tabs_color = {
              active = { bg = '#0969da', fg = '#ffffff' },
              inactive = { bg = '#f1f1f2', fg = '#000000' } },
          }
        },
        lualine_c = { 'diagnostics' },
        lualine_x = { { 'filetype', color = { bg = '#ffffff', fg = '#478fe3' } } },
        lualine_y = { { 'progress', color = { bg = '#cee1f8', fg = '#478fe3' } } },
        lualine_z = { { 'location', color = { bg = '#0969da', fg = '#ffffff' } } }
      }
    }
  end
}
