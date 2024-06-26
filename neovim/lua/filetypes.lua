vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {"*.djot", "*.dj"},
  command = "set filetype=djot"
})
