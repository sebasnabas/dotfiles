vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-n>'] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { 'select_next_item' }(fallback)
      end
    ),
    ['<C-k>'] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { 'expand' }(fallback)
      end,
      { 'i', 's', --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ['<C-p>'] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { 'select_previous_item' }(fallback)
      end,
      { 'i', 's', --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ['<Tab>'] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { 'jump_forwards' }(fallback)
      end,
      { 'i', 's', --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ['<S-Tab>'] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { 'jump_backwards' }(fallback)
      end,
      { 'i', 's', --[[ "c" (to enable the mapping in command mode) ]] }
    )
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'rg' },
    { name = 'tags' },
    { name = 'spell' }
  }),
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require 'cmp-under-comparator'.under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})
