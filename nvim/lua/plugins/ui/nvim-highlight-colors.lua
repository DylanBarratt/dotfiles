return {
  {
    "brenoprata10/nvim-highlight-colors",
    ft = { "html", "css", "javascriptreact", "typescriptreact" },
    opts = {},
    init = function()
      vim.opt.termguicolors = true
    end,
  },
}
