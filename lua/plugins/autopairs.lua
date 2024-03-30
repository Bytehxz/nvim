return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    -- config = function(_, opts)
    --       require("nvim-autopairs").setup(opts)
    --
    --       -- setup cmp for autopairs
    --       local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    --       require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    --     end,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
}
