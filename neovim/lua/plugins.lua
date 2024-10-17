-- Plugin configuration
--

return {
  -- Themes
  'sainnhe/everforest',           -- Everforest theme
  'vim-airline/vim-airline',      -- Lightweight status bar
  'frazrepo/vim-rainbow',         -- Highlight matching parens

  -- Nice utilities
  'scrooloose/nerdtree',          -- File tree view
  'terryma/vim-multiple-cursors', -- Super useful multi-cursor support
  'junegunn/fzf',                 -- Fuzzy finding with FZF
  'junegunn/fzf.vim',             -- FZF vim plugin (need both)
  'tpope/vim-fugitive',           -- Git plugin
  'airblade/vim-gitgutter',       -- Show git status in margins
  'Pocco81/true-zen.nvim',        -- Zen mode to remove distractions
  'mattn/calendar-vim',           -- Calendar plugin
  { 
    'folke/which-key.nvim',
    event = 'VeryLazy'
  },

  -- Text objects and movements
  'tpope/vim-commentary',         -- Make it easier to comment things out
  'tpope/vim-surround',           -- "Surrounding" objects
  'wellle/targets.vim',           -- Useful extra targets

  -- Language utilities
  'neovim/nvim-lspconfig',        -- Sane LSP configurations
  'hrsh7th/vim-vsnip',            -- Snippets
  'hrsh7th/cmp-vsnip',            -- Autcomplete snippets 
  'hrsh7th/cmp-nvim-lsp',         -- Autocompletion from LSP
  'hrsh7th/cmp-buffer',           -- Autocomplete buffers
  'hrsh7th/cmp-path',             -- Autocomplete paths
  'hrsh7th/nvim-cmp',             -- Autocompleter
  {                              -- Treesitter utils
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate"
  },
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- Language-specific plugins
  'guns/vim-sexp',
  'tpope/vim-sexp-mappings-for-regular-people',
  'chrisbra/csv.vim',
  'rust-lang/rust.vim',
  'HerringtonDarkholme/yats.vim',
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_list = {
        {
          name = "GTF KB",
          path = "~/notes/gtf-kb",
          path_html = "~/notes/gtf-kb.html"
        },
      }
      vim.g.vimwiki_auto_chdir = 1
    end,
  }
}
