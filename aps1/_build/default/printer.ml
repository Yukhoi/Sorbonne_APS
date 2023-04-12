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

let rec string_of_type t = 
  match t with 
    |TypeBoolInt(t) -> 
      (match t with 
        |Int -> "int"
        |Bool -> "bool")
    |ASTTypeFunc(ts, t ) -> 
      "([" ^ string_of_types ts ^ "]," ^ string_of_type t ^ ")"
and string_of_types ts = 
  match ts with 
    |ASTType(t) ->
      string_of_type t
    |ASTTypes(t,ts) ->
      string_of_type t ^ "," ^ string_of_types ts

let rec print_type t = 
  match t with
    TypeBoolInt(t) -> 
      (match t with 
        |Int -> Printf.printf "type(int)" 
        |Bool -> Printf.printf "type(bool)" )
    | ASTTypeFunc(ts ,t ) ->(
      Printf.printf "(";
      Printf.printf "[";
      print_types ts;
      Printf.printf "]";
      Printf.printf "->";
      print_type t;
      Printf.printf ")"
    )
and print_types ts = 
  match ts with 
   ASTType(t) ->
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
;;

let string_of_arg a = 
  match a with 
    ASTArg1(str , t) -> "id(" ^ str ^ ":" ^ string_of_type t

let rec string_of_args ags = 
  match ags with 
    ASTArg2(a) -> string_of_arg a
    |ASTArgs(a,args) -> string_of_arg a ^ "," ^ string_of_args args


let rec string_of_expr env e = 
  match e with 
    ASTNum n -> string_of_int n
    |ASTBool n -> if n then "true" else "false"
    |ASTId x -> "id(" ^ x ^ ")"
    |ASTOp(op, e1, e2) -> 
      string_of_op op ^ "(" ^ string_of_expr env e1 ^ "," ^ string_of_expr env e2 ^ ")" 
    |ASTIf (e1 ,e2, e3) ->
      "if(" ^ string_of_expr env e1 ^ "," ^ string_of_expr env e2 ^ string_of_expr env e3 ^ ")"
    |ASTNot(_,e1) -> 
      "not(" ^ string_of_expr env e1 ^ ")"
    |ASTAnd (_,e1,e2)->
      "and(" ^ string_of_expr env e1 ^ "," ^ string_of_expr env e2 ^ ")"
    |ASTOr (_,e1,e2)->
      "or(" ^ string_of_expr env e1 ^ "," ^ string_of_expr env e2 ^ ")"
    |ASTApp(e, es) ->
      "app(" ^ string_of_expr env e ^ ",[" ^ string_of_exprs env es ^ "])"
    |ASTExprArgs(a ,e) ->
      "abs([" ^ string_of_args a ^ "]," ^ string_of_expr env e ^ ")"
and string_of_exprs env es =
  match es with
    | ASTExpr(e) -> string_of_expr env e
    | ASTExprs(e ,es) -> 
      string_of_expr env e ^ "," ^ string_of_exprs env es
          
    
    
 
