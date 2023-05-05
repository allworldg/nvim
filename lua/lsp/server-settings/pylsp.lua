return {
  settings = {
    pylsp = {
      plugins = {
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        pylint = {
          enabled = true,
          executable = "pylint",
          args = { "--disable=C0114,C0115,C0116,C0103,missing-timeout,too-many-locals,",
            "--extension-pkg-whitelist=lxml","--max-line-length=140" }
        },
        -- jedi_completion = { fuzzy = true },
        -- pyls_isort = { enabled = true },
        -- pylsp_mypy = { enabled = true },
      },
    }
  }
}
