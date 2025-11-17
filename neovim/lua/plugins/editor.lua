return {
  -- Highlight matching parens
  'frazrepo/vim-rainbow',
  -- Various bits and pieces for improving the editor
  {
    'folke/snacks.nvim',
    opts = {
      indent = {
        enabled = true,
        scope = {
          enabled = false
        }
      }
    }
  },
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

  -- Compile mode
  {
    "ej-shafran/compile-mode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim",
    },
    config = function()
      vim.g.compile_mode = {
        baleia_setup = true,
        bang_expansion = true
      }
    end
  },

  -- Aerial for code outline
  {
    'stevearc/aerial.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    init = function()
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end,
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end
    }
  }
}
