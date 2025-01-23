vim.cmd([[
highlight mywhite guifg=#ffffff guibg=#ffffff
highlight leftSectionColor guibg=#0087af guifg= #ffffff 
highlight rightSectionColor guibg=#0087af guifg= #ffffff 
]])

local leftSectionColor = "%#leftSectionColor#"
local leftSection = leftSectionColor .. "%-1.(%t%m%)"
local middleSectionColor = "%#mywhite#"
local middleSection = middleSectionColor .. "%="
local rightSectionColor = "%#rightSectionColor#"
local rightSection = "%=" .. rightSectionColor .. "%-6.(%l%)%-3.(%p%)"
vim.opt.statusline = leftSection .. middleSection .. rightSection
-- keep statusline be full of whole tab, not in every window
vim.o.laststatus = 3
