return {
  -- JJ integration: diff against a JJ revision using diffview.nvim
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local pickers = require('telescope.pickers')
      local finders = require('telescope.finders')
      local conf = require('telescope.config').values
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      -- This function allows me to select a baseline using JJ + telescope and pipe it into diffview
      local function jj_diffview()
        local output = vim.fn.systemlist(
          "jj log --no-graph -T 'change_id.shortest(4) ++ \" \" ++ bookmarks ++ \" \" ++ description.first_line() ++ \"\\n\"'"
        )

        if vim.v.shell_error ~= 0 then
          vim.notify('Not in a jj repo', vim.log.levels.ERROR)
          return
        end

        -- Filter out empty lines
        local entries = vim.tbl_filter(function(line) return line ~= '' end, output)

        pickers.new({}, {
          prompt_title = 'JJ: diff against revision',
          finder = finders.new_table({ results = entries }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              if not selection then return end

              local change_id = selection.value:match('^(%S+)')
              local commit_id = vim.fn.system(
                "jj log --no-graph -r " .. vim.fn.shellescape(change_id) .. " -T 'commit_id'"
              ):gsub('%s+$', '')

              if vim.v.shell_error ~= 0 or commit_id == '' then
                vim.notify('Failed to resolve commit ID for ' .. change_id, vim.log.levels.ERROR)
                return
              end

              vim.cmd('DiffviewOpen ' .. commit_id)
            end)
            return true
          end,
        }):find()
      end

      vim.keymap.set('n', '<leader>jd', jj_diffview, { desc = 'JJ: diff against revision' })
    end
  },
}
