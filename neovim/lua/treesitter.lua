require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@class.inner",
        ["]]"] = "@function.outer"
      },
      goto_next_end = {
        ["]M"] = "@class.inner",
        ["]["] = "@function.outer"
      },
      goto_prev_start = {
        ["[m"] = "@class.inner",
        ["[]"] = "@function.outer"
      },
      goto_prev_end = {
        ["[M"] = "@class.inner",
        ["[["] = "@function.outer"
      },
    }
  }
}
