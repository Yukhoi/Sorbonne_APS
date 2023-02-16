open Lexing

(*For error messages*)
let err msg pos =
  Printf.eprintf
    "Error on line %d col %d: %s.\n"
    pos.pos_lnum
    (pos.pos_cnum - pos.pos_bol)
    msg;
  exit 1
;;

print_endline ""

let () =
  if Array.length Sys.argv != 2
  then (
    Printf.eprintf "Usage: %s <file>\n" Sys.argv.(0);
    exit 1);

  (*Open the file to compile*)
  let f = open_in Sys.argv.(1) in

  (* Tokenize the file *)
  let buf = Lexing.from_channel f in

  try
    let output = Parser.prog Lexer.token buf in
      close_in f;
    Printer.print_prog output;
    print_string ".\n";
  with
  | Lexer.Eof ->
    exit 0;
;;