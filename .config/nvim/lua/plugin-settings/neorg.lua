require('neorg').setup {
  load = {
    ['core.defaults'] = {},       -- Load all the default modules
    ['core.norg.concealer'] = {}, -- Allows for use of icons
    ["core.norg.news"] = {
      config = {
        check_news = false,
      },
    },
    ['core.norg.qol.toc'] = {
      config = {
        toc_split_placement = 'right'
      }
    },
    ['core.norg.dirman'] = {      -- Neorg directories
      config = {
        autochdir           = false,
        index               = "index.norg",
        open_last_workspace = false,
        workspaces = {
          home     = '~/Notes',
          work     = '~/Notes/Work',
          personal = '~/Notes/Personal',
          uni      = '~/Notes/Uni'
        }
      }
    },
    ['core.norg.journal'] = {
      config = {
        journal_folder = 'journal',
        strategy       = 'nested',
        workspace      = 'personal'
      }
    },
    ['core.norg.completion'] = {
      config = {
        engine = 'nvim-cmp'
      }
    },
  }
}
