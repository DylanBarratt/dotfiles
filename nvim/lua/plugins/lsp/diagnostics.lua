return {
  { -- better lsp diagnostics
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    init = function()
      vim.diagnostic.config({ virtual_text = false })
    end,
    opts = {
      preset = "minimal",
      options = {
        show_source = true,
        throttle = 0, -- increase if laggy
        multiple_diag_under_cursor = true,
      },
    },
  },
}
