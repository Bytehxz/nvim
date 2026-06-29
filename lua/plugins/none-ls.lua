return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- ── Lua ──────────────────────────────────────
        null_ls.builtins.formatting.stylua,

        -- ── JS / TS / HTML / CSS / JSON / MD ─────────
        null_ls.builtins.formatting.prettier,

        -- ── Python ───────────────────────────────────
        -- ruff reemplaza black + isort + eslint_d para Python
        null_ls.builtins.formatting.ruff,          -- formatea código
        null_ls.builtins.diagnostics.ruff,         -- linting
        null_ls.builtins.formatting.isort,         -- organiza imports (complementa ruff)

        -- ── PHP ───────────────────────────────────────
        null_ls.builtins.formatting.phpcsfixer,    -- php-cs-fixer

        -- ── Go ───────────────────────────────────────
        null_ls.builtins.formatting.gofumpt,       -- formateador Go estricto
        null_ls.builtins.formatting.goimports,     -- organiza imports Go

        -- ── C# ───────────────────────────────────────
        null_ls.builtins.formatting.csharpier,     -- formateador C#

        -- ── C / C++ ──────────────────────────────────
        -- clangd gestiona el formato internamente con clang-format
        -- si tienes un .clang-format en el proyecto lo usa automáticamente
      },
    })
  end,
}
