return { -- linting
  "mfussenegger/nvim-lint",
  ft = {
    "typescript",
    "typescriptreact",
  },
  opts = {},
  config = function()
    local lint = require("lint")

    lint.linters.eslint_yarn = {
      name = "eslint_yarn",
      cmd = "yarn",
      stdin = true,
      args = {
        "eslint",
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      },
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.linters.eslint").parser,
    }

    lint.linters.eslint_d = {
      name = "eslint_d",
      cmd = "eslint_d",
      stdin = true,
      args = {
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      },
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.linters.eslint_d").parser,
    }

    -- lint.linters_by_ft = { typescriptreact = { "eslint_d" } }
    lint.linters_by_ft = { typescriptreact = { "eslint_yarn" } }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("Lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
