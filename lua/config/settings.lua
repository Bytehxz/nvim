vim.g.mapleader = " " -- Esto es para mappear la tecla <Space> o espacio en 
local opt = vim.opt -- Para poder ver todas las posibles opciones :h options.txt # y en option-list colocar <ctrl>} y se abre el listado de las opciones
local cmd = vim.cmd
local o = vim.o
-- 
o.termguicolors = true
o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.numberwidth = 2


-- Numeros relativos y lo de inccommand
opt.relativenumber = true
opt.number = true
opt.inccommand = "split"
opt.tabstop = 2
opt.shiftwidth = 2
-- opt.expandtab


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

