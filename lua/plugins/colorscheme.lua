-- Cattpuccin
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function ()
    vim.cmd.colorscheme "catppuccin-macchiato"
  end
}

-- tokyonight-moon
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd[[colorscheme tokyonight-moon]]
--   end,
--   opts = {},
-- }

