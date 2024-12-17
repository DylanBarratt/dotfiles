return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    local git_branch = function()
      local summary = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
      if summary == "" then
        return ""
      end
      return " " .. summary
    end

    local status_ok, alpha = pcall(require, "alpha")
    if not status_ok then
      return
    end

    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[  ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·.  ]],
      [[ •█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪ ]],
      [[ ▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█· ]],
      [[ ██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌ ]],
      [[ ▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀ ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("r", "last session", "<cmd>SessionManager load_current_dir_session <CR>"),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("m", "󱁤  Mason", ":Mason<CR>"),
      dashboard.button("<leader>", "󰍉  Which Key", ""),
      dashboard.button("q", "󰅙  Quit Neovim", ":qa<CR>"),
    }

    dashboard.section.footer.val = git_branch()

    dashboard.section.footer.opts.hl = "Comment"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Comment"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
