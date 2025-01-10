return { -- faster search?
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    fzf_opts = {},
    winopts = {
      border = "none",
      preview = {
        hidden = true,
        border = "none",
        scrollbar = "border",
      },
    },
    fzf_colors = {
      ["gutter"] = { "bg", "Normal" },
      ["bg"] = { "bg", "Normal" },
      ["bg+"] = { "bg", "Normal" },
      ["fg+"] = { "fg", "Keyword" },
    },
  },
  event = "VimEnter",
  config = function(_, opts)
    require("fzf-lua").setup(opts)
    vim.keymap.set(
      "n",
      "<leader><leader>",
      "<CMD>FzfLua files<CR>",
      { desc = "find files" }
    )
  end,
}
