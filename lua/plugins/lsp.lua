-- configuración para los lsp de mason.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "folke/neodev.nvim",
  },

  config = function ()
    local lspconfig_r = require("lspconfig")



    -- for python
    lspconfig_r.pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {"python"},
    })
    -- for C
    lspconfig_r.clangd.setup({
      on_attach = function (client, bufnr)
        client.server_capabilites.signatureHelpProvider = false
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    })

    local servers = {"tsserver", "tailwindcss", "eslint"}

    for _, lsp in ipairs(servers) do
      lspconfig_r[lsp].setup{
        on_attach = on_attach,
        capabilities = capabilities
      }

    end
    -- for html tags
    -- npm i -g vscode-langservers-extracted
    -- Add path for the result of command -v npm 
    local capabilities_html = vim.lsp.protocol.make_client_capabilities()
    capabilities_html.textDocument.completion.completionItem.snippetSupport = true
    require("lspconfig").html.setup({
      cmd =  { "vscode-html-language-server", "--stdio" },
      filetypes = {"html", },
      on_attach = on_attach,
      capabilities = capabilities_html,
    })
    
    -- for lua
    require("neodev").setup()
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        }
      }
    })
  end,
}
