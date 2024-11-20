-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local function isValidFile()
  return vim.bo.filetype ~= 'alpha'
    and vim.bo.filetype ~= 'on'
    and vim.bo.filetype ~= 'oil'
    and vim.bo.filetype ~= 'fugitive'
    and vim.bo.filetype ~= 'lazy'
    and vim.bo.filetype ~= 'mason'
end
-- vim.api.nvim_create_augroup('SidebarAutogroup', { clear = true })
-- vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
--   group = 'SidebarAutogroup',
--   callback = function()
--     if isValidFile() then
--       vim.cmd 'Trouble diagnostics win.type = split win.position=left'
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd({ 'QuitPre' }, {
--   group = 'SidebarAutogroup',
--   callback = function()
--     if isValidFile() then
--       vim.cmd 'Trouble diagnostics close'
--     end
--   end,
-- })
