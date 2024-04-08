return {
  'NvChad/nvim-colorizer.lua',
  -- "norcalli/nvim-colorizer.lua",
  event = "BufReadPost",
  config = function()
    -- Attaches to every FileType mode
    require("colorizer").setup({
    })
      -- "*" -- Highlight all files, but customize some others.
  end,
}
