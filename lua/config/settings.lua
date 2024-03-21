vim.g.mapleader = " " -- Esto es para mappear la tecla <Space> o espacio en 
local opt = vim.opt -- Para poder ver todas las posibles opciones :h options.txt # y en option-list colocar <ctrl>} y se abre el listado de las opciones
local cmd = vim.cmd
-- 
vim.o.termguicolors = true
-- Numeros relativos y lo de inccommand
opt.relativenumber = true
opt.number = true
opt.inccommand = "split"

-- Para poder poner con colores cuando copio un parrafo del texto
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})


-- Primer tema colocado con lua
-- cmd.colorscheme("slate")



-- El juego de las keymaps
-- vim.keymap.set('n', '<leader>x', ':bd!<cr>', { desc = "Close current buffer" })
--
-- vim.keymap.set('n', '<leader>rr', ':source %<cr>', { desc = "Source the current file" })
--
-- vim.keymap.set('v', '>', '>gv', { desc = "after tab in re-select the same"})
-- vim.keymap.set('v', '<', '<gv', { desc = "after tab out re-select the same"})
--
-- vim.keymap.set('n', 'n', 'nzzzv', { desc = "Goes to the next result on the seach and put the cursor in the middle"})
-- vim.keymap.set('n', 'N', 'Nzzzv', { desc = "Goes to the prev result on the seach and put the cursor in the middle"})
--
-- -- Barbar plugin
-- vim.keymap.set('n', '<Tab>', ':BufferNext<cr>', { desc = "Next Buffer" })
-- vim.keymap.set('n', '<S-Tab>', ':BufferPrevious<cr>', { desc = "Prev Buffer" })
--
