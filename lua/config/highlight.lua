vim.api.nvim_set_hl(0, 'LineNr', { fg = "#238993" })
-- treesitter
vim.cmd [[
  highlight @tag.html guifg=#027b56 ctermfg = DarkBlue
  highlight @variable.python guifg = Black
  highlight @parameter.python guifg = DarkCyan
  highlight @include.python guifg = DarkBlue
  highlight @include.python guifg = DarkBlue
  highlight @keyword.function.python guifg = Blue ctermfg=DarkBlue
  highlight @keyword.return.python guifg = DarkCyan
  highlight @repeat.python guifg = #0033B3 ctermfg = DarkBlue
  highlight SnippetTabstop guibg=#edebfc

  highlight LspSignatureActiveParameter guifg= #238993
  highlight Keyword guifg=#0000ff
  highlight Function guifg=#795e26
  highlight PreProc guifg=#795e26
]]

-- diagnostic
vim.cmd [[
  highlight DiagnosticSignInfo  guifg = Black
  highlight DiagnosticSignWarn  guifg = #C4A65E

  highlight DiagnosticUnderlineWarn cterm = underline gui = underline guifg = #696969 guibg = none
  highlight DiagnosticUnderlineHint cterm = underline gui = underline guifg = #696969 guibg = none
  highlight DiagnosticUnderlineInfo cterm = underline gui = underline guifg = #696969 guibg = none
  highlight DiagnosticUnderlineError cterm = underline gui = underline guifg = none guibg = none

  highlight DiagnosticFloatingHint guifg = Black guibg = none ctermfg = Black ctermbg = none
  highlight DiagnosticFloatingWarn guifg = Black guibg = none ctermfg = Black ctermbg = none
  highlight DiagnosticFloatingError guifg = #CB2431 guibg = none ctermfg = Red ctermbg = none
  highlight diagnosticfloatingInfo guifg = Black guibg = none ctermfg = Black ctermbg = none
]]

vim.cmd [[
  hi MatchParen guibg=#EDEBFC
  hi CursorLine guibg=#fcfaed
]]
