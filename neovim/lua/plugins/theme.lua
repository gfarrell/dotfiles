return {
  {
    'sainnhe/everforest',           
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.cmd([[colorscheme everforest]])
      vim.opt.termguicolors = true -- enable 24b colours
      vim.g.everforest_better_performance = 1
      vim.g.everforest_background = "soft"
    end
  },
  'vim-airline/vim-airline',      -- Lightweight status bar
  'Pocco81/true-zen.nvim',        -- Zen mode to remove distractions
}
