return {
  {
    'roobert/search-replace.nvim',
    event = 'BufEnter',
    config = function()
      require('search-replace').setup {}
    end,
  },
}
