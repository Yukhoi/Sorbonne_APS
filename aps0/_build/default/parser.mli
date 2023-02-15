
(* The type of tokens. *)

type token = 
  | TRUE
  | TIMES
  | STAR
  | SEMICOLON
  | RPAR
  | REC
  | RBRA
  | OR
  | NUM of (int)
  | NOT
  | MINUS
  | LPAR
  | LESS
  | LBRA
  | INT
  | IF
  | IDENT of (string)
  | FUNC
  | FUN
  | FALSE
  | EQUAL
  | ECHO
  | DIV
  | CONST
  | COMA
  | COLON
  | BOOL
  | ARROW
  | AND
  | ADD

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.cmds)
