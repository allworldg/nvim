-- vim.cmd [[
--       highlight mywhite guifg=#ffffff guibg=#ffffff
--       set statusline=
--       set statusline+=%#PmenuSel#%-10(%t%) "left section
--       set statusline+=%#mywhite#%=         "middle section
--       set statusline+=%=%#PmenuSel#%-6.(%l%)%-3.(%p%) "right section
-- ]]
vim.cmd([[highlight mywhite guifg=#ffffff guibg=#ffffff]])

local leftSectionColor = "%#PmenuSel#"
local leftSection = leftSectionColor .. "%-15(%t%m%)"
local middleSectionColor = "%#mywhite#"
local middleSection = middleSectionColor .. "%="
local rightSectionColor = "%#PmenuSel#"
local rightSection = "%=" .. rightSectionColor .. "%-6.(%l%)%-3.(%p%)"
vim.opt.statusline = leftSection .. middleSection .. rightSection
vim.o.laststatus = 3
