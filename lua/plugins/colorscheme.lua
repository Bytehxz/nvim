-- Cattpuccin
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("catppuccin-macchiato")
		-- vim.cmd('highlight Visual guibg=#FF0000')
		vim.cmd("highlight Visual guibg=#f5a97f guifg=#000000")
	end,
}

-- tokyonight-moon
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd[[colorscheme tokyonight-moon]]
--   end,
--   opts = {},
-- }
