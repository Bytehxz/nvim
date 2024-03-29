-- return { 
--   "EdenEast/nightfox.nvim",
--   config = function()
--     vim.cmd[[colorscheme nightfox]]
--     require('nightfox').setup({
--       options = {
--         styles = {
--           comments = "italic",
--           keywords = "bold",
--           types = "italic,bold",
--         }
--       }
--     })
--   end,
-- } -- lazy


-- -- palenight 
-- return {
--   'drewtempelmeyer/palenight.vim',
--   config = function()
--     vim.cmd[[colorscheme palenight]]
--   end,
--   
-- }


-- tokyonight-moon
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd[[colorscheme tokyonight-moon]]
  end,
  opts = {},
} 

-- onedark
-- return {
--
-- }

-- vim-enfocado
-- return{
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

