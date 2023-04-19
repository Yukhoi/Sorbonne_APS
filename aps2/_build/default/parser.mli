
(* The type of tokens. *)

type token = 
  | WHILE
  | VOID
  | VEC
  | VAR
  | TRUE
  | STAR
  | SET
  | SEMICOLON
  | RPAR
  | REC
  | RBRA
  | PROC
  | OR
  | NUM of (int)
  | NOT
  | LPAR
  | LBRA
  | INT
  | IF2
  | IF
  | IDENT of (string)
  | FUNC
  | FUN
  | FALSE
  | ECHO
  | CONST
  | COMA
  | COLON
  | CALL
  | BOOL
  | ARROW
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.prog)
