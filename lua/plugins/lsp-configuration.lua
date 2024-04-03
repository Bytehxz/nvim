return {
  {
    "williamboman/mason.nvim",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    config = function ()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "clangd",
          -- "lua-language-server",
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
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

      -- for python
      lspconfig_r.pyright.setup({
        capabilities = capabilities,
        filetypes = {"python"},
      })

      -- for C
      lspconfig_r.clangd.setup({
        capabilities = capabilities,
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
      capabilities_html = vim.lsp.protocol.make_client_capabilities()
      capabilities_html.textDocument.completion.completionItem.snippetSupport = true
      require("lspconfig").html.setup({
        cmd =  { "vscode-html-language-server", "--stdio" },
        filetypes = {"html"},
        capabilities = capabilities_html,
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
