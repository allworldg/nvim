--------------- treesitter
vim.cmd [[
  highlight @tag.html guifg=#1647c4 ctermfg = DarkBlue
  highlight @variable guifg = Black
  highlight @parameter.python guifg = DarkCyan
  highlight @include.python guifg = DarkBlue
  highlight @keyword.function.python guifg = Blue ctermfg=DarkBlue
  highlight @keyword.return.python guifg = DarkCyan
  highlight @repeat.python guifg = #0033B3 ctermfg = DarkBlue
]]

--------------- diagnostic
vim.cmd [[
  highlight DiagnosticSignInfo  guifg = Black
  highlight DiagnosticSignWarn  guifg = #C4A65E
  " highlight DiagnosticSignError guifg = #F03D22

  highlight DiagnosticUnderlineWarn cterm = underline gui = underline guifg = #696969 guibg = none
  highlight DiagnosticUnderlineHint cterm = underline gui = underline guifg = #696969 guibg = none
  highlight DiagnosticUnderlineInfo cterm = underline gui = underline guifg = #696969 guibg = none
  highlight DiagnosticUnderlineError cterm = underline gui = underline guifg = none guibg = none

  highlight DiagnosticFloatingHint guifg = Black guibg = none ctermfg = Black ctermbg = none
  highlight DiagnosticFloatingWarn guifg = Black guibg = none ctermfg = Black ctermbg = none
  highlight DiagnosticFloatingError guifg = #F03D22 guibg = none ctermfg = Red ctermbg = none
  highlight diagnosticfloatingInfo guifg = Black guibg = none ctermfg = Black ctermbg = none
]]


