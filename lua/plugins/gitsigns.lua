return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    -- signcolumn = false,
    numhl = true,
    trouble = false,
    on_attach = function(bufnr)
      local gitsigns = require "gitsigns"
      vim.keymap.set("n", "<leader>ghs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Add to stage git" })
      vim.keymap.set("n", "<leader>ghu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Remove hunk changes of stage" })
      vim.keymap.set("n", "<leader>ghr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Discard all changes on the file" })
      vim.keymap.set("n", "<leader>ghp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview changes selected" })
      vim.keymap.set("n", "<leader>ghj", gitsigns.next_hunk, { buffer = bufnr, desc = "Jump next hunk changes" })
      vim.keymap.set("n", "<leader>ghk", gitsigns.prev_hunk, { buffer = bufnr, desc = "Jump prev hunk changes" })
    end,
    max_file_length = 10000,
  },
}
--
-- Added de new hunk/trozo de código cambiado
