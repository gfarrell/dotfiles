return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.integrations.nvim-cmp"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                kb = "~/notes/gtf-kb",
              },
              index = "index.norg",
              default_workspace = "kb"
            }
          }
        }
      }
    end
  }
}
