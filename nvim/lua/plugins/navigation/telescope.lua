return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",

      build = "make",

      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-frecency.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local telescope_custom_actions = {}

    function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local num_selections = #picker:get_multi_selection()
      if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
      end
      actions.send_selected_to_qflist(prompt_bufnr)
      vim.cmd("cfdo " .. open_cmd)
    end

    function telescope_custom_actions.multi_selection_open(prompt_bufnr)
      telescope_custom_actions._multiopen(prompt_bufnr, "edit")
    end

    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { ".git/", "^./.git/", "^node_modules/" },
        mappings = {
          i = {
            ["<CR>"] = telescope_custom_actions.multi_selection_open,
            ["+"] = actions.toggle_selection,
            ["_"] = actions.select_all,
            ["<S-Tab>"] = actions.move_selection_previous,
            ["<Tab>"] = actions.move_selection_next,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })
    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "frecency")

    local builtin = require("telescope.builtin")
    -- stylua: ignore start
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [s]elect Telescope' })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[s]earch Recent Files" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[s]earch by [G]rep" })
    -- stylua: ignore end

    vim.keymap.set("n", "<leader><leader>", function()
      local cwd = vim.fn.getcwd()
      require("telescope").extensions.frecency.frecency(
        require("telescope.themes").get_ivy({
          layout_config = {
            preview_width = 0.5,
          },
          workspace = "CWD",
          cwd = cwd,
          prompt_title = "Frecency",
          default_text = "",
        })
      )
    end, { desc = "Find Files" })
  end,
}