let rec print_expr e = 
  match e with
    | ASTNum n -> Printf.printf"%d" n
    | ASTBool n -> if n then Printf.printf "true" else Printf.printf "false"
    | ASTId x -> Printf.printf"id(%s)" x;
    | ASTOp(op, e1, e2) ->(
      Printf.printf "%s" (string_of_op op);
      Printf.printf "(";
      print_expr e1;
      Printf.printf ",";
      print_expr e2;
      Printf.printf ")";
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
    | ASTNot(_,e1) ->(
          Printf.printf "not(";
          print_expr e1;
          Printf.printf ")";
    )
    | ASTAnd (_,e1,e2)->(
          Printf.printf "and";
          Printf.printf "(";
          print_expr e1;
          Printf.printf ",";
          print_expr e2;
          Printf.printf ")";
    )
    | ASTOr (_,e1,e2)->(
        Printf.printf "or";
        Printf.printf "(";
        print_expr e1;
        Printf.printf ",";
        print_expr e2;
        Printf.printf ")";
    )
    | ASTApp(e, es) -> (
        Printf.printf"app(";
        print_expr e;
        Printf.printf",[";
        print_exprs es;
        Printf.printf"])"
      )     
    | ASTExprArgs(a ,e) ->(
        Printf.printf "abs(";
        Printf.printf"[";
        print_args a;
        Printf.printf"]";
        Printf.printf ",";
         print_expr e;
        Printf.printf ")"
    )

and print_exprs es =
  match es with
    | ASTExpr(e) -> print_expr e
    | ASTExprs(e ,es) -> (
	    print_expr e;
	    print_char ',';
	    print_exprs es
      )
      
let string_of_def env d = 
  match d with 
    ASTConst (str ,t, e) -> 
      "const(" ^ str ^ "," ^ string_of_type t ^ "," ^ string_of_expr (List.append env ["("^str^","^ string_of_type t ^")"]) e ^ ")"
    | ASTFunc (s ,t ,a ,e)->
      "fun(" ^ s ^ "," ^ string_of_type t ^ ",[" ^ string_of_args a ^ "]," ^ string_of_expr (List.append env ["("^s^","^ string_of_type t ^")"]) e ^ ")"
    | ASTFuncRec (s ,t ,a ,e)->
      "funRec(" ^ s ^ "," ^ string_of_type t ^ ",[" ^ string_of_args a ^ "]," ^ string_of_expr (List.append env ["("^s^","^ string_of_type t ^")"]) e ^ ")"




let print_def d = 
  match d with
      ASTConst (str ,t, e) ->(
        Printf.printf"const";
        Printf.printf"(";
        Printf.printf"%s"  str;
        Printf.printf")";
        Printf.printf",";
        Printf.printf"(";
        print_type t;
        Printf.printf")";
        Printf.printf",";
        Printf.printf"(";
        print_expr e;
        Printf.printf")";
        )
    | ASTFunc (s ,t ,a ,e)->(
        Printf.printf"fun";
        Printf.printf"(";
        Printf.printf"%s"  s;
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
        print_expr e;
        Printf.printf")";
      )
      | ASTFuncRec (s ,t ,a ,e)->(
        Printf.printf"funRec";
        Printf.printf"(";
        Printf.printf"%s"  s;
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
        print_expr e;
        Printf.printf")";
      )


let print_stat s =
  match s with
      ASTEcho e -> (
	Printf.printf("echo(");
	print_expr(e);
	Printf.printf(")")
      )

let string_of_stat env s = 
  match s with 
    ASTEcho e ->
      ("echo(" ^ string_of_expr env e ^ ")")
    ASTIF(con, bk1, bk2) ->
      ("iF(" ^ string_of_expr env con ^ "," ^string_of_block env bk1 ^ "," ^ string_of_block env bk2 ^ ")")
    ASTWhile(con, bk) -> 
      ("wHile(" ^ string_of_expr env con ^ "," ^string_of_block env bk ^ ")")
    ASTCall(id, args) ->
      ("call(" ^)
    

     
	
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

let rec string_of_cmds env cs = 
  match cs with 
    ASTStat s -> 
      ( "stat(" ^ string_of_stat env s ^ ")")
    |ASTDef (d,c) -> 
      ("def(" ^ string_of_def env d ^ ");(" ^ string_of_cmds env c ^ ")")
    |ASTStats (s,c) ->
      ("stats(" ^ string_of_stat s ^ ");(" ^ string_of_cmds env c ^ ")")

let rec string_of_block env bl = 
  match bl with
    ASTBlock cs -> 
      ("block(" ^ string_of_cmds env cs ^ ")" )

let rec print_env e =
  match e with
  [] -> ()
  |[x] ->  Printf.printf"%s" x
  |x::l -> Printf.printf"%s" x;
              Printf.printf ",";
              print_env l;;

let print_prog p =
  Printf.printf("typeProg(E");
  Printf.printf(",prog(");
  print_cmds p;
  Printf.printf("), void)");
  (*print_env !iden;*)

;;

let string_of_prog p = 
  let env = [] in 
    "typeProg([" ^ String.concat "" env ^ "],prog(" ^ string_of_block env p ^ "), void)";

;;

(*
let fname = Sys.argv.(1) in
let ic = open_in fname in
  try
    let lexbuf = Lexing.from_channel ic in
    let p = Parser.prog Lexer.token lexbuf in
      print_prog p;
      print_string ".\n"
  with Lexer.Eof ->
    exit 0;;*)