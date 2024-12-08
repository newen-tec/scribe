open Scribe.Index

let () =

  (* Executing echo should return the same string on output *)
  let result = Command.execute [||] "echo 0x0c4ee1" in
  assert (Command.format_output result = "0x0c4ee1") ;

  (* Reading a file, relying on Dune's directory structure *)
  let file_contents = File.read_file "test_scribe.ml" in
  let contents_list = String.split_on_char '\n' file_contents in
  assert ((List.hd contents_list) = "open Scribe.Index") ;
