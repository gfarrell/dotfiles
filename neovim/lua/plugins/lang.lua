return {
  -- Language parsing with Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install { 
        "bash",
        "c",
        "clojure",
        "cpp",
        "css",
        "csv",
        "desktop",
        "dhall",
        "dockerfile",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "haskell",
        "html",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
        "purescript",
        "query",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "xresources",
        "yaml",
      }
    end
  },

  -- LISP
  'guns/vim-sexp',
  'tpope/vim-sexp-mappings-for-regular-people',

  -- CSV
  'chrisbra/csv.vim',

  -- Rust
  'rust-lang/rust.vim',

  -- Haskell
  {
    'mrcjkb/haskell-tools.nvim',
    version = "^6",
    lazy = false,
    init = function()
      vim.g.haskell_tools = {
        hls = {
          settings = {
            cabalFormattingProvider = "cabal-fmt",
            checkParents = "CheckOnSave",
            checkProject = true,
            formattingProvider = "ormolu",
            maxCompletions = 40,
            plugin = {
              rename = {
                config = {
                  crossModule = false
                },
                globalOn = true
              },
              retrie = {
                globalOn = true
              },
              splice = {
                globalOn = true
              },
              stan = {
                globalOn = false
              }
            },
            sessionLoading = "singleComponent"
          }
        }
      }
    end
  },

  -- Typescript
  'HerringtonDarkholme/yats.vim',
}
