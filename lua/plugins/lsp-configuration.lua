return {
  -- Mason: instala y gestiona binarios de LSP, linters y formateadores
  {
    "mason-org/mason.nvim",
    config = true,
    opts = {
      ensure_installed = {
        -- Formateadores y linters generales
        "prettier",
        "stylua",
        "isort",
        -- Python
        "ruff",           -- linter + formateador moderno (reemplaza black + eslint_d para py)
        -- PHP
        "php-cs-fixer",   -- formateador PHP
        -- Go
        "gofumpt",        -- formateador Go (más estricto que gofmt)
        "goimports",      -- organiza imports Go
        -- C#
        "csharpier",      -- formateador C#
        -- Java (jdtls se instala aparte, ver nota abajo)
      },
    },
  },

  -- Mason-lspconfig: puente entre Mason y lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Ya existentes
          "bashls",
          "lua_ls",
          "html",
          -- Python: basedpyright es fork activo de pyright con mejor inferencia
          "basedpyright",
          -- PHP
          "intelephense",
          -- JavaScript / TypeScript
          "ts_ls",         -- sucesor oficial de tsserver
          "eslint",
          -- C / C++
          "clangd",
          -- C#
          "omnisharp",
          -- Go
          "gopls",
          -- Java: jdtls requiere JDK 17+ instalado en el sistema
          "jdtls",
        },
      })
    end,
  },

  -- nvim-lspconfig: configuración de servidores LSP (API v0.11+)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps que se activan solo cuando un LSP se conecta al buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          map("K",          vim.lsp.buf.hover,           "Info de función")
          map("gd",         vim.lsp.buf.definition,      "Ir a definición")
          map("gD",         vim.lsp.buf.declaration,     "Ir a declaración")
          map("gi",         vim.lsp.buf.implementation,  "Ir a implementación")
          map("gr",         vim.lsp.buf.references,      "Ver referencias")
          map("<space>rn",  vim.lsp.buf.rename,          "Renombrar variable")
          map("<space>ca",  vim.lsp.buf.code_action,     "Code actions")
          map("<space>D",   vim.lsp.buf.type_definition, "Tipo de definición")
          map("<space>e",   vim.diagnostic.open_float,   "Diagnóstico flotante")
          map("<space>q",   vim.diagnostic.setloclist,   "Lista de errores")
          map("[d",         vim.diagnostic.goto_prev,    "Diagnóstico anterior")
          map("]d",         vim.diagnostic.goto_next,    "Diagnóstico siguiente")
          map("<space>wa",  vim.lsp.buf.add_workspace_folder,    "Agregar carpeta al workspace")
          map("<space>wr",  vim.lsp.buf.remove_workspace_folder, "Quitar carpeta del workspace")
          map("<space>wl",  function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "Listar carpetas del workspace")
        end,
      })

      -- ──────────────────────────────────────────────
      -- PYTHON — basedpyright + ruff
      -- basedpyright: mejor inferencia de tipos que pyright vanilla
      -- ruff: linting ultrarrápido (reemplaza flake8, black, isort, etc.)
      -- ──────────────────────────────────────────────
      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        filetypes = { "python" },
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard", -- opciones: off | basic | standard | strict
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      -- ──────────────────────────────────────────────
      -- PHP — intelephense con settings mejorados
      -- ──────────────────────────────────────────────
      vim.lsp.config("intelephense", {
        capabilities = capabilities,
        filetypes = { "php" },
        -- root_dir busca composer.json o .git, si no cae al cwd
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("composer.json", ".git")(fname)
            or vim.fn.fnamemodify(fname, ":h")
        end,
        settings = {
          intelephense = {
            stubs = {
              "bcmath", "bz2", "calendar", "Core", "curl", "date", "dba",
              "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm",
              "ftp", "gd", "gettext", "gmp", "hash", "iconv", "imap",
              "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
              "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_mysql",
              "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell",
              "readline", "Reflection", "session", "shmop", "SimpleXML",
              "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3",
              "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm",
              "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter",
              "xsl", "Zend OPcache", "zip", "zlib",
              -- Frameworks populares (agrega los que uses):
              "wordpress", "laravel",
            },
            environment = {
              phpVersion = "8.2", -- cambia a tu versión de PHP
            },
            files = {
              maxSize = 5000000, -- 5MB máximo por archivo
            },
          },
        },
      })

      -- ──────────────────────────────────────────────
      -- JAVASCRIPT / TYPESCRIPT — ts_ls + eslint
      -- ts_ls es el sucesor de tsserver (renombrado en lspconfig)
      -- ──────────────────────────────────────────────
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        filetypes = {
          "javascript", "javascriptreact", "javascript.jsx",
          "typescript", "typescriptreact", "typescript.tsx",
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
            },
          },
        },
      })

      -- ──────────────────────────────────────────────
      -- C / C++ — clangd con configuración completa
      -- ──────────────────────────────────────────────
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        cmd = {
          "clangd",
          "--background-index",         -- indexa en background
          "--clang-tidy",               -- análisis estático integrado
          "--completion-style=detailed",-- completado más detallado
          "--header-insertion=iwyu",    -- include-what-you-use
          "--fallback-style=llvm",      -- estilo de formato por defecto
        },
      })

      -- ──────────────────────────────────────────────
      -- C# — omnisharp
      -- Requiere .NET SDK instalado: https://dotnet.microsoft.com
      -- ──────────────────────────────────────────────
      vim.lsp.config("omnisharp", {
        capabilities = capabilities,
        filetypes = { "cs", "vb" },
        settings = {
          omnisharp = {
            enableRoslynAnalyzers = true,      -- análisis estático avanzado
            enableEditorConfigSupport = true,  -- respeta .editorconfig
            organizeImportsOnFormat = true,    -- organiza usings al formatear
            enableImportCompletion = true,     -- sugerencias de tipos sin importar
          },
        },
      })

      -- ──────────────────────────────────────────────
      -- GO — gopls
      -- Requiere Go instalado: https://go.dev/dl/
      -- ──────────────────────────────────────────────
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,   -- avisa parámetros no usados
              shadow = true,         -- avisa variables que hacen shadow
              fieldalignment = true, -- sugiere ordenar structs para ahorrar memoria
            },
            staticcheck = true,      -- activa staticcheck (análisis avanzado)
            gofumpt = true,          -- usa gofumpt como formateador
            usePlaceholders = true,  -- placeholders en completado de funciones
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      -- ──────────────────────────────────────────────
      -- JAVA — jdtls
      -- Requiere JDK 17+ instalado en el sistema
      -- jdtls se configura con datos por proyecto en un directorio de datos
      -- ──────────────────────────────────────────────
      vim.lsp.config("jdtls", {
        capabilities = capabilities,
        filetypes = { "java" },
        -- jdtls necesita un directorio de datos único por workspace
        -- Mason lo gestiona automáticamente via mason-lspconfig
        settings = {
          java = {
            format = {
              enabled = true,
              settings = {
                url = "", -- puedes apuntar a un estilo XML de Eclipse si quieres
              },
            },
            saveActions = {
              organizeImports = true,
            },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.mockito.Mockito.*",
              },
              importOrder = { "java", "javax", "com", "org" },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
              useBlocks = true,
            },
          },
        },
      })

      -- ──────────────────────────────────────────────
      -- Servidores con configuración por defecto
      -- ──────────────────────────────────────────────
      local simple_servers = { "eslint", "bashls", "html" }
      for _, server in ipairs(simple_servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- Lua (con soporte para la API de Neovim)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Habilitar todos los servidores
      vim.lsp.enable({
        -- Existentes
        "bashls",
        "lua_ls",
        "html",
        "eslint",
        -- Python
        "basedpyright",
        -- PHP
        "intelephense",
        -- JS/TS
        "ts_ls",
        -- C/C++
        "clangd",
        -- C#
        "omnisharp",
        -- Go
        "gopls",
        -- Java
        "jdtls",
      })
    end,
  },
}

