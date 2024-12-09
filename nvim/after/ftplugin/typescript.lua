-- Jest file testing
-- vim.keymap.set('n', '<leader>jf', function()
--   require('neotest').run.run { suite = true, jestCommand = 'jest --watch ' }
-- end, { desc = '[j]est [f]ile' })

vim.keymap.set('n', '<leader>cio', '<CMD>TSToolsOrganizeImports<CR>', { desc = 'sorts and removes unused imports' })
vim.keymap.set('n', '<leader>cis', '<CMD>TSToolsSortImports<CR>', { desc = 'sorts imports' })
vim.keymap.set('n', '<leader>cir', '<CMD>TSToolsRemoveUnusedImports<CR>', { desc = 'removes unused imports' })
vim.keymap.set('n', '<leader>cR', '<CMD>TSToolsRemoveUnused<CR>', { desc = 'removes all unused statements' })
vim.keymap.set('n', '<leader>cia', '<CMD>TSToolsAddMissingImports<CR>', { desc = 'adds imports for all statements that lack one and can be imported' })
vim.keymap.set('n', '<leader>cF', '<CMD>TSToolsFixAll<CR>', { desc = 'fixes all fixable errors' })
-- vim.keymap.set('n', '<leader>cd', '<CMD>TSToolsGoToSourceDefinition<CR>', { desc = 'goes to source definition (available since TS v4.7)' })
vim.keymap.set('n', '<leader>cfc', '<CMD>TSToolsRenameFile<CR>', { desc = 'allow to rename current file and apply changes to connected files' })
vim.keymap.set('n', '<leader>cfr', '<CMD>TSToolsFileReferences<CR>', { desc = 'find files that reference the current file (available since TS v4.2)' })
