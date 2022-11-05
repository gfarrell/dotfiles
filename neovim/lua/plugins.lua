-- Plugin configuration
--

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Themes
  use 'morhetz/gruvbox'              -- Gruvbox theme
  use 'vim-airline/vim-airline'      -- Lightweight status bar
  use 'frazrepo/vim-rainbow'         -- Highlight matching parens

  -- Nice utilities
  use 'scrooloose/nerdtree'          -- File tree view
  use 'terryma/vim-multiple-cursors' -- Super useful multi-cursor support
  use 'junegunn/fzf'                 -- Fuzzy finding with FZF
  use 'junegunn/fzf.vim'             -- FZF vim plugin (need both)
  use 'tpope/vim-fugitive'           -- Git plugin
  use 'airblade/vim-gitgutter'       -- Show git status in margins

  -- Text objects and movements
  use 'tpope/vim-commentary'         -- Make it easier to comment things out
  use 'tpope/vim-surround'           -- "Surrounding" objects
  use 'wellle/targets.vim'           -- Useful extra targets

  -- Language utilities
  use 'neovim/nvim-lspconfig'        -- Sane LSP configurations

  -- Language-specific plugins
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use 'chrisbra/csv.vim'
  use 'rust-lang/rust.vim'
  use 'HerringtonDarkholme/yats.vim'
end)
