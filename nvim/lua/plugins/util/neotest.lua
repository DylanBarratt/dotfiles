local JEST = "neotest-jest"
local VITEST = "neotest-vitest"

local function fileExists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
end

local function getTestRunner()
  if
    fileExists(vim.fn.getcwd() .. "/jest.config.ts")
    or fileExists(vim.fn.getcwd() .. "/jest.config.js")
  then
    return JEST
  elseif fileExists(vim.fn.getcwd() .. "/vitest.config.ts") then
    return VITEST
  else
    print("No test config found")
    return nil
  end
end

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
      [JEST] = {
        jestCommand = "yarn run jest --json",
      },
      [VITEST] = {
        filter_dir = function(name)
          return name ~= "node_modules"
        end,
        vitestCommand = "yarn run vitest",
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

    -- decide test runner to use by config file at root
    local testRunner = getTestRunner()

    local adapters = {}
    if testRunner ~= nil and opts.adapters[testRunner] ~= nil then
      adapters[#adapters + 1] = require(testRunner)(opts.adapters[testRunner])
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
