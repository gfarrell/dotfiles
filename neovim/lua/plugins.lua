-- Plugin configuration
--

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Themes
  use 'sainnhe/everforest'           -- Everforest theme
  use 'vim-airline/vim-airline'      -- Lightweight status bar
  use 'frazrepo/vim-rainbow'         -- Highlight matching parens

  -- Nice utilities
  use 'scrooloose/nerdtree'          -- File tree view
  use 'terryma/vim-multiple-cursors' -- Super useful multi-cursor support
  use 'junegunn/fzf'                 -- Fuzzy finding with FZF
  use 'junegunn/fzf.vim'             -- FZF vim plugin (need both)
  use 'tpope/vim-fugitive'           -- Git plugin
  use 'airblade/vim-gitgutter'       -- Show git status in margins
  use 'Pocco81/true-zen.nvim'        -- Zen mode to remove distractions
  use 'mattn/calendar-vim'           -- Calendar plugin

  -- Text objects and movements
  use 'tpope/vim-commentary'         -- Make it easier to comment things out
  use 'tpope/vim-surround'           -- "Surrounding" objects
  use 'wellle/targets.vim'           -- Useful extra targets

  -- Language utilities
  use 'neovim/nvim-lspconfig'        -- Sane LSP configurations
  use 'hrsh7th/vim-vsnip'            -- Snippets
  use 'hrsh7th/cmp-vsnip'            -- Autcomplete snippets 
  use 'hrsh7th/cmp-nvim-lsp'         -- Autocompletion from LSP
  use 'hrsh7th/cmp-buffer'           -- Autocomplete buffers
  use 'hrsh7th/cmp-path'             -- Autocomplete paths
  use 'hrsh7th/nvim-cmp'             -- Autocompleter
  use {                              -- Treesitter utils
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter"
  }

  -- Language-specific plugins
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use 'chrisbra/csv.vim'
  use 'rust-lang/rust.vim'
  use 'HerringtonDarkholme/yats.vim'
  use 'vimwiki/vimwiki'
end)
