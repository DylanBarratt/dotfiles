return {
  "tris203/hawtkeys.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    ["wk.register"] = {
      method = "which_key",
    },
    ["lazy"] = {
      method = "lazy",
    },
  }
}
