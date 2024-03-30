return {
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup({
      filetypes = {
        "javascript", 
        "javascriptreact", 
        "typescript", 
        "typescriptreact",
        "html",
        "xml",
        "php"
      },
    })
  end,
}
