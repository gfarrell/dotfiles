return {
  -- Snippets
  'hrsh7th/vim-vsnip',

  -- Autocompletion
  'hrsh7th/cmp-vsnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  {
    'hrsh7th/nvim-cmp',
    config = function()
      vim.opt.completeopt = "menu,menuone,noselect"

      local cmp = require("cmp")
      require("cmp").setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = "neorg" },
        }),

        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true })
        }),

        enabled = function()
          local context = require'cmp.config.context'

          -- disable completion in comments
          if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
            return false
          end

          -- disable completion in git commit messages, vimwiki, and markdown
          if vim.bo.filetype == "gitcommit" or vim.bo.filetype == "markdown" then
            return false
          end

          return true
        end
      })
    end
  }
}
