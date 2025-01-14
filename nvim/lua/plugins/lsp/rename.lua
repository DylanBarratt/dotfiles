return { -- code rename
  "smjonas/inc-rename.nvim",
  dependencies = { "stevearc/dressing.nvim" },
  opts = {
    input_buffer_type = "dressing",
  },
  init = function()
    vim.keymap.set("n", "<leader>cr", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { desc = "[c]ode [r]ename", expr = true })
  end,
}
