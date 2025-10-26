function extend(...)
  local result = {}
  for _, t in ipairs({...}) do
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end

return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local kmopts = { noremap = true, silent = true }
      vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, extend(kmopts, { desc = "Show diagnostics" }))
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, extend(kmopts, { desc = "Next diagnostic" }))
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, extend(kmopts, { desc = "Previous diagnostic" }))
      vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, extend(kmopts, { desc = "Fill quickfix list with diagnostics" }))

      -- Buffer-specific LSP Keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufopts = extend(kmopts, { buffer = args.buf })
          vim.keymap.set('n', '<Leader>gf', vim.lsp.buf.format, extend(bufopts, { desc = "Format buffer (LSP)" }))
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gdd', vim.lsp.buf.definition, extend(bufopts, { desc = "Go to definition (LSP)" }))
          vim.keymap.set('n', 'gdv', function()
            vim.cmd('vsplit')
            vim.lsp.buf.definition()
          end, extend(bufopts, { desc = "Go to definition in a vsplit (LSP)" }))
          vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, extend(bufopts, { desc = "Go to type definition (LSP)"}))
          vim.keymap.set('n', 'grr', vim.lsp.buf.references, extend(bufopts, { desc = "Show references (LSP)" }))
          vim.keymap.set('n', 'grn', vim.lsp.buf.rename, extend(bufopts, { desc = "Rename symbol (LSP)" }))
          vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, extend(bufopts, { desc = "Show code actions (LSP)" }))
          vim.keymap.set('n', 'grl', vim.lsp.codelens.run, extend(bufopts, { desc = "Run codelens (LSP)" }))
        end,
      })

      -- Configure different LSPs
      -- With haskell-tools.nvim installed we don't setup HLS here!
      vim.lsp.enable('sqlls')
      vim.lsp.enable('basedpyright')
      vim.lsp.enable('clojure_lsp')
      vim.lsp.enable('nil_ls')
      vim.lsp.config('nil_ls', {
        ['nil'] = {
          formatting = {
            command = { "alejandra" },
          },
        },
      })
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('tinymist') -- typst lsp
      vim.lsp.enable('lua_ls')
    end
  }
}
