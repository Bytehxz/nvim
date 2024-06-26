return {
  {
    "nvim-telescope/telescope.nvim",
    event = 'VeryLazy',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      } },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      }
    },
    config = function(opts)
      require('telescope').setup(opts)
      require('telescope').load_extension('fzf')
    end,
    keys = {
      {
        "<leader>gf",  -- space - git files
        function()
          require('telescope.builtin').git_files({ show_untracked = true })
        end,
        desc = "Telescope Git Files",
      },
      {
        "<leader>bf",  -- space - find buffers
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Telescope buffers",
      },
      {
        "<leader>gs",  -- space git status
        function()
          require("telescope.builtin").git_status()
        end,
        desc = "Telescope Git status",
      },
      {
        "<leader>gc",  -- space git commits
        function()
          require("telescope.builtin").git_bcommits()
        end,
        desc = "Telescope Git bcommits",
      },
      {
        "<leader>gb",  -- space git branches
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = "Telescope Git branches",
      },
      {
        "<leader>rp",  -- space require plugin
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Plugins",
            cwd = "~/.config/nvim/lua/plugins",
            attach_mappings = function(_, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")
              map("i", "<c-y>", function(prompt_bufnr)
                local new_plugin = action_state.get_current_line()
                actions.close(prompt_bufnr)
                vim.cmd(string.format("edit ~/.config/nvim/lua/plugins/%s.lua", new_plugin))
              end)
              return true
            end
          })
        end,
        desc = "Save new plugin if don't exist",
      },
      {
        "<leader>ff",  -- space fuzzing files
        function()
          require('telescope.builtin').find_files()
        end,
        desc = "Telescope Find Files",
      },
      {
        "<leader>ht", -- space help tags
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Telescope Help"
      },
      {
        "<leader>fb",  -- space file browser
        function()
          require("telescope").extensions.file_browser.file_browser({ path = "%:h:p", select_buffer = true })
        end,
        desc = "Telescope file browser"
      },
      {
        "<leader>fo",  -- space oldfile
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Telescope oldfiles"
      },

      {
        "<leader>fw",  -- find word in current buffer 
        function ()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Telescope fuzzing word in current buffer"
      }
    },
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function ()
      require("telescope").setup ({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}
