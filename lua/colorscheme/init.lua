local status, colorscheme = pcall(require, "colorscheme.github-nvim-theme")
if not status then
  vim.notify("point colorscheme not found")
  return
end

--------------- treesitter
vim.cmd [[
  highlight @tag.html guifg=#1647c4 
]]

vim.cmd[[
 " highlight NormalFloat  guibg = #F7F7F7
]]

--------------- diagnostic
vim.cmd [[
  highlight DiagnosticSignInfo  guifg = Black
  highlight DiagnosticSignWarn  guifg = #C4A65E 
  " highlight DiagnosticSignError guifg = #F03D22

  highlight DiagnosticUnderlineWarn cterm = underline gui = underline guifg = Grey guibg = White
  highlight DiagnosticUnderlineHint cterm = underline gui = underline guifg = Grey guibg = White
  highlight DiagnosticUnderlineInfo cterm = underline gui = underline guifg = Grey guibg = White
  highlight DiagnosticUnderlineError cterm = underline gui = underline guifg = none guibg = White

  highlight DiagnosticFloatingHint guifg = Black guibg = #F7F7F7 ctermfg = Black ctermbg = White
  highlight DiagnosticFloatingWarn guifg = Black guibg = White ctermfg = Black ctermbg = White
  highlight DiagnosticFloatingError guifg = #F03D22 guibg = white ctermfg = Red ctermbg = Black
  highlight diagnosticfloatingInfo guifg = Black guibg = white ctermfg = Black ctermbg = White
]]
