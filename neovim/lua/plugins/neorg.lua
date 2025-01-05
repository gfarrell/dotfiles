return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                kb = "~/notes/gtf-kb",
                converge = "~/notes/converge"
              },
              index = "index.norg",
              default_workspace = "kb"
            }
          },
          ["core.concealer"] = {},
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            }
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.text-objects"] = {},
          ["core.qol.todo_items"] = {
            config = {
              create_todo_items = true,
            }
          },
          ["core.journal"] = {
            config = {
              workspace = "kb"
            }
          }
        }
      }
      vim.keymap.set("n", "<up>", "<Plug>(neorg.text-objects.item-up)", {})
      vim.keymap.set("n", "<down>", "<Plug>(neorg.text-objects.item-down)", {})
      vim.keymap.set({ "o", "x" }, "iH", "<Plug>(neorg.text-objects.textobject.heading.inner)", {})
      vim.keymap.set({ "o", "x" }, "aH", "<Plug>(neorg.text-objects.textobject.heading.outer)", {})
    end
  }
}
