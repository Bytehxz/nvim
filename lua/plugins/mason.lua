return {
  "williamboman/mason.nvim",
  config = true,
  opts = {
  ensure_installed = {
    "pyright",
    "clangd",
    "lua-language-server",
    },
  },
}
