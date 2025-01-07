return {
  "chrisgrieser/nvim-rulebook",
  keys = {
    -- stylua: ignore start
    {"<leader>bi", function() require("rulebook").ignoreRule() end, mode = "n", desc = "[b]ook [i]gnore" },
    {"<leader>bl", function() require("rulebook").lookupRule() end, mode = "n", desc = "[b]ook [l]ookup" },
    {"<leader>by", function() require("rulebook").yankDiagnosticCode() end, mode = "n", desc = "[b]ook [y]ank" },
    {"<leader>bf", function() require("rulebook").suppressFormatter() end, mode = { "n", "x" }, desc = "[b]ook [s]uppress" },
    -- stylua: ignore end
  },
}
