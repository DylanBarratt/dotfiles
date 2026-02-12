return {
  cmd = {
    "node",
    "/usr/local/bin/cfn_ls/cfn-lsp-server-standalone.js",
    "--stdio",
  },
  filetypes = { "yaml", "json" },
  root_markers = { "package.json", ".git" },
  init_options = {
    aws = {
      clientInfo = {
        extension = {
          name = "neovim",
          version = vim.version().major .. "." .. vim.version().minor,
        },
        clientId = vim.fn.hostname(),
      },
      telemetryEnabled = true,
    },
  },
}
