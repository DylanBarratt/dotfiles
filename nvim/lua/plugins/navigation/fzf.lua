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
      gutter = "#303446",
      fg = "#c6d0f5",
      bg = "#303446",
      hl = "#ca9ee6",
      ["fg+"] = "#babbf1",
      ["bg+"] = "#292c3c",
      info = "#a6d189",
      border = "#f4b8e4",
      prompt = "#8caaee",
      pointer = "#a6d189",
      header = "#a6adc8",
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

    vim.keymap.set(
      "n",
      "<leader>sr",
      "<CMD>FzfLua grep<CR>",
      { desc = "[s]earch [r]esume" }
    )

    vim.keymap.set(
      "n",
      "<leader>sg",
      "<CMD>FzfLua live_grep<CR>",
      { desc = "[s]earch [g]rep" }
    )

    vim.keymap.set(
      "n",
      "<leader>sw",
      "<CMD>FzfLua grep_cword<CR>",
      { desc = "[s]earch [w]ord" }
    )

    vim.keymap.set(
      "n",
      "<leader>sv",
      "<CMD>FzfLua grep_visual<CR>",
      { desc = "[s]earch [v]isual" }
    )
  end,
}
