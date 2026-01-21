; extends

; Additional language abbreviation: C#
(fenced_code_block
  (info_string (language) @_language)
  (#any-of? @_language "cs" "csharp")
  (code_fence_content) @c_sharp)

; Additional language abbreviation: Python
(fenced_code_block
  (info_string (language) @_language)
  (#any-of? @_language "pycon")
  (code_fence_content) @python)

; Markview header folding
; NOTE: `(#trim!)` is used to prevent empty lines at the end of the section from being folded.
((section
    (atx_heading)) @fold
    (#trim! @fold))
