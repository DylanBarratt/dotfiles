return { -- keymap help ui
  "folke/which-key.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    require("which-key").setup()

    require("which-key").add({
      {
        mode = { "n" },
        { "<leader>s", group = "[s]earch", icon = "" },
        { "<leader>t", group = "[t]oggle", icon = "󰔡" },
        { "<leader>g", group = "[g]it", icon = "" },
        { "<leader>n", group = "[n]eotest", icon = "󰙨" },
        { "<leader>c", group = "[c]ode", icon = "󰒓" },
        { "<leader>r", group = "[r]est client", icon = "" },
        { "<leader>b", group = "rule[b]ook", icon = "" },
      },
    })
  end,
}
