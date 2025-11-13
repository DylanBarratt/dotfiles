return { -- easy lsp installation
  "williamboman/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()

    local servers = require("lsp")

    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })
  end,
}
