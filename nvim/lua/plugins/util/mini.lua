return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      require('mini.comment').setup()

      -- statusline
      local statusline = require 'mini.statusline'

      local H = {}

      H.ensure_get_icon = function()
        local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
        if not has_devicons then
          return
        end
        H.get_icon = function()
          return (devicons.get_icon(vim.fn.expand '%:t', nil, { default = true }))
        end
      end

      statusline.setup { use_icons = vim.g.have_nerd_font }

      statusline.section_fileinfo = function(args)
        local filetype = vim.bo.filetype

        -- Don't show anything if there is no filetype
        if filetype == '' then
          return ''
        end

        -- Add filetype icon
        H.ensure_get_icon()
        if H.get_icon ~= nil then
          filetype = H.get_icon()
        end

        -- Construct output string if truncated or buffer is not normal
        if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= '' then
          return filetype
        end

        return string.format('%s ', filetype)
      end

      statusline.section_location = function()
        local currentLine = vim.fn.line '.'
        local total_lines = vim.fn.line '$'
        local percent = math.floor((currentLine / total_lines) * 100)
        return string.format('%s %sL', tostring(percent) .. '%%', total_lines)
      end

      MiniStatusline.section_git = function(args)
        if MiniStatusline.is_truncated(args.trunc_width) then
          return ''
        end

        local summary = vim.b.gitsigns_head
        if summary == nil then
          return ''
        end

        return '' .. ' ' .. (summary == '' and '-' or summary)
      end

      MiniStatusline.section_diagnostics = function(args)
        if MiniStatusline.is_truncated(args.trunc_width) or not vim.diagnostic.is_enabled { bufnr = 0 } then
          return ''
        end

        local diagnostic_levels = {
          { name = 'ERROR', sign = ' ' },
          -- { name = 'WARN', sign = 'W' },
          -- { name = 'INFO', sign = 'I' },
          -- { name = 'HINT', sign = 'H' },
        }
        -- Construct string parts
        local count = vim.diagnostic.count(0)
        local severity, signs, t = vim.diagnostic.severity, args.signs or {}, {}
        for _, level in ipairs(diagnostic_levels) do
          local n = count[severity[level.name]] or 0
          -- Add level info only if diagnostic is present
          if n > 0 then
            table.insert(t, level.sign .. n)
          end
        end
        if #t == 0 then
          return ''
        end

        return table.concat(t, '')
      end

      -- disable some
      statusline.section_diff = function() end
      -- statusline.section_lsp = function() end
      statusline.section_filename = function() end
    end,
  },
}
