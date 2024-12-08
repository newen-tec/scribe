let () =
  let output = Scribe.Syscall.execute [||] "cal -3" in
  print_endline (Scribe.Syscall.pretty_output output)
