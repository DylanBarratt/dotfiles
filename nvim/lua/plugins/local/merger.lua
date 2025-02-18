return {
  dir = "~/merger.nvim",
  name = "merger",
  config = function()
    require("merger").setup()

    vim.keymap.set("n", "<leader>xr", "<CMD>Lazy reload merger<CR>")
    vim.keymap.set("n", "<leader>xe", "<CMD>Merger<CR>")
  end,
}
