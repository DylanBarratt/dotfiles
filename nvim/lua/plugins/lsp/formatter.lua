return { -- code formatting
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = { -- installed with mason
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      sh = { "shfmt" },
      ocaml = { "ocamlformat" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
