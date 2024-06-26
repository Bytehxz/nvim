return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	event = "VeryLazy",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"bash",
			"go",
			"lua",
			"luadoc",
			"python",
			"javascript",
			"html",
			"typescript",
			"tsx",
			"css",
			"vimdoc",
			"vim"
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "org" },
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@conditional.outer",
					["ic"] = "@conditional.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
				},
			},
		},
	},
}
