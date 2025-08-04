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
      ["neotest-jest"] = {
        jestCommand = "npm test --",
        jestConfigFile = "jest.config.ts",
        env = { CI = true },
        cwd = function()
          return vim.fn.getcwd()
        end,
      },
      ["neotest-vitest"] = {
        filter_dir = function(name)
          return name ~= "node_modules"
        end,
      },
    },
    status = { virtual_text = true },
    output = { open_on_run = false },
    quickfix = { enabled = false },
  },
  config = function(_, opts)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
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
    }, neotest_ns)

    -- stole this from lazy vim, not sure what it does lol
    if opts.adapters then
      local adapters = {}
      for name, config in pairs(opts.adapters or {}) do
        if config ~= false then
          local adapter = require(name)
          if type(config) == "table" and not vim.tbl_isempty(config) then
            local meta = getmetatable(adapter)
            if adapter.setup then
              adapter.setup(config)
            elseif adapter.adapter then
              adapter.adapter(config)
              adapter = adapter.adapter
            elseif meta and meta.__call then
              adapter = adapter(config)
            else
              error("Adapter " .. name .. " does not support setup")
            end
          end
          adapters[#adapters + 1] = adapter
        end
      end
      opts.adapters = adapters
    end

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
