-- Default lsp settings.
-- Can be overridden by adding a file that returns a config to `/lsp/<language-server>.lua`
vim.lsp.config("*", {
  root_markers = { ".git" },
})

local servers = {
  "ts_ls",
  "lua_ls",
  "bashls",
  "cssls",
  "marksman",
  "pyright",
  "stylua",
  "superhtml",
  "yamlls",
  "groovyls",
}

vim.lsp.enable(servers)

return servers
