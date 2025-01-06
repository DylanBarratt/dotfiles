return { -- easy create telescope pickers
  -- TODO: replace this plugin, probs unneeded and takes loads of time to load
  "axkirillov/easypick.nvim",
  requires = "nvim-telescope/telescope.nvim",
  event = { "BufEnter" },
  keys = {
    { "<Leader>sc", "<Cmd>Easypick changed_files<CR>", mode = "n", desc = "Search git [c]hanged files" },
    { "<Leader>p", "<Cmd>Easypick<CR>", mode = "n", desc = "All [p]ickers" },
  },
  config = function()
    local easypick = require("easypick")
    local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
    local base_branch = vim.fn.system(get_default_branch) or "main"

    require("easypick").setup({
      pickers = {
        -- diff current branch with base_branch and show files that changed with respective diffs in preview
        {
          name = "changed_files",
          command = "git diff --name-only",
          previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
        },

        -- list files that have conflicts with diffs in preview
        {
          name = "conflicts",
          command = "git diff --name-only --diff-filter=U --relative",
          previewer = easypick.previewers.file_diff(),
        },
      },
    })
  end,
}
