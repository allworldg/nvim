vim.cmd.highlight 'clear'
if vim.fn.exists 'syntax_on' then
  vim.cmd.syntax 'reset'
end

vim.g.colors_name = 'allworldg-vlight'


local palette = {
  bg = '#ffffff',
  fg = '#1f1f1f',

  purple = '#af00db',
  black = '#1f1f1f',
  blue = '#0857b5',
  red = '#d1242f',
  green = '#027b56',
  cyan = '#216f86',
  yellow = '#9a6700',
  white = '#f3f3f3',

  bright_blue = '#dae9f9',
  bright_black = '#8c8c8c',
  bright_white = '#f6f8fa',

  boolean = '#0c40d2',
  bg_select = '#f8d700',
  fg_function = '#795e26',
  fg_string = '#a31515',
}

local ui = {
  bg = palette.bg,
  bg_float = palette.bright_white,
  fg = palette.fg,
  fg_muted = palette.bright_black,
  fg_comment = palette.bright_black,
  border = palette.border,

}

---@type table<string, vim.api.keyset.highlight>
local groups = vim.tbl_extend('error', {}, {
  ---===BaseUI===
  Normal = { fg = ui.fg, bg = ui.bg },
  NormalFloat = { fg = ui.fg, bg = ui.bg_float },
  NormalNc = { fg = ui.fg, bg = ui.bg },
  Cursor = { fg = ui.bg, bg = ui.fg },
  CursorLine = { bg = palette.bright_blue },
  CursorLineNr = { fg = ui.fg, bg = ui.bg },
  LineNr = { fg = ui.fg_muted, bg = ui.bg },
  ColorColumn = { bg = palette.bright_black },
  Comment = { fg = ui.fg_comment, bg = ui.bg, cterm = { nocombine = true }, nocombine = true },
  Pmenu = { fg = ui.fg, bg = ui.bg_float },
  PmenuThumb = { bg = palette.bright_black },
  PmenuMatch = { fg = palette.blue, bold = true, cterm = { bold = true } },
  PmenuSel = { bg = palette.bright_blue },
  PmenuMatchSel = { fg = palette.blue, bold = true, cterm = { bold = true } },
  EndOfBuffer = { fg = palette.bright_white },

  WinSeparator = { fg = ui.fg_muted },
  -- StatusLine = { fg = colors.bg, bg = colors.statusLineBg, cterm = { reverse = true } },
  -- StatusLineNC = { fg = colors.bright_black, bg = colors.bright_white, cterm = { reverse = true } },

  Visual = { bg = palette.bright_blue },
  IncSearch = { fg = ui.fg, bg = palette.bg_select },
  MoreMsg = { fg = ui.fg },
  ErrorMsg = { fg = palette.red },
  WarningMsg = { fg = palette.yellow },
  OkMsg = {fg=palette.green},
  Question = { fg = palette.fg },

  --===Builtin Syntax===
  Constant = { fg = palette.green },
  Directory = { fg = palette.fg },
  Delimiter = { fg = palette.fg, ctermfg = 0 },
  Function = { fg = palette.fg_function },
  Identifier = { fg = palette.fg },
  Keyword = { fg = palette.purple, bold = false, cterm = { bold = false } },
  Operator = { fg = palette.fg },
  String = { fg = palette.fg_string },
  Statement = { fg = palette.purple, bold = false },
  Special = { fg = palette.fg },
  Type = { fg = palette.cyan },
  Title = { fg = palette.fg, bold = true },
  MatchParen = { bg = palette.bright_blue },

  --===Treesitter===
  ['@Variable'] = { fg = palette.blue },
  ['@boolean'] = { fg = palette.boolean },
  ['@type.builtin'] = { fg = palette.cyan },
  ['@type.builtin.go'] = { fg = palette.cyan },
  ['punctuation.bracket'] = { link = 'Delimiter' },
  ['@lsp.type.macro'] = { link = 'keyword' },
  rustKeyWord = { link = 'keyword' },
  ['@tag'] = { fg = palette.green },


  --===Diagnostic===
  DiagnosticHint = { fg = palette.bright_black },
  DiagnosticWarn = { fg = palette.yellow },
  DiagnosticError = { fg = palette.red },
  DiagnosticInfo = { fg = palette.fg },
  DiagnosticFloatingHint = { link = 'DiagnosticHint' },
  DiagnosticFloatingWarn = { link = 'DiagnosticWarn' },
  DiagnosticFloatingError = { link = 'DiagnosticError' },
  DiagnosticfloatingInfo = { link = 'DiagnosticInfo' },
  DiagnosticUnderlineHint = { link = 'DiagnosticHint' },
  DiagnosticUnderlineWarn = { link = 'DiagnosticWarn' },
  DiagnosticUnderlineError = { link = 'DiagnosticError' },
  DiagnoticUnderlineInfo = { link = 'DiagnosticInfo' },

  ---statusline
  StatusLine = { bg = palette.bg },
  StatuslineFileName = { bg = palette.bright_blue, fg = palette.blue },
  StatuslineGit = { bg = palette.blue, fg = palette.bright_white },
  StatuslineLsp = { bg = palette.bg, fg = palette.bright_white },
  StatuslineMiddle = { bg = palette.bg },
  StatuslineFileType = { fg = palette.blue, bg = palette.bg },
  StatuslinePercentage = { fg = palette.blue, bg = palette.bright_blue },
  StatuslineLocation = { fg = palette.bg, bg = palette.blue },
  StatuslineInactive = { bg = palette.bright_white },

  ---Tabline
  TabLine = { bg = palette.white },
  TabLineSel={bg=palette.bg,bold=true},


  ---Blink.cmp
  BlinkCmpMenuSelection = { link = 'PmenuSel' },
  BlinkCmpLabelMatch = { link = 'PmenuMatchSel' },

  ---NvimTree---
  NvimTreeNormal = { bg = palette.bright_white, fg = palette.fg },
  NvimTreeCursorLine = { bg = palette.bright_blue },
  NvimTreeGitNewIcon = { fg = palette.green },
  NvimTreeGitDeletedIcon = { fg = palette.red },
  NvimTreeGitDirtyIcon = { fg = palette.yellow },
  --fzflua---
  FzfLuaHeaderBind = { fg = palette.blue },
  FzfLuaHeaderText = { fg = palette.blue },
  FzfLuaLivePrompt = { fg = palette.black, bold = true },
  FzfLuaBufNr = { fg = palette.yellow },

})

for group, opts in pairs(groups) do
  vim.api.nvim_set_hl(0, group, opts);
end
