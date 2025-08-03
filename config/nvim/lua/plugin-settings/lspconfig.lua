--- Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

-- These two are default now with neovim 0.10.0
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

vim.keymap.set('n', '<space>l', vim.diagnostic.setloclist, opts)

-- run code lens
vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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

  local function check_codelens_support()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  for _, c in ipairs(clients) do
    if c.server_capabilities.codeLensProvider then
      return true
    end
  end
  return false
  end

  -- refresh codelens on TextChanged and InsertLeave as well
  vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' }, {
  buffer = bufnr,
  callback = function ()
    if check_codelens_support() then
      vim.lsp.codelens.refresh({bufnr = 0})
    end
  end
  })
  -- trigger codelens refresh
  vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

capabilities.textDocument.completion.completionItem.snippetSupport = true

-- For markdown-oxide
-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
capabilities.workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    },
}

--- Server Settings
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'clangd',
  'eslint',
  'omnisharp',
  'jsonls',
  'jsonnet_ls',
  'jedi_language_server', 'pyright', 'ruff', -- python
  'gopls',
  'helm_ls',
  'markdown_oxide',
  'rust_analyzer',
  'taplo',  -- toml
  'terraformls',
  'tflint',
  'ts_ls',
  'yamlls',
  'zls'
}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

require('lspconfig').omnisharp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
  cmd = { '/usr/bin/omnisharp' },
  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,

  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,

  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = true,

  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = true,
  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,

  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = false,

  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = false,
}

require('lspconfig').jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas {
        extra = {
          {
            description = 'JSON-schema schema',
            fileMatch = '*.schema.json',
            name = 'schema.json',
            url = 'https://json-schema.org/draft/2020-12/schema',
          },
        }
      },
      validate = { enable = true },
    },
  },
}

require('lspconfig').yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
      },
      schemas = require('schemastore').yaml.schemas {
        extra = {
          {
            name = "tavern",
            description = "Tavern testing",
            url = "https://raw.githubusercontent.com/taverntesting/tavern/master/tavern/_core/schema/tests.jsonschema.yaml",
            fileMatch = "*.tavern.yaml"
          }
        }
      },
    },
  },
}

require('rust-tools').setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
                extraArgs = { "--all", "--", "-W", "clippy::all", "-D", "warnings" },
              },
            }
        }
    },
})

require('lspconfig').tflint.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "tflint", "--langserver", "--config", vim.fn.expand("$HOME/.config/tflint/tflint.hcl") },
})

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
