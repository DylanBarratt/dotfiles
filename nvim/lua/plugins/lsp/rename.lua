return { -- code rename
  "smjonas/inc-rename.nvim",
  dependencies = { "stevearc/dressing.nvim" },
  opts = {
    input_buffer_type = "dressing",
  },
  keys = {
    {
      "<leader>cr",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      mode = "n",
      desc = "[r]ename",
    },
  },
}
