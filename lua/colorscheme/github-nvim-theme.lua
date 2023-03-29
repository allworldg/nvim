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
  ---@diagnostic disable-next-line: unused-local
  overrides = function(c)
    return {
      NormalFloat = { bg = '#F7F7F7' }
    }
  end
}
)

