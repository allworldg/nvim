return {
  settings = {
    pylsp = {
      plugins = {
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        pylint = { enabled = true, executable = "pylint",args={"--disable=C0114,C0115,C0116"} },
        jedi_completion = { fuzzy = true },
        pyls_isort = { enabled = true },
        -- pylsp_mypy = { enabled = true },
      },
    }
  }
}
