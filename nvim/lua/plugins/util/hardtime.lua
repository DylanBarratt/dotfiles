return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  opts = {
    disable_mouse = false,
    disabled_filetypes = { 'lazy', 'oil', 'fugitive', 'mason' },
    disabled_keys = {
      ['<Up>'] = { 'i' },
      ['<Down>'] = { 'i' },
      ['<Left>'] = { 'i' },
      ['<Right>'] = { 'i' },
      ['<Down>'] = { 'n' },
      ['<Left>'] = { 'n' },
      ['<Right>'] = { 'n' },
    },
  },
}
