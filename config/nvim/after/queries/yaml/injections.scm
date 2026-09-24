; extends

; A mapping key that is a file name means the block scalar under it is that
; file's content, as in a ConfigMap `data:` block. `@injection.filename` runs
; the key through Neovim's filetype detection, so no language list is needed;
; keys that match no filetype, or whose parser is absent, are left alone.

; The block's YAML indentation stays inside the injected range: `block_scalar` is
; a leaf token, so there are no per-line children for Neovim to mask out (the
; trick markdown's `block_continuation` enables). Measured harmless for every
; parser here except markdown, which reads the indent as an indented code block.

; The `|` / `>` header is part of the block_scalar node, so the offset skips it.
; Chomping and indentation indicators (`|-`, `|+`, `>-`) make it two characters.
(block_mapping_pair
  key: (flow_node) @injection.filename
  value: (block_node
    (block_scalar) @injection.content)
  (#lua-match? @injection.content "^[|>][ \t]*\n")
  (#offset! @injection.content 0 1 0 0))

(block_mapping_pair
  key: (flow_node) @injection.filename
  value: (block_node
    (block_scalar) @injection.content)
  (#lua-match? @injection.content "^[|>][-+0-9][ \t]*\n")
  (#offset! @injection.content 0 2 0 0))
