---@diagnostic disable: missing-fields
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local types = require("cmp.types")
local str = require("cmp.utils.str")

local M = {}

-- ── Highlight groups del popup ────────────────────────────────────────────
-- Se definen aquí para que se apliquen antes del setup de cmp
local function set_highlights()
  -- Fondo del popup de completado (un poco más oscuro que el editor)
  vim.api.nvim_set_hl(0, "CmpNormal",    { bg = "#1a1b2e", fg = "#c8d3f5" })
  -- Borde del popup
  vim.api.nvim_set_hl(0, "CmpBorder",    { bg = "#1a1b2e", fg = "#7aa2f7" })
  -- Línea seleccionada
  vim.api.nvim_set_hl(0, "CmpSel",       { bg = "#2d3f76", fg = "#c8d3f5", bold = true })
  -- Fondo del panel de documentación
  vim.api.nvim_set_hl(0, "CmpDocNormal", { bg = "#141422", fg = "#c8d3f5" })
  -- Borde del panel de documentación (acento violeta)
  vim.api.nvim_set_hl(0, "CmpDocBorder", { bg = "#141422", fg = "#9d7cd8" })

  -- ── Iconos por tipo de completion con color ───────────────────────────
  vim.api.nvim_set_hl(0, "CmpItemKindText",          { fg = "#c8d3f5" })
  vim.api.nvim_set_hl(0, "CmpItemKindMethod",        { fg = "#7aa2f7" }) -- azul
  vim.api.nvim_set_hl(0, "CmpItemKindFunction",      { fg = "#7aa2f7" }) -- azul
  vim.api.nvim_set_hl(0, "CmpItemKindConstructor",   { fg = "#e0af68" }) -- amarillo
  vim.api.nvim_set_hl(0, "CmpItemKindField",         { fg = "#73daca" }) -- cyan
  vim.api.nvim_set_hl(0, "CmpItemKindVariable",      { fg = "#c8d3f5" })
  vim.api.nvim_set_hl(0, "CmpItemKindClass",         { fg = "#e0af68" }) -- amarillo
  vim.api.nvim_set_hl(0, "CmpItemKindInterface",     { fg = "#e0af68" })
  vim.api.nvim_set_hl(0, "CmpItemKindModule",        { fg = "#7aa2f7" })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty",      { fg = "#73daca" }) -- cyan
  vim.api.nvim_set_hl(0, "CmpItemKindUnit",          { fg = "#ff9e64" }) -- naranja
  vim.api.nvim_set_hl(0, "CmpItemKindValue",         { fg = "#9ece6a" }) -- verde
  vim.api.nvim_set_hl(0, "CmpItemKindEnum",          { fg = "#e0af68" })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword",       { fg = "#f7768e" }) -- rojo/rosa
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet",       { fg = "#9d7cd8" }) -- violeta
  vim.api.nvim_set_hl(0, "CmpItemKindColor",         { fg = "#ff9e64" })
  vim.api.nvim_set_hl(0, "CmpItemKindFile",          { fg = "#c8d3f5" })
  vim.api.nvim_set_hl(0, "CmpItemKindReference",     { fg = "#73daca" })
  vim.api.nvim_set_hl(0, "CmpItemKindFolder",        { fg = "#7aa2f7" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnumMember",    { fg = "#9ece6a" })
  vim.api.nvim_set_hl(0, "CmpItemKindConstant",      { fg = "#ff9e64" })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct",        { fg = "#e0af68" })
  vim.api.nvim_set_hl(0, "CmpItemKindEvent",         { fg = "#f7768e" })
  vim.api.nvim_set_hl(0, "CmpItemKindOperator",      { fg = "#89ddff" }) -- cyan claro
  vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#73daca" })
end

set_highlights()

-- Re-aplicar highlights si el colorscheme cambia en runtime
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_highlights,
})

function M.setup()
	require("luasnip.loaders.from_vscode").lazy_load()
	local lspkind = require("lspkind")
	cmp.setup({
		formatting = {
			-- icono | texto del completado | fuente
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				-- 1. lspkind pone icono + nombre del kind en vim_item.kind
				local kind_formatted = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 40,
					ellipsis_char = "…",
					symbol_map = {
						Snippet  = "󱄽",
						Keyword  = "",
						Variable = "󰀫",
						Function = "󰊕",
						Class    = "󰠱",
						Module   = "",
						File     = "󰈙",
						Folder   = "󰉋",
					},
				})(entry, vim_item)

				-- 2. Separar el icono del texto: "󰊕 Function" → icono="󰊕", texto="Function"
				local strings = vim.split(kind_formatted.kind, "%s", { trimempty = true })
				-- strings[1] = icono, strings[2] = nombre del tipo
				kind_formatted.kind = " " .. (strings[1] or "") .. " "

				-- 3. Mostrar solo la primera línea del abbr
				local word = str.oneline(entry:get_insert_text())
				if
					entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
					and string.sub(kind_formatted.abbr, -1, -1) == "~"
				then
					word = word .. "~"
				end
				kind_formatted.abbr = word

				-- 4. Etiqueta de fuente con el nombre del tipo al lado
				local source_labels = {
					nvim_lsp = "[LSP]",
					luasnip  = "[Snip]",
					buffer   = "[Buf]",
					path     = "[Path]",
					git      = "[Git]",
				}
				local source = source_labels[entry.source.name] or string.format("[%s]", entry.source.name)
				kind_formatted.menu = (strings[2] or "") .. " " .. source

				return kind_formatted
			end,
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
				col_offset = -3,
				side_padding = 1,
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

			-- Me permite cambiar el item si es visible
			-- ["<C-n>"] = cmp.mapping(function(fallback)
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
					-- elseif luasnip.choice_active() then
					--   luasnip.change_choice(1)
				else
					fallback()
				end
			end, { "i", "s" }),

			-- Volver hacia atrás si el item es visible
			-- ["<C-p>"] = cmp.mapping.select_prev_item(),
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

	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		}, {
			{ name = "buffer" },
		}),
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
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
