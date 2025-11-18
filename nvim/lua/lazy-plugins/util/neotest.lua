return { -- testings stuffs
  "nvim-neotest/neotest",
  event = "BufEnter",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
  },
  opts = {
    adapters = {
      {
        name = "neotest-jest",
        opts = {
          jestCommand = "npx jest --json --forceExit --testLocationInResults",
        },
      },
    },
    status = { virtual_text = true },
    output = { open_on_run = false },
    quickfix = { enabled = false },
  },
  config = function(_, opts)
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          -- Replace newline and tab characters with space for more compact diagnostics
          local message = diagnostic.message
            :gsub("\n", " ")
            :gsub("\t", " ")
            :gsub("%s+", " ")
            :gsub("^%s+", "")
          return message
        end,
      },
    }, vim.api.nvim_create_namespace("neotest"))

    local adapters = {}
    for key, adapter in pairs(opts.adapters) do
      adapters[key] = require(adapter.name)(adapter.opts)
    end

    opts.adapters = adapters

    require("neotest").setup(opts)
  end,
  keys = {
    {
      "<leader>ns",
      "<CMD>Neotest summary<CR>",
      mode = "n",
      desc = "[n]eotest [s]ummary",
    },
    {
      "<leader>nf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      mode = "n",
      desc = "Run File",
    },
    {
      "<leader>na",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      mode = "n",
      desc = "Run All Test Files",
    },
    {
      "<leader>nn",
      function()
        require("neotest").run.run()
      end,
      mode = "n",
      desc = "Run Nearest",
    },
    {
      "<leader>nl",
      function()
        require("neotest").run.run_last()
      end,
      mode = "n",
      desc = "Run Last",
    },
    {
      "<leader>no",
      function()
        require("neotest").output_panel.toggle()
      end,
      mode = "n",
      desc = "Toggle Output Panel",
    },
    {
      "<leader>nS",
      function()
        require("neotest").run.stop()
      end,
      mode = "n",
      desc = "Stop",
    },
    {
      "<leader>nw",
      function()
        require("neotest").watch.toggle(vim.fn.expand("%"))
      end,
      mode = "n",
      desc = "Toggle Watch",
    },
  },
}
