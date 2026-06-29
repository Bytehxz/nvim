return {
  -- Mason: instala y gestiona binarios de LSP, linters y formateadores
  {
    "williamboman/mason.nvim",
    config = true,
    opts = {
      ensure_installed = {
        "eslint_d",
        "prettier",
        "stylua",
        "black",
        "debugpy",
        "isort",
      },
    },
  },

  -- Mason-lspconfig: puente entre Mason y lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "pyright",
          "clangd",
          "lua_ls",
          "eslint",
          "html",
          "intelephense",
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
      "hrsh7th/cmp-nvim-lsp", -- para capabilities
    },
    config = function()
      -- Capabilities extendidas para autocompletado con nvim-cmp
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
      -- Configuración de cada servidor LSP
      -- Nueva API: vim.lsp.config('servidor', { ... })
      -- ──────────────────────────────────────────────

      -- Python
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        filetypes = { "python" },
      })

      -- PHP
      vim.lsp.config("intelephense", {
        capabilities = capabilities,
        filetypes = { "php" },
        root_dir = function()
          return vim.loop.cwd()
        end,
      })

      -- HTML
      vim.lsp.config("html", {
        capabilities = capabilities,
        filetypes = { "html" },
      })

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
              globals = { "vim" }, -- reconoce 'vim' como global
            },
          },
        },
      })

      -- Servidores con configuración por defecto
      local simple_servers = { "eslint", "clangd", "bashls" }
      for _, server in ipairs(simple_servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- Habilitar todos los servidores configurados arriba
      vim.lsp.enable({
        "pyright",
        "intelephense",
        "html",
        "lua_ls",
        "eslint",
        "clangd",
        "bashls",
      })
    end,
  },
}

--[[ Servidores que Mason debe tener instalados:
  bash-language-server  → bashls
  pyright               → pyright
  clangd                → clangd
  lua-language-server   → lua_ls
  eslint-lsp            → eslint
  html-lsp              → html
  intelephense          → intelephense
  prettier, stylua, black, isort, eslint_d  → formateadores (none-ls)
]]
