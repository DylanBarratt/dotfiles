-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Import all in ./plugins
require('lazy').setup {
  { import = 'plugins' },
  { import = 'plugins.lsp' },
  { import = 'plugins.navigation' },
  { import = 'plugins.ui' },
  { import = 'plugins.util' },
  { import = 'plugins.util.git' },
  { import = 'plugins.local' },
}