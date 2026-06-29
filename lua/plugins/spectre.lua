return {
  "MagicDuck/grug-far.nvim",
  -- Requiere ripgrep instalado: sudo apt install ripgrep / brew install ripgrep
  cmd = "GrugFar", -- carga solo cuando usas el comando
  config = function()
    require("grug-far").setup({
      -- Abre el panel en un split vertical a la derecha
      windowCreationCommand = "vsplit",
      -- Muestra el número de resultados encontrados
      resultsSeparatorLineChar = "─",
    })
  end,
}
