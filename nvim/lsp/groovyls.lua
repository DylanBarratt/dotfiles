---@type vim.lsp.Config
return {
  cmd = {
    require("mason.settings").current.install_root_dir
      .. "/bin/groovy-language-server",
  },
  filetypes = { "groovy" },
  root_markers = { "Jenkinsfile", ".git" },
}
