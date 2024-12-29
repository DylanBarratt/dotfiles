return { -- linting
  "mfussenegger/nvim-lint",
  ft = {
    "typescript",
    "typescriptreact",
  },
  opts = {
    linters_by_ft = {
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("Lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
