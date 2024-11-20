return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local detail = false
      require("oil").setup({
        delete_to_trash = true,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },

        float = {
          max_width = 100,
          max_height = 100,
        },

        keymaps = {
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              detail = not detail
              if detail then
                require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
              else
                require("oil").set_columns({ "icon" })
              end
            end,
          },
        },
      })
    end,
  }
}
