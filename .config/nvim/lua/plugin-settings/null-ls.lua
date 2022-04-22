local null_ls = require('null-ls')

-- register any number of sources simultaneously
local sources = {
    -- Foramtting
    null_ls.builtins.formatting.prettier,

    -- Diagnostics
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.chktex,
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.gitlint,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.shellcheck,

    -- Code Actions
    null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({ sources = sources })
