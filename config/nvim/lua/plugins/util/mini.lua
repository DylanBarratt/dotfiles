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

      H.get_filesize = function()
        local size = vim.fn.getfsize(vim.fn.getreg '%')
        if size < 1024 then
          return string.format('%dB', size)
        elseif size < 1048576 then
          return string.format('%.2fKiB', size / 1024)
        else
          return string.format('%.2fMiB', size / 1048576)
        end
      end

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
          filetype = filetype .. ' ' .. H.get_icon(filetype) .. ' '
        end

        -- Construct output string if truncated or buffer is not normal
        if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= '' then
          return filetype
        end

        local size = H.get_filesize()

        return string.format('%s [%s]', filetype, size)
      end

      statusline.section_location = function()
        local currentLine = vim.fn.line '.'
        local total_lines = vim.fn.line '$'
        local percent = math.floor((currentLine / total_lines) * 100)
        return tostring(percent) .. '%%'
      end
    end,
  },
}
