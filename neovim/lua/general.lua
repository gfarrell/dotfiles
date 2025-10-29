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

-- Codefence configuration
--
vim.g.markdown_fenced_languages = {
  "ts=typescript" -- needed for denols configuration
}

-- Some keybindings
--

-- Change tabs quickly
vim.keymap.set("n", "<Leader>tn", "<cmd>tabn<cr>")
vim.keymap.set("n", "<Leader>tp", "<cmd>tabp<cr>")

-- Open a scratchpad
local openScratch = function(type)
  local commands = {
    vertical = "vnew",
    horizontal = "new",
    inplace = "enew"
  }
  vim.cmd(commands[type] or commands.inplace)
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false
  vim.bo.ft = "norg"
  vim.wo.foldlevel = 99
end
vim.keymap.set("n", "<Leader>sv", function() openScratch("vertical") end, { desc = "Open a scratch in a vertical split" });
vim.keymap.set("n", "<Leader>sh", function() openScratch("horizontal") end, { desc = "Open a scratch in a horizontal split" });
vim.keymap.set("n", "<Leader>sp", function() openScratch("inplace") end, { desc = "Open a scratch in this pane" });
