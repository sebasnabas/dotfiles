; extends

; grafana/tree-sitter-river ships highlights for comments, operators, strings,
; labels, block names and function calls only. The rest is filled in here.

(bool_lit) @boolean
(numeric_lit) @number
(null_lit) @constant.builtin
(escape_sequence) @string.escape

; the grammar captures this as @variable.attribute, which Neovim does not define
(attribute_key) @property

(block label: (label) @string.special)

[ "{" "}" "[" "]" "(" ")" ] @punctuation.bracket
[ "," "." ] @punctuation.delimiter
