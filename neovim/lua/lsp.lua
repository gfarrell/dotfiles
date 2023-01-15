-- Autocomplete
vim.opt.completeopt = "menu,menuone,noselect"
local cmp = require'cmp'
cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' }
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
  })
})

-- General LSP Keymaps
local kmopts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)

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
    vim.keymap.set({ 'n', 'x' }, '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  end,
})

-- Enable LSP configurations
require'lspconfig'.hls.setup{}
require'lspconfig'.sqlls.setup{}
require'lspconfig'.elmls.setup{}
