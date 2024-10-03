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
  }),

  enabled = function()
    local context = require'cmp.config.context'

    -- disable completion in comments
    if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
      return false
    end

    -- disable completion in git commit messages, vimwiki, and markdown
    if vim.bo.filetype == "gitcommit" or vim.bo.filetype == "vimwiki" or vim.bo.filetype == "markdown" then
      return false
    end

    return true
  end
})

-- General LSP Keymaps
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
    vim.keymap.set({ 'n', 'x' }, '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  end,
})

-- Enable LSP configurations
require'lspconfig'.hls.setup{
  cabalFormattingProvider = "cabalfmt",
  formattingProvider = "ormolu"
  -- custom HLS for testing
  -- cmd = {"/home/gideon/projects/haskell-language-server/dist-newstyle/build/x86_64-linux/ghc-9.4.7/haskell-language-server-2.4.0.0/x/haskell-language-server/build/haskell-language-server/haskell-language-server", "--lsp"}
}
require'lspconfig'.sqlls.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.clojure_lsp.setup{}
require'lspconfig'.nil_ls.setup{
  ['nil'] = {
    formatting = {
      command = { "alejandra" },
    },
  },
}

-- Enable LSP switching for typescript / deno projects
local function select_typescript_server(root_dir)
  -- since we're mostly using nix for projects, we check which executable is
  -- available and use that. If both are available, we do some more checking.
  local deno_a = vim.fn.executable("deno")
  local tsls_a = vim.fn.executable("typescript-language-server")
  if deno_a == 1 and tsls_a == 1 then
    -- ok, we can't use this to decide, let's check what kind of project it is
    if vim.fn.filereadable(root_dir .. "/deno.json")
      or vim.fn.filereadable(root_dir .. "/deno.jsonc") then
      return "denols"
    end
  end
  if deno_a == 1 and tsls_a == 0 then
    return "denols"
  end
  if deno_a == 0 and tsls_a == 1 then
    return "ts_ls"
  end
  -- as a default, we return ts_ls
  return "ts_ls"
end

local ts_server = select_typescript_server(vim.fn.getcwd())

if ts_server == "ts_ls" then
  require'lspconfig'.ts_ls.setup{}
elseif ts_server == "denols" then
  require'lspconfig'.denols.setup{}
end
