return {
  "windwp/nvim-ts-autotag",
  ft = {
    "javascript", 
    "javascriptreact", 
    "typescript", 
    "typescriptreact",
    "html",
    "xml",
    "php"
  },

  config = function()
    require("nvim-ts-autotag").setup({
      filetypes = ft,
    })
  end,
}
