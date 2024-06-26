-- Neovim: General Options
--

vim.opt.mouse = "a"            -- Enable mouse support in all modes
vim.opt.fileencoding = "utf-8" -- Use utf-8 when writing files
vim.opt.syntax = "on"          -- Allow syntax highlighting (nb "on" not "enable")
vim.opt.cursorline = true      -- Highlight the current line
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = false -- Use relative line numbers
vim.opt.autoread = true        -- Read from disc when focussed
vim.g.mapleader = ","          -- Use , as the leader

-- Splits
-- I prefer below, right than above, left for new splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Some keybindings
--

-- Change tabs quickly
vim.keymap.set("n", "<Leader>tn", "<cmd>tabn<cr>")
vim.keymap.set("n", "<Leader>tp", "<cmd>tabp<cr>")
