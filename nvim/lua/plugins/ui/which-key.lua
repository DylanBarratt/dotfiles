-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        {
          mode = { 'n' },
          { '<leader>s', group = '[s]earch', icon = '' },
          { '<leader>t', group = '[t]oggle', icon = '󰔡' },
          { '<leader>g', group = '[g]it', icon = '' },
          { '<leader>x', group = '[x] (trouble)', icon = '' },
          { '<leader>n', group = '[n]eotest', icon = '󰙨' },
          { '<leader>c', group = '[c]ode', icon = '󰒓' },
          { '<leader>r', group = '[r]est client', icon = '' },
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
