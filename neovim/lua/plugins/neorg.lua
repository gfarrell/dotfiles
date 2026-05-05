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
          ["core.integrations.treesitter"] = {
            config = {
              configure_parsers = true,
            },
          },
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
          },
          ["core.export"] = {
            config = {
              extensions = "all"
            }
          }
        }
      }
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = "*.norg",
        callback = function()
          -- Set keymaps
          vim.keymap.set("n", "\\k", "<Plug>(neorg.text-objects.item-up)", {})
          vim.keymap.set("n", "\\j", "<Plug>(neorg.text-objects.item-down)", {})
          vim.keymap.set({ "o", "x" }, "iH", "<Plug>(neorg.text-objects.textobject.heading.inner)", {})
          vim.keymap.set({ "o", "x" }, "aH", "<Plug>(neorg.text-objects.textobject.heading.outer)", {})
        end
      })
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        pattern = "*.norg",
        callback = function()
          vim.opt_local.foldlevel = 1
        end
      })
    end
  }
}
