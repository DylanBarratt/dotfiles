return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  keys = {
    {
      "<leader>qt",
      function()
        require("quicker").toggle()
      end,
      mode = "n",
      desc = "Toggle quickfix",
    },
    {
      "<leader>ql",
      function()
        require("quicker").toggle({ loclist = true })
      end,
      mode = "n",
      desc = "Toggle loclist",
    },
  },
}
