return {
  {
    'smjonas/inc-rename.nvim',
    dependencies = { 'stevearc/dressing.nvim' },
    config = function()
      require('inc_rename').setup {
        input_buffer_type = 'dressing',
      }
    end,
  },
}
