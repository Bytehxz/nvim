return {
  "williamboman/mason.nvim",
  config = true,
  opts = {
    ensure_installed = {
      "pyright",
      "clangd",
      "lua-language-server",
      -- For development
      "typescript-language-server",
      "tailwindcss-language-server",
      "eslint-lsp",
      },
  },
}
