return {
  {
    "williamboman/mason.nvim",
    config = true,
    opts = {
      ensure_installed = {
        "eslint_d",
        "prettier",
        "stylua",
        "black"
      }
    }
  },

  {
    "williamboman/mason-lspconfig.nvim",
    -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    config = function ()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- LSP 
          "pyright",
          "clangd",
          "lua_ls",
          -- For development
          "tsserver",
          "tailwindcss",
          "eslint",
          "html",
          },
      })
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "folke/neodev.nvim",
    },

    config = function ()
      local lspconfig_r = require("lspconfig")
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "info of function"})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition function" })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code actions" })

      -- for python
      lspconfig_r.pyright.setup({
        capabilities = capabilities,
        filetypes = {"python"},
      })

      -- for C
      -- local cap_clangd = require("cmp_nvim_lsp").default_capabilities()
      lspconfig_r.clangd.setup({
        -- capabilities = cap_clangd,
        capabilities = capabilities
      })

      -- for js
      local servers = {"tsserver", "tailwindcss", "eslint"}
      for _, lsp in ipairs(servers) do
        lspconfig_r[lsp].setup{
          capabilities = capabilities
        }
      end

      -- for html tags
      -- npm i -g vscode-langservers-extracted
      -- Add path for the result of command -v npm 
      -- local capabilities_html = vim.lsp.protocol.make_client_capabilities()
      -- capabilities_html.textDocument.completion.completionItem.snippetSupport = true
      require("lspconfig").html.setup({
        cmd =  { "vscode-html-language-server", "--stdio" },
        filetypes = {"html"},
        capabilities = capabilities,
      })

      -- for lua
      require("neodev").setup()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            telemetry = { enable = false },
            workspace = { checkThirdParty = false },
          }
        }
      })
    end,
  }
}
