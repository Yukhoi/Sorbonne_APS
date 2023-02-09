(* ========================================================================== *)
(* == UPMC/master/info/4I506 -- Janvier 2016/2017/2018                     == *)
(* == SU/FSI/master/info/MU4IN503 -- Janvier 2020/2021/2022                == *)
(* == Analyse des programmes et sémantiques                                == *)
(* ========================================================================== *)
(* == hello-APS Syntaxe ML                                                 == *)
(* == Fichier: prologTerm.ml                                               == *)
(* ==  Génération de termes Prolog                                         == *)
(* ========================================================================== *)
open Ast
(* 
let rec print_type t = 
  match t with
    ASTBoolInt(t) -> Printf.printf "type(%s)" t
  | ASTTypeFunc(ts ,t ) ->(
      Printf.printf "(";
      Printf.printf "[";
      print_types typs;
      Printf.printf "]";
      Printf.printf "->";
      print_type typ;
      Printf.printf ")"
    )
  and print_types ts = 
  match ts with 
   ASTASTType(t) ->
      print_type t;
  |ASTTypes(t,ts) ->
      print_type t;
      Printf.printf ",";
      print_types ts



let print_arg a = 
  match a with
    ASTArg1(str , t) ->
      Printf.printf"id(%s)" str ;
      Printf.printf":" ;
      print_type t

let rec print_args ags = 
  match ags with 
    | ASTArg2(a) -> print_arg a
    | ASTArgs(a,args) -> (
      print_arg a;
      print_char ',';
      print_args args
      )

 
let rec print_expr e =()
  match e with
      ASTNum n -> Printf.printf"num(%d)" n
    | ASTId x -> Printf.printf"id(%s)" x
    | ASTApp(e, es) -> (
        Printf.printf"app(";
        print_expr e;
        Printf.printf",[";
        print_exprs es;
        Printf.printf"])"
      )
    | ASTIf (e1 ,e2, e3) ->(
        Printf.printf "if";
        Printf.printf "(";
        print_expr e1;
        Printf.printf ",";
        print_expr e2;
        Printf.printf ",";
        print_expr e3;
        Printf.printf ")";
    )
    | ASTAnd (oplog ,e1,e2)->(
        Printf.printf "oplog(%s)" oplog;
        Printf.printf "(";
        print_expr e1;
        Printf.printf ",";
        print_expr e2;
        Printf.printf ")";
    )
    | ASTOr (oplog ,e1,e2)->(
      Printf.printf "oplog(%s)" oplog;
      Printf.printf "(";
      print_expr e1;
      Printf.printf ",";
      print_expr e2;
      Printf.printf ")";
    )
    | ASTExprArgs(a ,e) ->(
        Printf.printf "(";
        Printf.printf"[";
        print_args a;
        Printf.printf"]";
        Printf.printf ",";
         print_expr e;
        Printf.printf ")"
    )

and print_exprs es =
  match es with
      [] -> ()
    | ASTExpr(e) -> print_expr e
    | ASTExprs(e ,es) -> (
	    print_expr e;
	    print_char ',';
	    print_exprs es
      )
      


let print_def d = 
  match d with
      ASTConst (str ,t, e) ->(
        Printf.printf"Const";
        Printf.printf"(";
        Printf.printf"%s"  str;
        Printf.printf")";
        Printf.printf",";
        Printf.printf"(";
        print_type t;
        Printf.printf")";
        Printf.printf",";
        Printf.printf"(";
        print_expr t;
        Printf.printf")";
        )
    | ASTFunc (s ,t ,a ,e)->(
        Printf.printf"Fun";
        Printf.printf"(";
        Printf.printf"%s"  str;
        Printf.printf")";
        Printf.printf",";
        Printf.printf"(";
        print_type t;
        Printf.printf")";
        Printf.printf",";
        Printf.printf"[";
        print_args a;
        Printf.printf"]";
        Printf.printf",";
        Printf.printf"(";
        print_expr t;
        Printf.printf")";
    )


let print_stat s =
  match s with
      ASTEcho e -> (
	Printf.printf("echo(");
	print_expr(e);
	Printf.printf(")")
      )

     
	
let rec print_cmds cs =
  match cs with
    ASTStat s -> (
      Printf.printf"stat";
      Printf.printf"(";
      print_stat s;
      Printf.printf")";
    )
    | ASTDef (d,c) ->(
      Printf.printf"def";
      Printf.printf"(";
      print_def d;
      Printf.printf")";
      Printf.printf";";
      Printf.printf"(";
      print_cmds c;
      Printf.printf")";
)
	
let print_prog p =
  Printf.printf("prog([");
  print_cmds p;
  Printf.printf("])")
;;



let fname = Sys.argv.(1) in
let ic = open_in fname in
  try
    let lexbuf = Lexing.from_channel ic in
    let p = Parser.prog Lexer.token lexbuf in
      print_prog p;
      print_string ".\n"
  with Lexer.Eof ->
    exit 0
 *)     
