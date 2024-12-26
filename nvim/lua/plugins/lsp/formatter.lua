return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      -- Define your formatters
      formatters_by_ft = {
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
  },
}
