return {
  'folke/edgy.nvim',
  event = 'VeryLazy',
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = 'screen'
  end,
  opts = {
    left = {
      { ft = 'trouble', title = 'Trouble Diagnostics', collapse = false, pinned = true, size = { width = 0.2 } },
    },
    animate = {
      enabled = false,
    },
    open = 'Trouble diagnostics win.type = split win.position=left',
  },
}
