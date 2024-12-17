-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
return {
  "folke/which-key.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    -- Document existing key chains
    require("which-key").add({
      {
        mode = { "n" },
        { "<leader>s", group = "[s]earch", icon = "" },
        { "<leader>t", group = "[t]oggle", icon = "󰔡" },
        { "<leader>g", group = "[g]it", icon = "" },
        { "<leader>n", group = "[n]eotest", icon = "󰙨" },
        { "<leader>c", group = "[c]ode", icon = "󰒓" },
        { "<leader>r", group = "[r]est client", icon = "" },
      },
    })
  end,
}
