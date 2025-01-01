return {
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_list = {
        {
          name = "GTF KB",
          path = "~/notes/gtf-kb",
          path_html = "~/notes/gtf-kb.html"
        },
      }
      vim.g.vimwiki_auto_chdir = 1
      -- disable tables in vimwiki because we'll use another plugin for those
      vim.g.vimwiki_table_mappings = 0
      vim.g.vimwiki_table_autofmt = 0
    end
  }
}
