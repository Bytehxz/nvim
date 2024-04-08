return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			globalstatus = true,
			theme = "dracula",
			-- theme = 'horizon'
		},
		sections = {
			lualine_a = {
				{ "mode", icon = "" },
			},

			-- lualine_c = {
			--   { "filename", file_status = true, path = 1, },
			-- },

			lualine_x = {
				{ -- Para mostrar el status del lsp en uso
					-- Lsp server name .
					function()
						local msg = "No Active Lsp"
						local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
						local clients = vim.lsp.get_active_clients()
						if next(clients) == nil then
							return msg
						end
						local X = ""
						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								X = client.name .. "," .. X
							end
						end
						if not (X == "") then
							return X:sub(1, -2)
						else
							return msg
						end
					end,
					icon = "  LSP:",
					color = { fg = "#11d5e8", gui = "bold" },
				},
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
		},

		-- inactive_winbar = {
		--   lualine_c = { "filename" },
		-- },
	},
}
