;; extends
(macro_invocation 
  macro: [
          (_) @_test 
          (scoped_identifier name: (_)  @_test) 
  ] (#match? @_test "query")
  (token_tree [
    (string_literal (string_content) @injection.content)
    (raw_string_literal (string_content) @injection.content)
  ]) 
  (#set! injection.language "sql")
)
