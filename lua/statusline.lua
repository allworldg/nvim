vim.cmd [[
      highlight mywhite guifg=#ffffff guibg=#ffffff
      set statusline=
      set statusline+=%#PmenuSel#%-10(%t%) "left section
      set statusline+=%#mywhite#%=         "middle section
      set statusline+=%=%#PmenuSel#%-6.(%l%)%-3.(%p%) "right section
]]