--[[ SERVIDORES INSTALADOS POR MASON:

  mason-lspconfig (LSP servers):
    bashls          → bash-language-server
    lua_ls          → lua-language-server
    html            → html-lsp
    basedpyright    → basedpyright          [Python - reemplaza pyright]
    intelephense    → intelephense          [PHP - mejorado]
    ts_ls           → typescript-language-server  [JS/TS]
    eslint          → eslint-lsp
    clangd          → clangd               [C/C++]
    omnisharp       → omnisharp            [C#] requiere .NET SDK
    gopls           → gopls               [Go] requiere go instalado
    jdtls           → jdtls              [Java] requiere JDK 17+

  mason (tools/formatters):
    prettier        → JS/TS/HTML/CSS/JSON/MD
    stylua          → Lua
    isort           → Python (organiza imports)
    ruff            → Python (linting + formato, reemplaza black)
    php-cs-fixer    → PHP
    gofumpt         → Go
    goimports       → Go (organiza imports)
    csharpier       → C#

  REQUISITOS DEL SISTEMA:
    Java  → JDK 17+ (sudo apt install openjdk-17-jdk  /  brew install openjdk@17)
    Go    → Go 1.21+ (https://go.dev/dl/)
    C#    → .NET SDK  (https://dotnet.microsoft.com/download)
    C/C++ → clangd viene en el paquete llvm (sudo apt install clangd  /  brew install llvm)
]]
