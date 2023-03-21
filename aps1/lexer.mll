(* ========================================================================== *)
(* == UPMC/master/info/4I506 -- Janvier 2016/2017/2018                     == *)
(* == SU/FSI/master/info/MU4IN503 -- Janvier 2020/2021/2022                == *)
(* == Analyse des programmes et sémantiques                                == *)
(* ========================================================================== *)
(* == hello-APS Syntaxe ML                                                 == *)
(* == Fichier: lexer.mll                                                   == *)
(* ==  Lexique                                                             == *)
(* ========================================================================== *)

{
  open Parser        (* The type token is defined in parser.mli *)
  exception Eof

}
rule token = parse
    [' ' '\t' '\n']       { token lexbuf }     (* skip blanks *)
    (*Symboles reserves*)
  | '['              { LBRA }
  | ']'              { RBRA }
  | '('              { LPAR }
  | ')'              { RPAR }
  | ','              { COMA }
  | ':'              { COLON }
  | ';'              { SEMICOLON }
  | '*'              { STAR }
  | "->"             { ARROW }
    (*Mots clef*)
  | "ECHO"           { ECHO }
  | "CONST"           { CONST }
  | "FUN"            { FUN }
  | "REC"             { REC }   
  | "int"             { INT }
  | "bool"           { BOOL }
  | "if"             { IF }
  | "and"             { AND }
  | "or"              { OR }
  | "not"            { NOT } 
    (*Constantes numeriques*)
  | ['0'-'9']+('.'['0'-'9'])? as lxm { NUM(int_of_string lxm) }
    (*Identificateurs*)
  | ['a'-'z']['a'-'z''A'-'Z''0'-'9']* as lxm { IDENT(lxm) }
    (*symboles primitifs*)
  | "true"           { TRUE }
  | "false"           { FALSE }
  | "eq"              { EQUAL }
  | "add"             { ADD }
  | "sub"            { MINUS }
  | "mult"            { TIMES }
  | "div"             { DIV }
  | "lt"              { LESS }
  | "VAR"             { VAR }
  | "PROC"            { PROC }
  | "WHILE"           { WHILE }
  | "CALL"            { CALL }
  | "SET"             { SET }
  | "IF"              { IF2 }
  
  
 
  | eof              { raise Eof }
  