return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    sections = {
      lualine_c = { { "filename", file_status = true, path = 1, } },
    },
    winbar = {
      lualine_c = { "filename" }
    },
  }
}
