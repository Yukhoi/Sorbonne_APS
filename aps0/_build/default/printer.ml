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






let string_of_arg a = 
  match a with 
    ASTArg1(str , t) -> "(id(" ^ str ^ "),[]," ^ string_of_type t ^ ")"

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
      "if(" ^ string_of_expr env e1 ^ "," ^ string_of_expr env e2 ^ "," ^ string_of_expr env e3 ^ ")"
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
          
    
 
      
let string_of_def env d = 
  match d with 
    ASTConst (str ,t, e) -> 
      "const(" ^ str ^ "," ^ string_of_type t ^ "," ^ string_of_expr (List.append env ["("^str^","^ string_of_type t ^")"]) e ^ ")"
    | ASTFunc (s ,t ,a ,e)->
      "fun(" ^ s ^ "," ^ string_of_type t ^ ",[" ^ string_of_args a ^ "]," ^ string_of_expr (List.append env ["("^s^","^ string_of_type t ^")"]) e ^ ")"
    | ASTFuncRec (s ,t ,a ,e)->
      "funRec(" ^ s ^ "," ^ string_of_type t ^ ",[" ^ string_of_args a ^ "]," ^ string_of_expr (List.append env ["("^s^","^ string_of_type t ^")"]) e ^ ")"

let string_of_stat env s = 
  match s with 
    ASTEcho e ->
      ("echo(" ^ string_of_expr env e ^ ")")

let rec string_of_cmds env cs = 
  match cs with 
    ASTStat s -> 
      ( "stat(" ^ string_of_stat env s ^ ")")
    |ASTDef (d,c) -> 
      ("def(" ^ string_of_def env d ^ ")," ^ string_of_cmds env c )
;;

let string_of_prog p = 
  let env = [] in 
    "typeProg(prog([" ^ string_of_cmds env p ^ "]), void)";

;;

