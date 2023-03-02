local status, colorscheme = pcall(require, "colorscheme.github-nvim-theme")
if not status then
  vim.notify("point colorscheme not found")
  return
end
