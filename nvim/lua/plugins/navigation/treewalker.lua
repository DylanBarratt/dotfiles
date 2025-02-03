return { -- navigate treesitter nodes
  "aaronik/treewalker.nvim",
  event = "BufEnter",
  opts = {
    highlight = true,
    highlight_duration = 250,
    highlight_group = "CursorLine",
  },
  keys = {
    -- movement
    {
      "<C-k>",
      "<cmd>Treewalker Up<cr>",
      mode = { "n", "v" },
      silent = true,
    },
    {
      "<C-j>",
      "<cmd>Treewalker Down<cr>",
      mode = { "n", "v" },
      silent = true,
    },
    {
      "<C-h>",
      "<cmd>Treewalker Left<cr>",
      mode = { "n", "v" },
      silent = true,
    },
    {
      "<C-l>",
      "<cmd>Treewalker Right<cr>",
      mode = { "n", "v" },
      silent = true,
    },

    -- swapping
    {
      "<C-S-k>",
      "<cmd>Treewalker SwapUp<cr>",
      mode = { "n" },
      silent = true,
    },
    {
      "<C-S-j>",
      "<cmd>Treewalker SwapDown<cr>",
      mode = { "n" },
      silent = true,
    },
    {
      "<C-S-h>",
      "<cmd>Treewalker SwapLeft<cr>",
      mode = { "n" },
      silent = true,
    },
    {
      "<C-S-l>",
      "<cmd>Treewalker SwapRight<cr>",
      mode = { "n" },
      silent = true,
    },
  },
}
