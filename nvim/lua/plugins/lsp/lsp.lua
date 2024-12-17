return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim", -- lsp notifications
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    servers = {
      ocamllsp = {
        codelens = { enable = true },
      },
      harper_ls = { -- spell check
        ["harper-ls"] = {
          userDictPath = "~/dict.txt",
          fileDictPath = "~/.harper/",
          linters = {
            spell_check = true,
            spelled_numbers = false,
            an_a = true,
            sentence_capitalization = false,
            unclosed_quotes = true,
            wrong_quotes = true,
            long_sentences = true,
            repeated_words = true,
            spaces = true,
            matcher = true,
            correct_number_suffix = true,
            number_suffix_capitalization = true,
            multiple_sequential_pronouns = true,
            linking_verbs = true,
            avoid_curses = true,
            terminating_conjunctions = true,
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("mason").setup({})

    require("mason-lspconfig").setup({
      -- install servers that have options
      ensure_installed = vim.tbl_keys(opts.servers),
      automatic_installation = true,
    })

    require("mason-lspconfig").setup_handlers({
      -- auto setup other servers with options specified in opts or default options.
      -- i hass ben setip corectly
      function(server_name)
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        require("lspconfig")[server_name].setup({
          settings = opts.servers[server_name],
          capabilities = capabilities,
        })
      end,
    })
  end,
}
