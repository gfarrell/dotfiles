return {
  -- Nicer file browser
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    lazy = false,
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require('neo-tree.events')
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move }
      })
    end
  },
  -- Edit file tree like a buffer
  {
    'stevearc/oil.nvim',
    opts= {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false
  },
  -- Open files in remote repo
  {'ciehanski/nvim-git-line', opts = {
    action_key = "<leader>gg",
    action_key_line = "<leader>gl"
  }},
}
