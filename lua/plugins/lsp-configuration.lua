return {
	{
		"williamboman/mason.nvim",
		config = true,
		opts = {
			ensure_installed = {
				"eslint_d",
				"prettier",
				"stylua",
				"black",
				"debugpy",
			},
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- LSP
					"bashls",
					"pyright",
					"clangd",
					"lua_ls",
					-- For development
					"tsserver",
					"tailwindcss",
					"eslint",
					"html",
					"intelephense",
					"phpactor"
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"folke/neodev.nvim",
		},

		config = function()
			local lspconfig_r = require("lspconfig")
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- for python
			lspconfig_r.pyright.setup({
				capabilities = capabilities,
				filetypes = { "python" },
			})

			-- for C
			-- lspconfig_r.clangd.setup({
			-- 	-- capabilities = cap_clangd,
			-- 	capabilities = capabilities,
			-- })
			--
			-- -- for bash
			-- lspconfig_r.bashls.setup({
			-- 	capabilities = capabilities,
			-- })
			-- lspconfig_r.phpactor.setup()

			-- for js
			local servers = { "tsserver", "tailwindcss", "eslint", "clangd", "bashls", "intelephense", "phpactor" }
			for _, lsp in ipairs(servers) do
				lspconfig_r[lsp].setup({
					capabilities = capabilities,
				})
			end

			-- for html tags
			-- npm i -g vscode-langservers-extracted
			-- Add path for the result of command -v npm
			-- local capabilities_html = vim.lsp.protocol.make_client_capabilities()
			-- capabilities_html.textDocument.completion.completionItem.snippetSupport = true
			require("lspconfig").html.setup({
				cmd = { "vscode-html-language-server", "--stdio" },
				filetypes = { "html" },
				capabilities = capabilities,
			})

			-- for lua
			require("neodev").setup()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						telemetry = { enable = false },
						workspace = { checkThirdParty = false },
					},
				},
			})
		end,
	},
}

--[[ Todo lo que debería tener mason instalado

    ◍ bash-language-server bashls
    ◍ black
    ◍ clangd
    ◍ debugpy
    ◍ eslint-lsp eslint
    ◍ eslint_d
    ◍ html-lsp html
    ◍ isort
    ◍ lua-language-server lua_ls
    ◍ prettier
    ◍ pyright
    ◍ stylua
    ◍ tailwindcss-language-server tailwindcss
    ◍ typescript-language-server tsserver
]]
