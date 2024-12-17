return { -- change colours for relative jump numbers
  "fluxdiv/relative-rainbow.nvim",
  config = function()
    require("relative-rainbow").setup({
      {
        distance_from_cursor = 5,
        fg = vim.g.latte_colours["mauve"],
        fg_tint_multiplier = 1,
        bg_tint_multiplier = 0.5,
        fill = false,
        hl_target = "number_column",
      },
    })
  end,
}
