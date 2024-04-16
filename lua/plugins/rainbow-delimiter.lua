return {
	-- this plugin is for rainbow () [] {}
	"HiPhish/rainbow-delimiters.nvim",
	config = function ()
		require("rainbow-delimiters.setup").setup()
	end
}
