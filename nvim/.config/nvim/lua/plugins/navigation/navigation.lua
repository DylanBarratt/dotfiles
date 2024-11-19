return {
  {
    'chrisgrieser/nvim-spider',
    lazy = true,
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n' } },
    },
    config = function()
      require('spider').setup {
        skipInsignificantPunctuation = false,
        consistentOperatorPending = false, -- see "Consistent Operator-pending Mode" in the README
        subwordMovement = true,
        customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
      }
    end,
  },
  {
    'ggandor/leap.nvim',
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')

      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

      require('leap').opts.safe_labels = {}
    end,
  },
}
