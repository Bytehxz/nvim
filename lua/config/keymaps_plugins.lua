-- Keymasp for all of my plugins
----------------------------------- Plugins -----------------------------------------
----------------------------------- Colorizer.lua
-- Poner los colores en el archivo actual
vim.keymap.set("n", "<leader>ct", ":ColorizerToggle<cr>", { desc = "Colorizer current buffer " })

----------------------------------- Open float terminal
-- open_mapping = [["n", <C-T>, "Toggle terminal"]],
---------------------------------- Barbar.lua plugin
-- Cambiar entre los buffers activos
vim.keymap.set("n", "<Tab>", ":BufferNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferPrevious<cr>", { desc = "Prev Buffer" })

----------------------------------- Codesnap.lua plugin
-- Tomar una captura y guardarla en la ruta /home/bytehxz/codeSnap/code.png
vim.keymap.set("v", "<leader>ts", ":CodeSnapSave<CR>", { desc = "Take Screenshot of selected code" })

----------------------------------- Comments
-- Plugin para hacer que se creen comentarios dependiendo la que decidas
-- keys = {
--     { "gcc", mode = "n", desc = "Comment toggle current line" },
--     { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
--     { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
--     { "gbc", mode = "n", desc = "Comment toggle current block" },
--     { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
--     { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
--   },

----------------------------------- diff-nvim.lua
-- Te permite visualizar todos los cambios que has hecho en un repositorio mostrando todas las diferencias de todos
-- los archivos o solo el que buffer actual
vim.keymap.set("n", "<leader>gdo", ":DiffviewOpen<CR>", { desc = "Git DiffviewOpen" })
vim.keymap.set("n", "<leader>gdc", ":DiffviewClose<CR>", { desc = "Git DiffviewClose" })

----------------------------------- gitsigns.lua
-- Este plugin te permite saltar a los bloques(hunks) de cada modificación en un archivo de un repositorio
--[[
vim.keymap.set("n", "<leader>ghs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Add to stage git" })
vim.keymap.set("n", "<leader>ghu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Remove hunk changes of stage" })
vim.keymap.set("n", "<leader>ghr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Discard all changes on the file" })
vim.keymap.set("n", "<leader>ghp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview changes selected" })
vim.keymap.set("n", "<leader>ghj", gitsigns.next_hunk, { buffer = bufnr, desc = "Jump next hunk changes" })
vim.keymap.set("n", "<leader>ghk", gitsigns.prev_hunk, { buffer = bufnr, desc = "Jump prev hunk changes" })
]]

----------------------------------- lsp-configuration.lua
-- Este plugin ayuda a obtener informacion de parte del lsp del current buffer desde
-- ir a la definicion de una de las funciones del código
-- informacion acerca de los parámetros que recibe la función si es que no la recordamos
-- Y algunas acciones para hacer con el código
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "info of function" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition of function" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

----------------------------------- minimap.lua
-- Es el minimapa de los archivos que se muestra del lado derecho
-- <leader>m {
-- o = Open de minimap for current buffer
-- c = close de minimap for current buffer
-- }

----------------------------------- none-ls.lua
-- Es par dar formato a los archivos de forma "automática"
vim.keymap.set("n", "<leader>nl", vim.lsp.buf.format, { desc = "buffer format" })

----------------------------------- nvim-surround.lua
--[[ nvim surround pugin; te permite modificar palabras tal cual el ejemplo se presenta:
The three "core" operations of add/delete/change can be done with the keymaps ys{motion}{char}, ds{char}, and cs{target}{replacement}, respectively. For the following examples, * will denote the cursor position:

    Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls
]]

----------------------------------- nvim-tree
-- Este plugin es como un file explorer que muestra los archivos del lado izquierdo
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<cr>", { desc = "NvimTreeToggle" })

----------------------------------- spectre.lua 
-- Este plugin es para filtra por información que nos interese de forma que incluso se puede buscar por expresiones regulares 
-- tanto en el buffer actual como en un proyecto completo
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Open spectre to search word in workdirectory",	})
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word", })
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word", })
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file", })

----------------------------------- Goto preview definition
--[[ Te permite ver de forma gráfica la definicio de una función por ejemplo 

gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
gP <cmd>lua require('goto-preview').close_all_win()<CR>
gpr <cmd>lua require('goto-preview').goto_preview_references()<CR> 

]]

----------------------------------- telescope.lua
-- Es un buscador de archivos completo que puede filtrar por nombre de archivo e incluso visualizar el estatus de los archivos git
--[[ 
keys = {
------------ Search by git
  {
    "<leader>gf",  -- spacebar - git files
    function()
      require('telescope.builtin').git_files({ show_untracked = true })
    end,
    desc = "Telescope Git Files",
  },
  {
    "<leader>bf",  -- spacebar - buffers find
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Telescope buffers",
  },
  {
    "<leader>gs",  -- spacebar git status
    function()
      require("telescope.builtin").git_status()
    end,
    desc = "Telescope Git status",
  },
  {
    "<leader>gc",  -- spacebar git commits
    function()
      require("telescope.builtin").git_bcommits()
    end,
    desc = "Telescope Git commits",
  },
  {
    "<leader>gb",  -- spacebar git branches
    function()
      require("telescope.builtin").git_branches()
    end,
    desc = "Telescope Git branches",
  },
------------ Save new plugin in folder of plugins
  {
    "<leader>rp",  -- spacebar require plugin list all of instaled plugins
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
------------ fuzzing files in currect workdirectory
  {
    "<leader>ff",  -- spacebar fuzzing files
    function()
      require('telescope.builtin').find_files()
    end,
    desc = "Telescope Find Files",
  },
  {
    "<leader>ht", -- spacebar help tags
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Telescope Help"
  },
  {
    "<leader>fb",  -- spacebar file browser
    function()
      require("telescope").extensions.file_browser.file_browser({ path = "%:h:p", select_buffer = true })
    end,
    desc = "Telescope file browser"
  },
  {
    "<leader>fo",  -- spacebar oldfile
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "Telescope oldfiles"
  }
  {
    "<leader>fw",  -- find word in current buffer 
    function ()
      require("telescope.builtin").current_buffer_fuzzy_find()
    end,
    desc = "Telescope fuzzing word in current buffer"
  }
}, 
]]

-----------------------------------

