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
					"eslint",
					"html",
					"intelephense",
					"phpactor",
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
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			end

			-- for python
			lspconfig_r.pyright.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
				filetypes = { "python" },
			})

			lspconfig_r.intelephense.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "php" },
				-- root_dir = root_pattern("composer.json", ".git")
				root_dir = function(pattern)
					local cwd = vim.loop.cwd()
					-- local root = util.root_pattern("composer.json", ".git")(pattern)
					--
					-- -- prefer cwd if root is a descendant
					-- return util.path.is_descendant(cwd, root) and cwd or root
					return cwd
				end,
			})

			local servers = { "eslint", "clangd", "bashls" }
			for _, lsp in ipairs(servers) do
				lspconfig_r[lsp].setup({
					capabilities = capabilities,
					-- on_attach = on_attach,
				})
			end

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
