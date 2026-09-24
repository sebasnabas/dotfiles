-- nvim-treesitter is pinned to the `main` branch, where `setup()` accepts only
-- `install_dir`. Parser installation, highlighting and query loading are all
-- explicit; the `ensure_installed` / `highlight` / `rainbow` / `matchup` tables
-- of the `master` API are silently ignored and have been dropped.

local langs = {
  "bash", "c", "c_sharp", "comment", "css",
  "dockerfile", "go", "groovy", "helm", "hcl", "html", "javascript", "json", "jsonnet", "latex",
  "lua", "make", "markdown", "markdown_inline", "python", "regex", "rego", "rust", "scss",
  "sql", "terraform", "toml", "tsx", "typescript", "typst", "vim", "yaml", "zig",
  "river",
}

-- Register the out-of-tree grammar. `install()` emits this event from
-- `reload_parsers()`, which drops the cached parser table, so the autocommand
-- has to exist before `install()` is called.
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").river = {
      install_info = {
        url = "https://github.com/grafana/tree-sitter-river",
        revision = "eafcdc5147f985fea120feb670f1df7babb2f79e",
        -- Required: nvim-treesitter ships no runtime/queries/river, so without
        -- this the parser installs with no highlight queries at all.
        queries = "queries",
        -- The committed src/parser.c predates the current parser ABI.
        generate = true,
      },
    }
  end,
})

-- Replaces `ensure_installed`; a no-op once the parsers are present.
require("nvim-treesitter").install(langs)

-- `.alloy` files are parsed by the `river` grammar, River being the former name
-- of the Alloy configuration syntax.
vim.treesitter.language.register("river", "alloy")

-- `main` does not enable highlighting, Neovim's own API does. `get_lang` falls
-- back to the filetype name, so no filetype pattern is needed here.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
      -- Was `additional_vim_regex_highlighting = { "markdown" }`.
      if vim.bo[args.buf].filetype == "markdown" then
        vim.bo[args.buf].syntax = "on"
      end
    end
  end,
})
