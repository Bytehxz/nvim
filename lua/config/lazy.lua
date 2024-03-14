-- EL plugin managger
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)




-- Esta configuración es la que permite que se carguen todos los plugins dentro de la carpeta lua/plugins/*
require("lazy").setup({
	spec = {
		{ import = "plugins" }
	}
})
