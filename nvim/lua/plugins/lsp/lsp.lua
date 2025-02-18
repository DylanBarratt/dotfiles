return { -- lsp server setup
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim", -- lsp notifications
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    servers = {
    },
  },
  config = function(_, opts)
    require("mason").setup({})

    require("mason-lspconfig").setup({
      -- install servers that have options
      ensure_installed = vim.tbl_keys(opts.servers),
      automatic_installation = true,
    })

    require("mason-lspconfig").setup_handlers({
      -- auto setup other servers with options specified in opts or default options.
      function(server_name)
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        require("lspconfig")[server_name].setup({
          settings = opts.servers[server_name],
          capabilities = capabilities,
        })
      end,
    })
  end,
}
