return { -- Highlight todo, notes, etc in comments
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
  opts = { signs = false },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      mode = "n",
      desc = "Next todo comment",
    },

    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      mode = "n",
      desc = "Previous todo comment",
    },

    {
      "<Leader>st",
      "<Cmd>TodoFzfLua keywords=TODO<CR>",
      mode = "n",
      desc = "Search [t]odos in CWD",
    },
  },
}
