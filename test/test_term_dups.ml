open Cmdliner

let dups p p_dup o o_dup o' =
  let b = string_of_bool in
  print_endline (String.concat "\n" [p; p_dup; b o; b o_dup; b o'])

let test_pos =
  let p =
    let doc = "First pos argument should show up only once in the docs" in
    Arg.(value & pos 0 string "undefined" & info [] ~doc ~docv:"POS")
  in
  let o =
    let doc = "This should show up only once in the docs" in
    Arg.(value & flag & info ["f"; "flag"] ~doc)
  in
  let o' =
    let doc = "This is another def for $(opt) so it will show up too" in
    Arg.(value & flag & info ["flag"] ~doc)
  in
  Term.(const dups $ p $ p $ o $ o $ o'),
  Term.info "test_term_dups" ~doc:"Test multiple term usage"

let () = match Term.eval test_pos with
| `Error _ -> exit 1
| _ -> exit 0
