local status, githubTheme = pcall(require, "github-theme")
if not status then
  vim.notify("github-theme not found")
  return
end
githubTheme.setup({
  theme_style = "light",
  keyword_style = "none",
  comment_style = "none",
  dev = true,
  -- sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  -- Overwrite the highlight groups
}
)
