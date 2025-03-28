return {
  -- Telescope for finding things
  { 
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({})
      local builtin = require('telescope.builtin')
      -- Set keybinds
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep through files' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'View buffers' })
      vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'View registers' })
      -- LSP specific 
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'View diagnostics (LSP)' })
      vim.keymap.set('n', '<leader>fsd', builtin.lsp_document_symbols, { desc = 'Symbols in this document (LSP)' })
      vim.keymap.set('n', '<leader>fsw', builtin.lsp_workspace_symbols, { desc = 'Symbols in this workspace (LSP)' })
    end
  },
}
