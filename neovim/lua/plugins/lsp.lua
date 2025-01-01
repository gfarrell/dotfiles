return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local kmopts = { noremap = true, silent = true }
      vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, opts)

      -- Buffer-specific LSP Keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufopts = { buffer = args.buf, silent = true, noremap = true }
          vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
        end,
      })

      -- Configure different LSPs
      local lsp = require("lspconfig")
      lsp.hls.setup{
        cabalFormattingProvider = "cabalfmt",
        formattingProvider = "ormolu"
      }
      lsp.sqlls.setup{}
      lsp.pylsp.setup{}
      lsp.clojure_lsp.setup{}
      lsp.nil_ls.setup{
        ['nil'] = {
          formatting = {
            command = { "alejandra" },
          },
        },
      }
      require'lspconfig'.ts_ls.setup{}
    end
  }
}
