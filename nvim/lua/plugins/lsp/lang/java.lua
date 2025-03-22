return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local jdtlsPath =
      require("mason-registry").get_package("jdtls"):get_install_path()
    local equinoxPath = jdtlsPath
      .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
    local configurationPath = jdtlsPath .. "/config_linux"
    local lombokPath = jdtlsPath .. "/lombok.jar"
    local workspaceDir = os.getenv("HOME")
      .. "/.jdtls/"
      .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

    -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
    local config = {
      -- The command that starts the language server
      -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
      cmd = {
        "java", -- java is in env path

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        -- enable lombok support
        "-javaagent:" .. lombokPath,

        "-jar",
        equinoxPath,

        "-configuration",
        configurationPath,

        "-data",
        workspaceDir,
      },

      -- One dedicated LSP server & client will be started per unique root_dir
      root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

      -- Here you can configure eclipse.jdt.ls specific settings
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- for a list of options
      settings = {
        java = {
          format = { enabled = false }, -- use Mason google-java-format instead
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
          },
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
      },

      -- Language server `initializationOptions`
      -- You need to extend the `bundles` with paths to jar files
      -- if you want to use additional eclipse.jdt.ls plugins.
      --
      -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
      init_options = {
        bundles = {},
      },

      capabilities = require("blink.cmp").get_lsp_capabilities(),
    }

    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        require("jdtls").start_or_attach(config)
      end,
    })
  end,
}
