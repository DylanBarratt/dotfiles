return { -- create and interact with rest requests
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-neotest/nvim-nio", "j-hui/fidget.nvim", "nvim-telescope/telescope.nvim" },
    ft = "http",
    config = function()
      require("telescope").load_extension("rest")
      -- require('telescope').extensions.rest.select_env()
    end,
}
