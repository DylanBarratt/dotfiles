return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = false,
    },
    indent = {
      enable = true,
      chars = {
        "⎸",
      },
    },
    line_num = {
      enable = false,
    },
    blank = {
      enable = false,
    },
  },
}
