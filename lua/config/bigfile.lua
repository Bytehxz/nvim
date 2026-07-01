local aug = vim.api.nvim_create_augroup("bigfile", { clear = true })

-- Umbrales (ajústalos a tu gusto)
local MAX_BYTES = 2.5 * 1024 * 1024 -- 1.5 MB
local MAX_LINES = 100000

-- Detección temprana por tamaño en disco, ANTES de leer el buffer
vim.api.nvim_create_autocmd("BufReadPre", {
  group = aug,
  callback = function(args)
    local buf = args.buf
    local name = vim.api.nvim_buf_get_name(buf)
    local ok, stats = pcall(vim.uv.fs_stat, name) -- vim.loop en <0.10
    if not (ok and stats and stats.size > MAX_BYTES) then return end

    vim.b[buf].bigfile = true

    -- Mata el "redrawtime exceeded"
    vim.bo[buf].syntax = "off"
    -- Opciones que alivian el render
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.spell = false
    vim.opt_local.swapfile = false
    vim.opt_local.undofile = false
    vim.opt_local.list = false
  end,
})

-- Ya cargado: apaga treesitter, y captura el caso de líneas sin tamaño en disco
vim.api.nvim_create_autocmd("BufReadPost", {
  group = aug,
  callback = function(args)
    local buf = args.buf
    if not vim.b[buf].bigfile then
      if vim.api.nvim_buf_line_count(buf) <= MAX_LINES then return end
      vim.b[buf].bigfile = true
      vim.bo[buf].syntax = "off"
    end
    pcall(vim.treesitter.stop, buf)
  end,
})

-- Evita que el LSP se quede pegado a bigfiles: lo desengancha al intentar adjuntarse
vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(args)
    local buf = args.buf
    if not vim.b[buf].bigfile then return end
    vim.schedule(function()
      vim.lsp.buf_detach_client(buf, args.data.client_id)
    end)
  end,
})
