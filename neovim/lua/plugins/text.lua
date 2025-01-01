return {
  'tpope/vim-commentary',         -- Make it easier to comment things out
  'tpope/vim-surround',           -- "Surrounding" objects
  'wellle/targets.vim',           -- Useful extra targets
  {
    'dhruvasagar/vim-table-mode',
    init = function()
      vim.g.table_mode_corner = "|"
    end,
  },
}
