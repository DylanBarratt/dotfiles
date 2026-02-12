return {
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
