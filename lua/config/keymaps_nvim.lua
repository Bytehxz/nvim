---------------------------------- Commands nvim ----------------------------------
vim.keymap.set("n", "<leader>x", ":bd!<cr>", { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>rr", ":source %<cr>", { desc = "Source the current file" })

vim.keymap.set("v", ">", ">gv", { desc = "after tab in re-select the same" })
vim.keymap.set("v", "<", "<gv", { desc = "after tab out re-select the same" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Goes to the next result on the seach and put the cursor in the middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Goes to the prev result on the seach and put the cursor in the middle" })

---------------------------------- insert mode --------------------------
-- Move around the buffer in insert mode
vim.keymap.set("i", "<C-l>", "<right>", { desc = "Move right" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })

---------------------------------- Normal mode ------------------------------------
-- Clear highlines
vim.keymap.set("n", "<Esc>", ":noh<cr>", { desc = "Clear highlights" })

-- switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })

