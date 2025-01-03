return { -- create and interact with rest requests
  "rest-nvim/rest.nvim",
  dependencies = { "nvim-neotest/nvim-nio", "j-hui/fidget.nvim", "nvim-telescope/telescope.nvim" },
  ft = "http",
  keys = {
    { "<leader>rr", "<CMD>Rest env set .env<CR><CMD>Rest run<CR>", "n", desc = "[r]est [r]un" },
    { "<leader>ro", "<CMD>Rest open<CR>", "n", desc = "[r]est [o]pen results" },
    { "<leader>rl", "<CMD>Rest last<CR>", "n", desc = "[r]est [l]ast" },
    { "<leader>re", "<CMD>Rest env show<CR>", "n", desc = "[r]est [e]nv show" },
  },
  config = function()
    require("telescope").load_extension("rest")
    -- require('telescope').extensions.rest.select_env()
  end,
}
