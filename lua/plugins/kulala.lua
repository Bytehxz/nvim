return {
  "mistweaverco/kulala.nvim",
  -- Carga solo al abrir archivos .http o .rest
  ft = { "http", "rest" },
  opts = {
    -- Ambiente por defecto (cargado desde http-client.env.json)
    default_env = "default",

    -- Detiene la ejecución si un request falla (útil para cadenas de auth)
    halt_on_error = true,

    -- Activa keymaps globales con prefijo <leader>R
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",

    -- Timeout de 2 minutos (útil para endpoints lentos o fuzzing)
    kulala_core = {
      timeout = 120000,
    },

    -- LSP integrado para autocompletado y sintaxis en archivos .http
    lsp = {
      enable = true,
      filetypes = { "http", "rest" },
    },

    -- Formatear respuestas automáticamente según Content-Type
    -- jq para JSON (sudo apt install jq), xmllint para XML, prettier para HTML
    contenttypes = {
      ["application/json"] = {
        ft = "json",
        formatter = vim.fn.executable("jq") == 1 and { "jq", "." } or nil,
      },
      ["text/html"] = {
        ft = "html",
        formatter = vim.fn.executable("prettier") == 1
            and { "prettier", "--stdin-filepath", "file.html" }
          or nil,
      },
      ["application/xml"] = {
        ft = "xml",
        formatter = vim.fn.executable("xmllint") == 1
            and { "xmllint", "--format", "-" }
          or nil,
      },
    },
  },

  config = function(_, opts)
    require("kulala").setup(opts)

    -- Atajos adicionales para flujo de pentesting
    -- Solo activos en buffers .http/.rest
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "http", "rest" },
      callback = function(ev)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
        end
        local kulala = require("kulala")

        map("<leader>Rs", kulala.run,          "Kulala: ejecutar request bajo el cursor")
        map("<leader>Ra", kulala.run_all,       "Kulala: ejecutar todos los requests")
        map("<leader>Rb", kulala.scratchpad,    "Kulala: abrir scratchpad (buffer temporal)")
        map("<leader>Rc", kulala.copy,          "Kulala: copiar como cURL al clipboard")
        map("<leader>Rf", kulala.from_curl,     "Kulala: pegar desde cURL del clipboard")
        map("<leader>Rt", kulala.toggle_view,   "Kulala: alternar vista body/headers")
        map("<leader>Re", kulala.set_selected_env, "Kulala: cambiar ambiente (dev/prod/...)")
        map("<leader>Rn", kulala.jump_next,     "Kulala: siguiente request")
        map("<leader>Rp", kulala.jump_prev,     "Kulala: request anterior")
        map("<leader>Rk", kulala.close,         "Kulala: cerrar ventana de respuesta")
      end,
    })
  end,
}
