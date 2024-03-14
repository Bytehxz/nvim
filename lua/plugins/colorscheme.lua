return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd[[colorscheme tokyonight-storm]]
  end,
  opts = {},
} 


-- {
--   "wuelnerdotexe/vim-enfocado",
--   lazy = false,
--   priority = 1000,
--   init = function()
--     vim.g.enfocado_style = "neon"
--   end,
--   config = function()
--     vim.cmd.colorscheme "enfocado"
--   end,
-- }

