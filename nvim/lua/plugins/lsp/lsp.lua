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

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        -- Check if the server is disabled
        local server_opts = opts.servers[server_name]
        if server_opts and server_opts.enabled == false then
          return -- skip setup for this server
        end

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        require("lspconfig")[server_name].setup({
          settings = server_opts,
          capabilities = capabilities,
        })
      end,
    })
  end,
}
