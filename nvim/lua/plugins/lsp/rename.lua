return { -- code rename
  "smjonas/inc-rename.nvim",
  opts = {},
  event = "BufEnter",
  init = function()
    vim.keymap.set("n", "<leader>cr", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { desc="[c]ode [r]ename", expr = true })
  end,
}
