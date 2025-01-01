return {
  -- Language parsing with Treesitter
  {                              
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate"
  },
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- LISP
  'guns/vim-sexp',
  'tpope/vim-sexp-mappings-for-regular-people',
  
  -- CSV
  'chrisbra/csv.vim',
  
  -- Rust
  'rust-lang/rust.vim',

  -- Typescript
  'HerringtonDarkholme/yats.vim',
}
