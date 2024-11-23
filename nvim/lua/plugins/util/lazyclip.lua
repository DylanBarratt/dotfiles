return {
  {
    'atiladefreitas/lazyclip',
    config = function()
      require('lazyclip').setup()
    end,
    keys = {
      { '<leader>P', ":lua require('lazyclip').show_clipboard()<CR>", desc = '[P] clipboard' },
    },
  },
}
