return { -- create and interact with rest requests
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "j-hui/fidget.nvim",
  },
  ft = "http",
  keys = {
    {
      "<leader>rr",
      "<CMD>Rest env set .env<CR><CMD>Rest run<CR>",
      mode = "n",
      desc = "[r]est [r]un",
    },
    {
      "<leader>ro",
      "<CMD>Rest open<CR>",
      mode = "n",
      desc = "[r]est [o]pen results",
    },
    { "<leader>rl", "<CMD>Rest last<CR>", mode = "n", desc = "[r]est [l]ast" },
    {
      "<leader>re",
      "<CMD>Rest env show<CR>",
      mode = "n",
      desc = "[r]est [e]nv show",
    },
  },
  config = function()
    -- format response with jq
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "json",
      callback = function(ev)
        vim.bo[ev.buf].formatprg = "jq"
      end,
    })
  end,
}
