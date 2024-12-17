return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim", -- lsp notifications
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "ocamllsp",
        "harper_ls", -- spell check
      },

      automatic_installation = true,
    })

    require("mason-lspconfig").setup_handlers({
      -- auto setup other servers with default options.
      -- MUST BE FIRST?
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,

      -- NOTE: am i doing this right?
      ["harper_ls"] = function()
        -- spel misteak
        require("lspconfig")["harper_ls"].setup({
          settings = {
            ["harper-ls"] = {
              userDictPath = "~/dict.txt",
              fileDictPath = "~/.harper/",
              linters = {
                spell_check = true,
                spelled_numbers = false,
                an_a = true,
                sentence_capitalization = false,
                unclosed_quotes = true,
                wrong_quotes = false,
                long_sentences = true,
                repeated_words = true,
                spaces = true,
                matcher = true,
                correct_number_suffix = true,
                number_suffix_capitalization = true,
                multiple_sequential_pronouns = true,
                linking_verbs = false,
                avoid_curses = true,
                terminating_conjunctions = true,
              },
            },
          },
        })
      end,

      ["ocamllsp"] = function()
        require("lspconfig")["ocamllsp"].setup({
          settings = {
            codelens = { enable = true },
          },
        })
      end,
    })
  end,
}
