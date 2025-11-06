return { -- buffer management menu
  "j-morano/buffer_manager.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    short_file_names = false, -- must be false to use format_function
    format_function = function(filepath)
      if filepath == "" then
        return "[No Name]"
      end

      local filename = vim.fn.fnamemodify(filepath, ":t")
      local filedir = vim.fn.fnamemodify(filepath, ":h")
      local project_root = vim.loop.cwd()

      local relative_dir
      if filedir:sub(1, #project_root) == project_root then
        relative_dir = filedir:sub(#project_root + 2) -- +2 removes trailing slash
      else
        relative_dir = vim.fn.fnamemodify(filedir, ":~:.") -- fallback
      end

      return string.format("%s - %s", filename, relative_dir)
    end,
  },
  config = function(_, opts)
    require("buffer_manager").setup(opts)

    -- colour unsaved files
    vim.api.nvim_set_hl(
      0,
      "BufferManagerModified",
      { fg = vim.g.latte_colours["mauve"] }
    )
  end,
  keys = {
    {
      "<Tab>",
      "<Cmd>lua require('buffer_manager.ui').toggle_quick_menu()<CR>",
      mode = "n",
    },
    {
      "<A-.>",
      "<CMD>lua require('buffer_manager.ui').nav_next()<CR>",
      mode = "n",
      desc = "next buffer",
    },
    {
      "<A-,>",
      "<CMD>lua require('buffer_manager.ui').nav_prev()<CR>",
      mode = "n",
      desc = "previous buffer",
    },
  },
}
