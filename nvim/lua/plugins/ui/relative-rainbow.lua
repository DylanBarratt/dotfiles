return { -- change colours for relative jump numbers
  "fluxdiv/relative-rainbow.nvim",
  event = { "VeryLazy" },
  config = function()
    -- in a function to access the global latte_colours
    require("relative-rainbow").setup({
      {
        distance_from_cursor = 5,
        fg = vim.g.latte_colours["mauve"],
        fg_tint_multiplier = 1,
        bg_tint_multiplier = 0.5,
        fill = false,
        hl_target = "number_column",
      },
      { -- <C-d> and <C-u> jump distance
        distance_from_cursor = 12,
        fg = vim.g.latte_colours["mauve"],
        fg_tint_multiplier = 1,
        bg_tint_multiplier = 0.5,
        fill = false,
        hl_target = "number_column",
      },
    })
  end,
}
