local null_ls = require('null-ls')

-- register any number of sources simultaneously
local sources = {
    -- Foramtting
    null_ls.builtins.formatting.black,          -- python
    null_ls.builtins.formatting.prettier,       -- js, html & css, yaml, markdown, graphql
    null_ls.builtins.formatting.rustfmt,        -- rust
    null_ls.builtins.formatting.terraform_fmt,  -- terraform

    -- Diagnostics
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.chktex,
    null_ls.builtins.diagnostics.codespell.with({
            extra_args = {"--config", "~/.config/codespell.toml", "-L", "crate"}
        }),
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.gitlint,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.vale,

    -- Code Actions
    null_ls.builtins.code_actions.gitsigns,

    -- Hover
    null_ls.builtins.hover.dictionary,
}

null_ls.setup({ sources = sources })
