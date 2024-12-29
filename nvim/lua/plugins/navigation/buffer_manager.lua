return { -- buffer management menu
  "j-morano/buffer_manager.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    order_buffers = "bufnr:reverse",
  },
  config = function ()
    vim.api.nvim_set_hl(0, "BufferManagerModified", { fg = vim.g.latte_colours["mauve"] })
  end
}
