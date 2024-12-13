-- [[ Basic Keymaps ]]
--  See `:help map()`

local map = vim.keymap.set

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- copy to system clipboard
map({ 'x', 'v' }, '<C-c>', '"+y<Esc>')
map('n', '<C-c>', '"+yy<Esc>')

-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', { desc = 'Close the open buffer' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disable scroll wheel
map('', '<scrollwheelup>', '<nop>')
map('', '<S-ScrollWheelUp>', '<nop>')
map('', '<C-ScrollWheelUp>', '<nop>')
map('', '<ScrollWheelDown>', '<nop>')
map('', '<S-ScrollWheelDown>', '<nop>')
map('', '<C-ScrollWheelDown>', '<nop>')
map('', '<ScrollWheelLeft>', '<nop>')
map('', '<S-ScrollWheelLeft>', '<nop>')
map('', '<C-ScrollWheelLeft>', '<nop>')
map('', '<ScrollWheelRight>', '<nop>')
map('', '<S-ScrollWheelRight>', '<nop>')
map('', '<C-ScrollWheelRight>', '<nop>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<up>', '<C-w><C-w>', { desc = 'Move focus to next window' })

-- File explorer
map('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })

-- Barbar shortcuts
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { desc = 'Go to the [LEFT] buffer' })
map('n', '<A-.>', '<Cmd>BufferNext<CR>', { desc = 'Go to the [RIGHT] buffer' })
map('n', '<A-left>', '<Cmd>BufferMovePrevious<CR>', { desc = 'move current buffer to the left' })
map('n', '<A-right>', '<Cmd>BufferMoveNext<CR>', { desc = 'move current buffer to the right' })

-- Page navigation
map('n', '<C-d>', '<C-d>zz', { desc = 'Move down a page and center cursor' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Move up a page and center cursor' })

-- Search-replace
map('n', '<leader>R', '<Cmd>SearchReplaceSingleBufferOpen<CR>', { desc = 'Search and [R]eplace' })

-- Easy pickers
map('n', '<Leader>sc', '<Cmd>Easypick changed_files<CR>', { desc = 'Search git [c]hanged files' })
map('n', '<Leader>p', '<Cmd>Easypick<CR>', { desc = 'All [p]ickers' })

-- Precognition
map('n', '<Leader>tp', '<Cmd>Precognition peek<CR>', { desc = '[t]oggle [p]recognition' })

-- Todo comments
map('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

map('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

map('n', '<Leader>st', '<Cmd>TodoTelescope keywords=TODO<CR>', { desc = 'Search [t]odos in CWD' })

-- Remove wezterm tab
map('n', '<C-t>', '')
map('n', '<C-w>', '')

-- Format
map('n', '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[f]ormat buffer' })

-- lsp (related)
-- (glance)
map('n', 'gd', '<CMD>Glance definitions<CR>', { desc = '[g]o to [d]efinitions' })
map('n', 'gR', '<CMD>Glance references<CR>', { desc = '[g]o to [r]eferences' })
map('n', 'gt', '<CMD>Glance type_definitions<CR>', { desc = '[g]o to [t]ype_definitions' })
map('n', 'gi', '<CMD>Glance implementations<CR>', { desc = '[g]o to [i]mplementations' })

map('n', '<leader>cr', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { expr = true, desc = '[r]ename' })

map('n', '<leader>d', function()
  vim.lsp.buf.hover()
end, { desc = '[d]ocs' })

map('n', '<leader>ca', function()
  vim.lsp.buf.code_action()
end, { desc = '[c]ode [a]ction ' })

-- neotest
map('n', '<leader>ns', '<CMD>Neotest summary<CR>', { desc = '[n]eotest [s]ummary' })
map('n', '<leader>nf', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Run File' })
map('n', '<leader>na', function()
  require('neotest').run.run(vim.uv.cwd())
end, { desc = 'Run All Test Files' })
map('n', '<leader>nn', function()
  require('neotest').run.run()
end, { desc = 'Run Nearest' })
map('n', '<leader>nl', function()
  require('neotest').run.run_last()
end, { desc = 'Run Last' })
map('n', '<leader>no', function()
  require('neotest').output_panel.toggle()
end, { desc = 'Toggle Output Panel' })
map('n', '<leader>nS', function()
  require('neotest').run.stop()
end, { desc = 'Stop' })
map('n', '<leader>nw', function()
  require('neotest').watch.toggle(vim.fn.expand '%')
end, { desc = 'Toggle Watch' })

-- alpha
map('n', '<leader>a', '<CMD>Alpha<CR>', { desc = '[a]lpha' })

-- rest client
map('n', '<leader>rr', '<CMD>Rest env set .env<CR><CMD>Rest run<CR>', { desc = '[r]est [r]un' })
map('n', '<leader>ro', '<CMD>Rest open<CR>', { desc = '[r]est [o]pen results' })
map('n', '<leader>rl', '<CMD>Rest last<CR>', { desc = '[r]est [l]ast' })
map('n', '<leader>re', '<CMD>Rest env show<CR>', { desc = '[r]est [e]nv show' })

-- map('n', '<space>x', function()
--   for _, client in ipairs(vim.lsp.get_clients()) do
--     require('workspace-diagnostics').populate_workspace_diagnostics(client, 0)
--   end
--   vim.api.nvim_command 'Trouble globalErrors'
-- end, {
--   noremap = true,
--   desc = '[x] show workspace diagnostics',
-- })
