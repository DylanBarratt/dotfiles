return { -- better lsp diagnostics
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  init = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
  opts = {
    preset = "minimal",
    options = {
      show_source = true,
      throttle = 0, -- increase if laggy
      multiple_diag_under_cursor = true,

      show_related = {
        enabled = true, -- Enable displaying related diagnostics
        max_count = 3, -- Maximum number of related diagnostics to show per diagnostic
      },

      -- Custom function to format diagnostic messages
      -- Receives diagnostic object, returns formatted string
      format = function(diag)
        local source

        local icons = {
          { name = "eslint", char = "" },
          { name = "tsserver", char = "" },
        }

        for _, icon in ipairs(icons) do
          if diag.source == icon.name then
            source = icon.char
          end
        end

        if source == nil then
          return diag.message .. " (" .. diag.source .. ")"
        end

        return diag.message .. " " .. source .. ""
      end,
    },
  },
}
