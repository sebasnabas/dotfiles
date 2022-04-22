require('neorg').setup {
  load = {
    ['core.defaults'] = {},       -- Load all the default modules
    ['core.keybinds'] = {},
    ['core.norg.concealer'] = {}, -- Allows for use of icons
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
    ['core.gtd.base'] = {   -- Getting Things Done
      config = {
        workspace = 'home'
      }
    },
    ['core.integrations.nvim-cmp'] = {}
  }
}
