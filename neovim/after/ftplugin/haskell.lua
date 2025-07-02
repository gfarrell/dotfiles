local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

-- Search hoogle for the signature under the cursor
vim.keymap.set('n', '<Leader>hss', ht.hoogle.hoogle_signature, opts)

-- Start a GHCi repl for the current package
vim.keymap.set('n', '<Leader>hsrp', ht.repl.toggle, opts)

-- Start a GHCi repl for the current buffer
vim.keymap.set('n', '<Leader>hsrb', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
