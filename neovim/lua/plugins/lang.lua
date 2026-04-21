return {
  -- Language parsing with Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      treesitter.setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        ensure_installed = {
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
          "norg",
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
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          }
        },
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true, -- only load with the dependent
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
          },
        },
      })
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
