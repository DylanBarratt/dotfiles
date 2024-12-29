return { -- better word traversal
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "x" } },
    },
    opts = {
      skipInsignificantPunctuation = false,
      consistentOperatorPending = false, -- see "Consistent Operator-pending Mode" in the README
      subwordMovement = true,
      customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
    },
}
