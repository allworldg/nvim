-----------basic config -----------------------
local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
  return signature_help({
    border = "single",
  })
end

local hover_help = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover_help({
    border = "single"
  })
end

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = ""
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    }
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "single",
    source = true,
    header = "",
    prefix = "",
  },
})
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local bufnr = event.buf
    local opts = { buffer = bufnr }
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    vim.keymap.set('n', '<leader>se', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>k', function()
      vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = vim.api.nvim_create_augroup("virtual-lines", { clear = true }),
        callback = function()
          vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
          return true
        end
      })
    end, opts)

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- use by other tools
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) -- use by other tools
    -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    --use same keybinding by fzflua.references
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- use conform.nvim to format
    -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  end
})

---------- lsp config -----------------------------

vim.lsp.config.emmet = {
  cmd = { 'emmet-language-server', '--stdio' },
  filetypes = {
    'css',
    'eruby',
    'html',
    'vue',
    'htmldjango',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'typescriptreact',
    'htmlangular',
  },
  root_markers = { '.git' },
}
vim.lsp.enable("emmet", true)


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config.html = {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html', 'templ' },
  root_markers = { 'package.json', '.git' },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
}
vim.lsp.enable('html', true)

vim.lsp.config.jsonls = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git', "tsconfig.json", "package.json", "jsconfig.json" },
}
vim.lsp.enable('jsonls', true)

vim.lsp.config.lua = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files and plugins
        library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
        checkThirdParty = false,
      },
    },
  },
}
vim.lsp.enable("lua")

local mason_registry = require("mason-registry")
local vue_language_path = mason_registry.get_package("vue-language-server"):get_install_path() ..
    "/node_modules/@vue/language-server"
vim.lsp.config.ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { "vue", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = {
    "tsconfig.json", "package.json", "jsconfig.json", ".git"
  },
  init_options = {
    hostInfo = 'neovim',
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_path,
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
}
vim.lsp.enable("ts_ls", false)



local mason_registry = require("mason-registry")
local vue_language_server = mason_registry.get_package("vue-language-server"):get_install_path() ..
    "/node_modules/@vue/language-server"
vim.lsp.config.vtsls = {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "vue", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = {
    "tsconfig.json", "package.json", "jsconfig.json", ".git"
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server,
            languages = { 'vue' },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          }
        }
      }
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
    }
  },
}
vim.lsp.enable("vtsls", true)

local mason_registry = require("mason-registry")
local typescript_path = mason_registry.get_package("vue-language-server"):get_install_path() ..
    "/node_modules/typescript/lib"
vim.lsp.config.volar = {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  root_markers = { "package.json" },
  init_options = {
    vue = {
      hybridMode = true,
    },
    typescript = {
      tsdk = typescript_path
    },
  },

}
vim.lsp.enable("volar", true)



vim.lsp.config.tailwindcss = {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  -- filetypes copied and adjusted from tailwindcss-intellisense
  filetypes = {
    -- html
    'aspnetcorerazor',
    'astro',
    'astro-markdown',
    'blade',
    'clojure',
    'django-html',
    'htmldjango',
    'edge',
    'eelixir', -- vim ft
    'elixir',
    'ejs',
    'erb',
    'eruby', -- vim ft
    'gohtml',
    'gohtmltmpl',
    'haml',
    'handlebars',
    'hbs',
    'html',
    'htmlangular',
    'html-eex',
    'heex',
    'jade',
    'leaf',
    'liquid',
    -- 'markdown',
    'mdx',
    'mustache',
    'njk',
    'nunjucks',
    'php',
    'razor',
    'slim',
    'twig',
    -- css
    'css',
    'less',
    'postcss',
    'sass',
    'scss',
    'stylus',
    'sugarss',
    -- js
    'javascript',
    'javascriptreact',
    'reason',
    'rescript',
    'typescript',
    'typescriptreact',
    -- mixed
    'vue',
    'svelte',
    'templ',
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
      includeLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        templ = 'html',
        htmlangular = 'html',
      },
    },
    editor = {
      tabSize = vim.lsp.util.get_effective_tabstop()
    }
  },
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
  },
}
vim.lsp.enable("tailwindcss", true)

vim.lsp.config.css = {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = { 'package.json', '.git' },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
vim.lsp.enable("css",true)


---@brief
---
--- https://github.com/golang/tools/tree/master/gopls
---
--- Google's lsp server for golang.

--- @class go_dir_custom_args
---
--- @field envvar_id string
---
--- @field custom_subdir string?

local mod_cache = nil
local std_lib = nil

---@param custom_args go_dir_custom_args
---@param on_complete fun(dir: string | nil)
local function identify_go_dir(custom_args, on_complete)
  local cmd = { 'go', 'env', custom_args.envvar_id }
  vim.system(cmd, { text = true }, function(output)
    local res = vim.trim(output.stdout or '')
    if output.code == 0 and res ~= '' then
      if custom_args.custom_subdir and custom_args.custom_subdir ~= '' then
        res = res .. custom_args.custom_subdir
      end
      on_complete(res)
    else
      vim.schedule(function()
        vim.notify(
          ('[gopls] identify ' .. custom_args.envvar_id .. ' dir cmd failed with code %d: %s\n%s'):format(
            output.code,
            vim.inspect(cmd),
            output.stderr
          )
        )
      end)
      on_complete(nil)
    end
  end)
end

---@return string?
local function get_std_lib_dir()
  if std_lib and std_lib ~= '' then
    return std_lib
  end

  identify_go_dir({ envvar_id = 'GOROOT', custom_subdir = '/src' }, function(dir)
    if dir then
      std_lib = dir
    end
  end)
  return std_lib
end

---@return string?
local function get_mod_cache_dir()
  if mod_cache and mod_cache ~= '' then
    return mod_cache
  end

  identify_go_dir({ envvar_id = 'GOMODCACHE' }, function(dir)
    if dir then
      mod_cache = dir
    end
  end)
  return mod_cache
end

---@param fname string
---@return string?
local function get_root_dir(fname)
  if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
    local clients = vim.lsp.get_clients({ name = 'gopls' })
    if #clients > 0 then
      return clients[#clients].config.root_dir
    end
  end
  if std_lib and fname:sub(1, #std_lib) == std_lib then
    local clients = vim.lsp.get_clients({ name = 'gopls' })
    if #clients > 0 then
      return clients[#clients].config.root_dir
    end
  end
  return vim.fs.root(fname, 'go.work') or vim.fs.root(fname, 'go.mod') or vim.fs.root(fname, '.git')
end
vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    get_mod_cache_dir()
    get_std_lib_dir()
    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
    on_dir(get_root_dir(fname))
  end
}
vim.lsp.enable("gopls",true)

vim.lsp.config.asm_lsp = {
  cmd={'asm-lsp'},
  filetypes={'asm','vmasm'},
  root_markers={'.asm-lsp.toml','.git'}
}
vim.lsp.enable("asm_lsp",true)




