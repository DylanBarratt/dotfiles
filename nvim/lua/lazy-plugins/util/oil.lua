return { -- manage files like a buffer
  "stevearc/oil.nvim",
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
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
      ["<Esc>"] = { "actions.close", mode = "n" },
    },
  },
  keys = {
    {
      "-",
      "<CMD>Oil --float<CR>",
      mode = "n",
      desc = "Open parent directory",
    },
  },
}
