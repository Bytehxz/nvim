-- configuración para los lsp de mason.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
  },

  config = function ()
    require ("lspconfig").pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {"python"},
    })
    require("lspconfig").clangd.setup({
      on_attach = function (client, bufnr)
        client.server_capabilites.signatureHelpProvider = false
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    })
  end,
}
