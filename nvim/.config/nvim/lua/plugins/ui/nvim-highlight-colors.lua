return {
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {},
    config = function()
      require('nvim-highlight-colors').setup({
        render = 'virtual',
        virtual_symbol_position = 'inline',
      })
      vim.opt.termguicolors = true
    end,
  }
}
