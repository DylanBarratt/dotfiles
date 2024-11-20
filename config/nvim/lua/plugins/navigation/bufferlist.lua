return {
  'EL-MASTOR/bufferlist.nvim',
  lazy = true,
  dependencies = 'nvim-tree/nvim-web-devicons',
  cmd = 'BufferList',
  opts = {
    {
      keymap = {
        close_buf_prefix = 'c',
        force_close_buf_prefix = 'f',
        save_buf = 's',
        multi_close_buf = 'm',
        multi_save_buf = 'w',
        save_all_unsaved = 'a',
        close_all_saved = 'd0',
        toggle_path = 'p',
        close_bufferlist = 'q',
      },
      win_keymaps = {}, -- add keymaps to the BufferList window
      bufs_keymaps = {}, -- add keymaps to each line number in the BufferList window
      width = 40,
      prompt = '', -- for multi_{close,save}_buf prompt
      save_prompt = '󰆓 ',
      top_prompt = true, -- set this to false if you want the prompt to be at the bottom of the window instead of on top of it.
      show_path = false, -- show the relative paths the first time BufferList window is opened
    },
  },
}
