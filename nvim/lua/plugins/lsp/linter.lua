-- NOTE:
--      eslint_d must be installed! Mason is nice :)
--      "eslint" and "typescript-eslint" must also be installed for the default config. 
--        `npm install -G eslint typescript-eslint`
--

return { -- linting
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    local function hasConfig()
      local cwd = vim.fn.getcwd()
      local configs = { "eslint.config.js", "eslint.config.ts" }

      for _, filename in ipairs(configs) do
        if vim.fn.filereadable(cwd .. "/" .. filename) == 1 then
          return true
        end
      end
      return false
    end

    if hasConfig() then
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
    else
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
          "--config",
          "/home/dylan/eslint.config.mjs",
        },
        stream = "stdout",
        ignore_exitcode = true,
        parser = require("lint.linters.eslint_d").parser,
      }
    end

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
