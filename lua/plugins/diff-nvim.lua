return {
  "sindrets/diffview.nvim",
  config = function ()
    require("diffview").setup({})
    vim.keymap.set('n', '<leader>gdo', ':DiffviewOpen<CR>', { desc = "Git DiffviewOpen" })
    vim.keymap.set('n', '<leader>gdc', ':DiffviewClose<CR>', { desc = "Git DiffviewClose" })
  end
}
