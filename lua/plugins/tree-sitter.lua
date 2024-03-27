return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = "VeryLazy",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "bash",
      "go",
      "lua",
      "luadoc",
      "python",
      "javascript",
      "html",
      "typescript",
      "tsx",
      "css",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "org" },
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        },
      },
    },
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
      filetypes = {
        "javascript", 
        "javascriptreact", 
        "typescript", 
        "typescriptreact",
        "html",
        "xml",
        "php"
      },

      
    },
  },
}
