let () =

  (* Executing echo should return the same string on output *)
  let result = Scribe.Syscall.execute [||] "echo 0x0c4ee1" in
  assert (result.output = "0x0c4ee1")
