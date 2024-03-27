-- configuración para los lsp de mason.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
  },

  config = function ()
    -- for python
    require ("lspconfig").pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {"python"},
    })
    -- for C
    require("lspconfig").clangd.setup({
      on_attach = function (client, bufnr)
        client.server_capabilites.signatureHelpProvider = false
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    })
    -- For js, ts
    require("lspconfig").tsserver.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    -- css               tailwindcss
    require("lspconfig").tailwindcss.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    -- for eslint
    require("lspconfig").eslint.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    -- for html tags
    require("lspconfig").html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
