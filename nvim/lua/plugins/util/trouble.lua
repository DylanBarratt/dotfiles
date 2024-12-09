return {
  {
    'folke/trouble.nvim',
    opts = {
      auto_close = false, -- auto close when there are no items
      auto_open = false, -- auto open when there are items
      auto_preview = true, -- automatically open preview when on an item
      auto_refresh = true, -- auto refresh when open
      auto_jump = false, -- auto jump to the item when there's only one
      focus = false, -- Focus the window when opened
      restore = true, -- restores the last location in the list when opening
      follow = false, -- Follow the current item
      indent_guides = true, -- show indent guides
      max_items = 200, -- limit number of items that can be displayed per section
      multiline = true, -- render multi-line messages
      pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
      warn_no_results = true, -- show a warning when there are no results
      open_no_results = false, -- open the trouble window when there are no results
      ---@type trouble.Window.opts
      win = {}, -- window options for the results window. Can be a split or a floating window.
      -- Window options for the preview window. Can be a split, floating window,
      -- or `main` to show the preview in the main editor window.
      ---@type trouble.Window.opts
      preview = {
        type = 'main',
        -- when a buffer is not yet loaded, the preview window will be created
        -- in a scratch buffer with only syntax highlighting enabled.
        -- Set to false, if you want the preview to always be a real loaded buffer.
        scratch = true,
      },
      -- Key mappings can be set to the name of a builtin action,
      -- or you can define your own custom action.
      ---@type table<string, trouble.Action.spec|false>
      ---@type table<string, trouble.Mode>
      modes = {
        globalErrors = {
          mode = 'diagnostics', -- inherit from diagnostics mode
          filter = {
            any = {
              buf = 0, -- current buffer
              {
                severity = vim.diagnostic.severity.ERROR, -- errors only
                -- limit to files in the current project
                function(item)
                  return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                end,
              },
            },
          },
        },
      },
    },
    cmd = 'Trouble',
  },
}
