-- NOTE:
--      eslint_d must be installed! Mason is nice :)
--

return { -- linting
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    lint.linters.eslint_d = {
      name = "eslint",
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

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("Lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
