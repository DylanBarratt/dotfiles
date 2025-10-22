return { -- lsp server setup
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim", -- lsp notifications
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    ensure_installed = { "lua_ls", "ts_ls" },
    automatic_enable = {
      exclude = {
        "ts_ls", -- disable ts_ls
      },
    },
  },
  config = function(_, opts)
    require("mason").setup({})

    require("mason-lspconfig").setup(opts)
  end,
}
