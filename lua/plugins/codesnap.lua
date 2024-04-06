return {
  "mistricky/codesnap.nvim",
	build = "make",
	config = function()
		require("codesnap").setup({
			mac_window_bar = true,
			title = "CodeSnap.nvim",
			code_font_family = "CaskaydiaCove Nerd Font",
			watermark_font_family = "Pacifico",
			watermark = "CodeSnap.nvim",
			-- bg_theme = "default",
			bg_theme = "summer",
			breadcrumbs_separator = "/",
			has_breadcrumbs = false,
			save_path = "/home/bytehxz/codeSnap/code.png",
		})
    vim.keymap.set('v', '<leader>ts', ':CodeSnapSave<CR>', { desc = "Take Screenshot of selected code"})

	end,
}
