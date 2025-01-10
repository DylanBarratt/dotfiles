return {
  "dnlhc/glance.nvim",
  event = "LspAttach",
  cmd = "Glance",
  opts = {},
  keys = {
    { "gd", "<CMD>Glance definitions<CR>", mode = "n", desc = "" },
    {
      "gR",
      "<CMD>Glance references<CR>",
      mode = "n",
      desc = "",
      remap = true,
    },
    { "gy", "<CMD>Glance type_definitions<CR>", mode = "n", desc = "" },
    { "gm", "<CMD>Glance implementations<CR>", mode = "n", desc = "" },
  },
}
