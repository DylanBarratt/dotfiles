-- Default lsp settings.
-- Can be overridden by adding a file that returns a config to `/lsp/<language-server>.lua`
vim.lsp.config("*", {
  root_markers = { ".git" },
})

local ensure_installed = {
  "ts_ls",
  "lua_ls",
  "bashls",
  "cssls",
  "marksman",
  "pyright",
  "stylua",
  "superhtml",
  "jsonls",
}

local servers = {
  "cfn_ls",
  unpack(ensure_installed),
}

vim.lsp.enable(servers)

return { servers, ensure_installed }
