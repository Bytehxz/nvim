return {
  "norcalli/nvim-colorizer.lua",
  event = "BufReadPost",
  config = function()
    -- Attaches to every FileType mode
    require("colorizer").setup({
      "*" -- Highlight all files, but customize some others.
    })
    -- Exclude some filetypes from highlighting by using `!`
    -- require("colorizer").setup({
    --   "*", -- Highlight all files, but customize some others.
    --   "!vim", -- Exclude vim from highlighting.
    --   -- Exclusion Only makes sense if '*' is specified!
    -- })
  end,
}
