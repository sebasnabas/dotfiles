; extends

(fenced_code_block
  (info_string (language) @_language)
  (#any-of? @_language "cs" "csharp")
  (code_fence_content) @c_sharp)

(fenced_code_block
  (info_string (language) @_language)
  (#any-of? @_language "pycon")
  (code_fence_content) @python)

