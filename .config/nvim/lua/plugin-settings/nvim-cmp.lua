-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

local cmp = require('cmp')

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
local lspkind = require('lspkind')

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
    ['<C-k>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { 'select_next_item' }(fallback)
      end
    ),
    ['<C-p>'] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { 'select_prev_item' }(fallback)
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
    { name = 'nvim_lsp', priority = 10 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'ultisnips' },
    { name = 'path' },
    { name = 'buffer' },
    -- { name = 'omni' },
    { name = 'neorg' },
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
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        omni = '[Omni]'
      })
    }),
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
