return {
  "Bekaboo/dropbar.nvim",
  -- No requiere nvim-navic ni ninguna dependencia obligatoria
  -- Funciona directo con LSP y Treesitter que ya tienes instalados
  dependencies = {
    -- Opcional: para búsqueda fuzzy en los menús desplegables
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  event = "VeryLazy",
  config = function()
    local dropbar_api = require("dropbar.api")

    -- Atajos para navegar el winbar de forma interactiva
    vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Dropbar: seleccionar símbolo en winbar" })
    vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Dropbar: ir al inicio del contexto" })
    vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Dropbar: seleccionar siguiente contexto" })

    require("dropbar").setup({
      -- El winbar muestra: ruta del archivo > función > método actual
      bar = {
        sources = function(buf, _)
          local sources = require("dropbar.sources")
          local utils = require("dropbar.utils")
          if vim.bo[buf].ft == "markdown" then
            return { sources.path, sources.markdown }
          end
          if vim.bo[buf].buftype == "terminal" then
            return { sources.terminal }
          end
          return {
            sources.path,
            utils.source.fallback({
              sources.lsp,       -- usa LSP si está disponible
              sources.treesitter, -- fallback a treesitter
            }),
          }
        end,
      },
    })
  end,
}
