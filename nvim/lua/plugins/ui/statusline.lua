return { -- statusline
  -- this is a heavily modified version, stealing lots of source from the original plugin
  "echasnovski/mini.statusline",
  version = "*",
  init = function()
    local statusline = require("mini.statusline")

    local H = {}

    H.ensure_get_icon = function()
      local has_devicons, devicons = pcall(require, "nvim-web-devicons")
      if not has_devicons then
        return
      end
      H.get_icon = function()
        return (devicons.get_icon(vim.fn.expand("%:t"), nil, { default = true }))
      end
    end

    local CTRL_S = vim.api.nvim_replace_termcodes("<C-S>", true, true, true)
    local CTRL_V = vim.api.nvim_replace_termcodes("<C-V>", true, true, true)
    H.modes = setmetatable({
      ["n"] = { long = "Normal", short = "N", hl = "MiniStatuslineModeNormal" },
      ["v"] = { long = "Visual", short = "V", hl = "MiniStatuslineModeVisual" },
      ["V"] = { long = "V-Line", short = "V-L", hl = "MiniStatuslineModeVisual" },
      [CTRL_V] = { long = "V-Block", short = "V-B", hl = "MiniStatuslineModeVisual" },
      ["s"] = { long = "Select", short = "S", hl = "MiniStatuslineModeVisual" },
      ["S"] = { long = "S-Line", short = "S-L", hl = "MiniStatuslineModeVisual" },
      [CTRL_S] = { long = "S-Block", short = "S-B", hl = "MiniStatuslineModeVisual" },
      ["i"] = { long = "Insert", short = "I", hl = "MiniStatuslineModeInsert" },
      ["R"] = { long = "Replace", short = "R", hl = "MiniStatuslineModeReplace" },
      ["c"] = { long = "Command", short = "C", hl = "MiniStatuslineModeCommand" },
      ["r"] = { long = "Prompt", short = "P", hl = "MiniStatuslineModeOther" },
      ["!"] = { long = "Shell", short = "Sh", hl = "MiniStatuslineModeOther" },
      ["t"] = { long = "Terminal", short = "T", hl = "MiniStatuslineModeOther" },
    }, {
      -- By default return 'Unknown' but this shouldn't be needed
      __index = function()
        return { long = "Unknown", short = "U", hl = "%#MiniStatuslineModeOther#" }
      end,
    })

    statusline.setup({})

    statusline.section_mode = function(args)
      local mode_info = H.modes[vim.fn.mode()]

      local mode = mode_info.short
      -- local mode = mode_info.long

      return mode, mode_info.hl
    end

    statusline.section_git = function(args)
      if statusline.is_truncated(args.trunc_width) then
        return ""
      end

      local summary = vim.b.gitsigns_head
      if summary == nil then
        return ""
      end

      return "" .. " " .. (summary == "" and "-" or summary)
    end

    statusline.section_diagnostics = function(args)
      if statusline.is_truncated(args.trunc_width) or not vim.diagnostic.is_enabled({ bufnr = 0 }) then
        return ""
      end

      -- dont wanna know any others...
      local diagnostic_levels = {
        { name = "ERROR", sign = " " },
        -- { name = 'WARN', sign = 'W' },
        -- { name = 'INFO', sign = 'I' },
        -- { name = 'HINT', sign = 'H' },
      }

      local count = vim.diagnostic.count(0)
      local severity, _, t = vim.diagnostic.severity, args.signs or {}, {}
      for _, level in ipairs(diagnostic_levels) do
        local n = count[severity[level.name]] or 0
        -- Add level info only if diagnostic is present
        if n > 0 then
          table.insert(t, level.sign .. n)
        end
      end
      if #t == 0 then
        return ""
      end

      return table.concat(t, "")
    end

    statusline.section_filename = function(args)
      -- In terminal always use plain name
      if vim.bo.buftype == "terminal" then
        return "%t"
      end

      -- relative path
      return vim.fn.expand("%:.")
    end

    statusline.section_fileinfo = function(args)
      local filetype = vim.bo.filetype

      -- Don't show anything if there is no filetype
      if filetype == "" then
        return ""
      end

      -- Add filetype icon
      H.ensure_get_icon()
      if H.get_icon ~= nil then
        filetype = H.get_icon()
      end

      -- Construct output string if truncated or buffer is not normal
      if statusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= "" then
        return filetype
      end

      return string.format("%s ", filetype)
    end

    statusline.section_location = function()
      local currentLine = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local percent = math.floor((currentLine / total_lines) * 100)
      return string.format("%s %sL", tostring(percent) .. "%%", total_lines)
    end

    -- disable the rest
    statusline.section_diff = function() end
    statusline.section_lsp = function() end
  end,
}
