return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  dependencies = { "rafamadriz/friendly-snippets" },

  -- use a release tag to download pre-built binaries
  version = "v0.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  ---@diagnostic disable: missing-fields
  opts = {
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-CR>"] = { "select_and_accept" },

      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-Up>"] = { "snippet_forward", "fallback" },
      ["<C-Down>"] = { "snippet_backward", "fallback" },
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 0,
      },
      -- Displays a preview of the selected item on the current line
      ghost_text = {
        enabled = false,
      },
    },

    -- Experimental signature help support
    signature = {
      enabled = true,
    },
  },
}
