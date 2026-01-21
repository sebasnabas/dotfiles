local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

require("nvim-treesitter.configs").setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "bash", "c", "c_sharp", "comment", "css",
    "dockerfile", "go", "hcl", "html", "javascript", "json", "latex",
    "lua", "make", "markdown", "markdown_inline", "python", "regex", "rego", "rust", "scss",
    "sql", "terraform", "toml", "tsx", "typescript", "typst", "vim", "yaml", "zig"
  },
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "markdown" }
  },
  rainbow = {
    enable = true,
    disable = {},
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {},    -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  matchup = { -- github.com/andymass/vim-matchup
      enable = true,
  }
}
require("nvim-treesitter.install").prefer_git = true
