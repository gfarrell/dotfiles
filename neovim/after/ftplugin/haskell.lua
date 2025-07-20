local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()
local default_opts = { noremap = true, silent = true, buffer = bufnr, }

local function opts(...)
  local result = {}
  for k, v in pairs(default_opts) do
    result[k] = v
  end
  for _, t in ipairs({...}) do
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end

-- Search hoogle for the signature under the cursor
vim.keymap.set('n', '<Leader>hths', ht.hoogle.hoogle_signature, opts({ desc = "Search hoogle for this signature" }))

-- Start a GHCi repl for the current package
vim.keymap.set('n', '<Leader>htrt', ht.repl.toggle, opts({ desc = "Start a GHCi repl for the current package" }))

-- Start a GHCi repl for the current buffer
vim.keymap.set('n', '<Leader>htrb', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts({ desc = "Start a GHCi repl for the current buffer" }))
