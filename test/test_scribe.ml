let () =

  (* Executing echo should return the same string on output *)
  let result = Scribe.Command.execute [||] "echo 0x0c4ee1" in
  assert (Scribe.Command.format_output result = "0x0c4ee1")
