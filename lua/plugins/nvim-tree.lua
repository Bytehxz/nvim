return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				number = true,
				relativenumber = true,
				-- side = "right",
				width = 35,
			},
		})
	end,
}
