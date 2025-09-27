return { -- lsp server setup
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim", -- lsp notifications
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    servers = {
      ts_ls = { enabled = false },
    },
  },
  config = function(_, opts)
    require("mason").setup({})

    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(opts.servers),
      automatic_installation = true,
    })
  end,
}
