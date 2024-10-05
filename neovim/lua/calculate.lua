function Calculate()
  -- Get selected text
  local start_pos = vim.fn.getpos("'<") -- returns array where 1 = buffer, 2 = line, 3 = column, 4 = off-column (for virtual cols)
  local end_pos = vim.fn.getpos("'>")
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_text(bufnr, start_pos[2]-1, start_pos[3]-1, end_pos[2]-1, end_pos[3]-1, {})
  local text = table.concat(lines, "\n")

  -- Calculate with qalc (-t = result only)
  local result = vim.fn.system('qalc -t "' .. text:gsub('"', '\\"') .. '"')

  -- Trim whitespace
  result = result:gsub("^%s*(.-)%s*$", "%1")

  -- Replace the selected text with the result
  vim.api.nvim_buf_set_text(bufnr, start_pos[2]-1, start_pos[3]-1, end_pos[2]-1, end_pos[3], {result})
end

vim.api.nvim_set_keymap("v", "<leader>c", ":lua Calculate()<CR>", {noremap = true, silent = true})
