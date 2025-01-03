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
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "[f]ormat code",
    },
  },
}
