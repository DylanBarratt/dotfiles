return { -- buffer management menu
  "j-morano/buffer_manager.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    order_buffers = "bufnr:reverse",
  },
  config = function()
    -- colour unsaved files
    vim.api.nvim_set_hl(0, "BufferManagerModified", { fg = vim.g.latte_colours["mauve"] })
  end,
  keys = {
    { "<Tab>", "<Cmd>lua require('buffer_manager.ui').toggle_quick_menu()<CR>", mode = "n" },
    { "<A-.>", "<CMD>lua require('buffer_manager.ui').nav_next()<CR>", mode = "n", desc = "next buffer" },
    { "<A-,>", "<CMD>lua require('buffer_manager.ui').nav_prev()<CR>", mode = "n", desc = "previous buffer" },
  },
}
