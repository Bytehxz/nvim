-- La configuración ahora es con vim.g y el plugin se encarga del resto
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    -- Parsers a instalar automáticamente
    vim.g.nvim_treesitter_ensure_installed = {
      "bash", "go", "lua", "luadoc", "python",
      "javascript", "html", "typescript", "tsx",
      "css", "vimdoc", "vim", "php",
    }

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local ok = pcall(vim.treesitter.start, ev.buf)
        if not ok then
          -- Si treesitter no soporta el filetype, no hace nada
        end
      end,
    })
  end,
}
