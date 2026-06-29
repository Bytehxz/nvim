---@diagnostic disable: missing-fields
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local types = require("cmp.types")
local str = require("cmp.utils.str")

local M = {}

local function set_highlights()
  vim.api.nvim_set_hl(0, "CmpNormal",    { bg = "#1a1b2e", fg = "#c8d3f5" })
  vim.api.nvim_set_hl(0, "CmpBorder",    { bg = "#1a1b2e", fg = "#7aa2f7" })
  vim.api.nvim_set_hl(0, "CmpSel",       { bg = "#2d3f76", fg = "#c8d3f5", bold = true })
  vim.api.nvim_set_hl(0, "CmpDocNormal", { bg = "#141422", fg = "#c8d3f5" })
  vim.api.nvim_set_hl(0, "CmpDocBorder", { bg = "#141422", fg = "#9d7cd8" })
end

set_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_highlights,
})

function M.setup()
	require("luasnip.loaders.from_vscode").lazy_load()
	local lspkind = require("lspkind")
	cmp.setup({
		formatting = {
			format = lspkind.cmp_format({
				with_text = true,
				maxwidth = 50,
				ellipsis_char = "...",
				show_labelDetails = true,
				before = function(entry, vim_item)
					local word = str.oneline(entry:get_insert_text())
					if
						entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
						and string.sub(vim_item.abbr, -1, -1) == "~"
					then
						word = word .. "~"
					end
					vim_item.abbr = word
					return vim_item
				end,
			}),
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered({
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
				scrollbar = false,
			}),
			documentation = cmp.config.window.bordered({
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
				max_width = 60,
				max_height = 20,
			}),
		},
		mapping = {
			["<C-j>"] = cmp.mapping.scroll_docs(4),
			["<C-k>"] = cmp.mapping.scroll_docs(-4),
			["<C-e>"] = cmp.mapping.abort(),
			["<C-Space>"] = cmp.mapping.complete(),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
				else
					fallback()
				end
			end, { "i", "s" }),

			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			["<c-space>"] = cmp.mapping.complete(),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "buffer" },
		},
	})

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "git" },
		}, {
			{ name = "buffer" },
		}),
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return M
