-- Enable LSP configurations
require'lspconfig'.hls.setup{}

-- LSP Keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- autocomplete on <C-.>
    vim.keymap.set('i', '<C-.>', vim.lsp.buf.completion)
    -- format on ,f
    vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, { buffer = args.buf })
    -- go to next and previous diagnostics
    vim.keymap.set('n', '<Leader>dj', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<Leader>dk', vim.diagnostic.goto_prev)
    -- set hover
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    -- find all references
    vim.keymap.set('n', 'R', vim.lsp.buf.references, { buffer = args.buf })
    -- rename symbol
    vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, { buffer = args.buf })
  end,
})
