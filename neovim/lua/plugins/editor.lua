return {
  -- Highlight matching parens
  'frazrepo/vim-rainbow',
  -- Super useful multi-cursor support
  'terryma/vim-multiple-cursors',
  -- Show a helper for keybinds
  {
    'folke/which-key.nvim',
    event = 'VeryLazy'
  },
  -- Git support
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',

  -- Displaying other things
  'mattn/calendar-vim',
  '3rd/image.nvim',

  -- Bidirectional support (e.g. for editing Hebrew text)
  { 'mcookly/bidi.nvim',
    lazy = true,
    event = "BufEnter *.typ", -- only for typst files
    config = true
  },

  -- Github support (for reviewing PRs)
  { 'pwntester/octo.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    cmd = "Octo",
    config = true
  },
}
