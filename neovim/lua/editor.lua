-- Wrapping and formatting
vim.opt.textwidth = 80        -- Default wrap width
vim.opt.fo = "cqnj"           -- format w/ comments, gq, and numbered lists
vim.opt.formatprg = "par r80" -- use par for formatting

-- Tabs and Spaces
vim.opt.expandtab = true      -- spaces not tabs
vim.opt.shiftwidth = 2        -- 1 tab = 2 spaces
vim.opt.softtabstop = 2       -- handle insertion of \t
vim.opt.autoindent = true     -- keep indentation on new lines

-- Invisible characters
vim.w.invlist = true
vim.w.list = true
vim.w.listchars = {"tab:¦ ", "eol:¬", "trail:⋅", "extends:❯", "precedes:❮"}

-- Don't use swapfiles or backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Use Ctrl+P to open FZF :Files
vim.keymap.set("n", "<C-P>", ":Files<CR>")
