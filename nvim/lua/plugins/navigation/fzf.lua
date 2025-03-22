return { -- faster search?
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    fzf_opts = {},
    winopts = {
      border = "none",
      preview = {
        hidden = true,
        border = "none",
        scrollbar = "border",
      },
    },
    fzf_colors = {
      gutter = "#303446",
      fg = "#c6d0f5",
      bg = "#303446",
      hl = "#ca9ee6",
      ["fg+"] = "#babbf1",
      ["bg+"] = "#292c3c",
      info = "#a6d189",
      border = "#f4b8e4",
      prompt = "#8caaee",
      pointer = "#a6d189",
      header = "#a6adc8",
    },
    files = {
      formatter = "path.filename_first",
    },
  },
  event = "VimEnter",
  config = function(_, opts)
    local fzf_lua = require("fzf-lua")
    fzf_lua.setup(opts)

    local function get_most_common_extension()
      local handle = io.popen(
        "rg --files | awk -F. 'NF>1{print $NF}' | sort | uniq -c | sort -nr | head -n1"
      )
      if not handle then
        return nil
      end
      local result = handle:read("*l")
      handle:close()

      if result then
        local count, ext = result:match("(%d+)%s+(%S+)")
        return ext
      end
      return nil
    end

    local function fzf_files_filtered()
      local ext = get_most_common_extension()
      if ext then
        fzf_lua.files({ cmd = "rg --files -g '*." .. ext .. "'" })
      else
        fzf_lua.files()
      end
    end

    vim.keymap.set(
      "n",
      "<leader><leader>",
      fzf_files_filtered,
      { desc = "find common files" }
    )

    vim.keymap.set(
      "n",
      "<leader>sf",
      "<CMD>FzfLua files<CR>",
      { desc = "find files" }
    )

    vim.keymap.set(
      "n",
      "<leader>sr",
      "<CMD>FzfLua grep<CR>",
      { desc = "[s]earch [r]esume" }
    )

    vim.keymap.set(
      "n",
      "<leader>sg",
      "<CMD>FzfLua live_grep<CR>",
      { desc = "[s]earch [g]rep" }
    )

    vim.keymap.set(
      "n",
      "<leader>sGs",
      "<CMD>FzfLua git_status<CR>",
      { desc = "[s]earch [G]it [s]tatus" }
    )

    vim.keymap.set(
      "n",
      "<leader>sGc",
      "<CMD>FzfLua git_bcommits<CR>",
      { desc = "[s]earch [G]it buffer [c]ommits" }
    )

    vim.keymap.set(
      "n",
      "<leader>sGC",
      "<CMD>FzfLua git_commits<CR>",
      { desc = "[s]earch [G]it [C]ommits" }
    )

    vim.keymap.set(
      "n",
      "<leader>sw",
      "<CMD>FzfLua grep_cword<CR>",
      { desc = "[s]earch [w]ord" }
    )

    vim.keymap.set(
      "n",
      "<leader>sv",
      "<CMD>FzfLua grep_visual<CR>",
      { desc = "[s]earch [v]isual" }
    )
  end,
}
