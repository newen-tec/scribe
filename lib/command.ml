module Interface : sig

  type process_output = {
    output : string ;
    error : string ;
    status: string ;
  }

  val execute : string array -> string -> process_output
  val format_output : process_output -> string

end = struct

  let handle_exit_status (status: Unix.process_status): string =
    match status with
    | Unix.WEXITED n -> "Exit " ^ string_of_int n
    | Unix.WSIGNALED n -> "Kill " ^ string_of_int n
    | Unix.WSTOPPED n -> "Stopped " ^ string_of_int n

  type process_output = {
    output : string ;
    error : string ;
    status: string ;
  }

  let format_output (output : process_output) : string =
    match output with
      | { output = o  ; error = _ ; status = "Exit 0" } -> o
      | { output = "" ; error = e ; status = s } -> "[" ^ s ^ "]" ^ " " ^ e
      | { output = o  ; error = _ ; status = s } -> "[" ^ s ^ "]" ^ " " ^ o

  let execute (env: string array) (command : string): process_output =

    let stdout, stdin, stderr = Unix.open_process_full command env in
    let in_buffer = Buffer.create 4096 in
    let err_buffer = Buffer.create 4096 in

    let rec read_in () =
      let in_line = input_line stdout in
        Buffer.add_string in_buffer in_line ;
        Buffer.add_char in_buffer '\n' ;
      read_in ()
    in try read_in () with
      End_of_file -> ();

    let rec read_err () =
      let err_line = input_line stderr in
        Buffer.add_string err_buffer err_line ;
        Buffer.add_char err_buffer '\n' ;
      read_err ()

    in
    try read_err () with
      End_of_file -> let exit_status =
        handle_exit_status (Unix.close_process_full (stdout, stdin, stderr))
      in
      {
        output = String.trim (Buffer.contents in_buffer) ;
        error = Buffer.contents err_buffer ;
        status = exit_status ;
      }
end
