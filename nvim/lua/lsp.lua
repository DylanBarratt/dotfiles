-- Default lsp settings.
-- Can be overridden by adding a file that returns a config to `/lsp/<language-server>.lua`
vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.lsp.enable({
  "lua-language-server",
  "bash-language-server",
  "css-lsp",
  "json-lsp",
  "lua-language-server",
  "marksman",
  "pyright",
  "stylua",
  "superhtml",
  "yaml-language-server",
})
