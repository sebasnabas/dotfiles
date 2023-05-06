require('neorg').setup {
  load = {
    ['core.defaults'] = {},       -- Load all the default modules
    ['core.concealer'] = {}, -- Allows for use of icons
    ['core.qol.toc'] = {
      config = {
        toc_split_placement = 'right'
      }
    },
    ['core.dirman'] = {      -- Neorg directories
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
    ['core.journal'] = {
      config = {
        journal_folder = 'journal',
        strategy       = 'nested',
        workspace      = 'personal'
      }
    },
    ['core.completion'] = {
      config = {
        engine = 'nvim-cmp'
      }
    },
  }
}
