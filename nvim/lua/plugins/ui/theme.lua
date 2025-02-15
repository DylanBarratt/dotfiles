return { -- theme theme theme cat theme
  "catppuccin/nvim",
  priority = 1000,
  opts = {
    flavour = "latte", -- latte, frappe, macchiato, mocha
    -- background = { -- :h background
    --   light = 'latte',
    --   dark = 'mocha',
    -- },
    show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "light",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
      cmp = true,
      blink_cmp = true,
      gitsigns = true,
      treesitter = true,
      neotest = true,
      alpha = true,
      mason = true,
      indent_blankline = true,
      which_key = false,
      native_lsp = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")

    -- https://catppuccin.com/palette
    -- for use in other plugins custom colours
    vim.g.latte_colours = require("catppuccin.palettes").get_palette("latte")
  end,
}
