--- Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>l', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require("lsp-inlayhints").on_attach(client, bufnr, true)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<M-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

--- Server Settings
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'clangd', 'omnisharp',
  'jedi_language_server', 'pyright', 'ruff_lsp', -- python
  'rome', -- javascript, javascriptreact, json, typescript, typescript.tsx, typescriptreact
  'rust_analyzer',
  'taplo',  -- toml
  -- 'terraformls',
  'tflint',
  'tsserver'
}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- Omnisharp config
local omnisharp_bin = '/usr/bin/omnisharp'
require('lspconfig').omnisharp.setup{
  cmd = { omnisharp_bin },
  -- enable_editorconfig_support = true,
  -- enable_roslyn_analyzers = true,
  -- organize_imports_on_format = true
}

-- ltex-ls config
require('grammar-guard').init()
require('lspconfig').grammar_guard.setup({
  cmd = { '/usr/bin/ltex-ls' },
  settings = {
    ltex = {
      enabled = { 'bibtex', 'gitcommit', 'html', 'latex', 'markdown', 'norg', 'org' },
      language = 'en',
      diagnosticSeverity = 'information',
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = false,
        motherTongue = 'de',
      },
      trace = { server = 'verbose' },
      dictionary = {},
      disabledRules = {},
      hiddenFalsePositives = {},
    },
  },
})

require('rust-tools').setup({
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attaches to the buffer
        on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
              inlayHints = { locationLinks = false },
              checkOnSave = {  -- enable clippy on save
                command = "clippy",
                extraArgs = { "--all", "--", "-W", "clippy::all -D warnings" },
              },
            }
        }
    },
})

require('lspconfig').omnisharp.setup{
  cmd = { "tflint", "--langserver", "--config", "~/.config/tflint/tflint.hcl" },
}

--- Ui
require("lsp_lines").setup()
vim.diagnostic.config({
  -- Disable virtual_text since it's redundant due to lsp_lines.
  virtual_text = false,
  float = {
    source = 'if_many'
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})
