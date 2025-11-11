-- Default lsp settings.
-- Can be overridden by adding a file that returns a config to `/lsp/<language-server>.lua`
vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.lsp.enable({
  "typescript-language-server",
  "lua-language-server",
  "bash-language-server",
  "css-lsp",
  "marksman",
  "pyright",
  "stylua",
  "superhtml",
  "yaml-language-server",
})
