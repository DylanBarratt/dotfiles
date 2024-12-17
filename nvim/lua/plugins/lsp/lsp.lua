return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim", -- lsp notifications
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup()
    require("mason-lspconfig").ensure_installed = {
      "lua_ls",
      "ts_ls",
      "ocamllsp",
      -- formatters used in formatter.lua
      "stylua",
      "prettier",
      "shfmt",
      -- needed linters
      "eslint_d",
    }

    local lspconfig = require("lspconfig")
    require("mason-lspconfig").setup_handlers({
      ["ocamllsp"] = function()
        lspconfig.ocamllsp.setup({
          settings = {
            codelens = { enable = true },
          },
        })
      end,

      -- auto setup other servers
      function(server_name)
        -- local capabilities = require('blink.cmp').get_lsp_capabilities()
        -- lspconfig[server_name].setup { capabilities = capabilities }
        lspconfig[server_name].setup({})
      end,
    })
  end,
}
