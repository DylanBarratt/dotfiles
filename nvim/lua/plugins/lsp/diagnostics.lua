return {
  { -- better lsp diagnostics
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    init = function()
      vim.diagnostic.config { virtual_text = false }
    end,
    config = true,
  },
}
