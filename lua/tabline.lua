local M  = {}
function M.my_tabline()
  local s = ""                           -- the final tabline string
  local current = vim.fn.tabpagenr()     -- current tab number (1-based)
  local total   = vim.fn.tabpagenr('$')  -- total number of tabs
  for i = 1, total do
    s = s .. '%' .. i .. 'T'
    if i == current then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    s = s .. '  ' .. M.getCurrentName(i) .. '  '
  end
  s = s .. '%T'
  s = s .. '%#TabLineFill%=#'
  return s
end

function M.getCurrentName(n)
  local buffers = vim.fn.tabpagebuflist(n)
  local windowNr = vim.fn.tabpagewinnr(n)
  local name = vim.fn.fnamemodify(vim.fn.bufname(buffers[windowNr]),':t')
  if name=="" then
    name="[new]"
  end
  return name
end

vim.opt.tabline = "%!v:lua.require'tabline'.my_tabline()"

return M


