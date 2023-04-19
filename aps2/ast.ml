(* ========================================================================== *)
(* == UPMC/master/info/4I506 -- Janvier 2016/2017/2018                     == *)
(* == SU/FSI/master/info/MU4IN503 -- Janvier 2020/2021/2022                == *)
(* == Analyse des programmes et sémantiques                                == *)
(* ========================================================================== *)
(* == hello-APS Syntaxe ML                                                 == *)
(* == Fichier: ast.ml                                                      == *)
(* ==  Arbre de syntaxe abstraite                                          == *)
(* ========================================================================== *)



type op = 
| Eq 
| Lt 
| Add 
| Sub 
| Mul 
| Div
(* aps2  *)
| Alloc
| Len
| Nth
| Vset

let string_of_op op = 
  match op with
    Add -> "add"
  | Mul -> "mul"
  | Sub -> "sub"
  | Div -> "div"
  | Eq -> "eq"
  | Lt -> "lt"
  (* aps2  *)
  | Alloc -> "alloc"
  | Len -> "len"
  | Nth -> "nth"
  | Vset -> "vset"
  
  
type opAnd = And

type opOr = Or

type oplogU = Not

type typeBoolInt = Bool|Int

type typeVoid = Void

type typ =
  TypeBoolInt of typeBoolInt
| ASTTypeFunc of typs * typ
(* aps1 *)
| TypeVoid of typeVoid
(* APS2 *)
| TypeVec of typ

and typs =
    ASTType of typ
  | ASTTypes of typ * typs

type arg = 
    ASTArg1 of string * typ
type args = 
    ASTArg2 of arg
  | ASTArgs of arg * args

type expr =
    ASTNum of int
  | ASTId of string
  | ASTBool of bool
  | ASTApp of expr * exprs
  | ASTIf of expr * expr * expr
  | ASTAnd of opAnd * expr * expr
  | ASTOr of opOr * expr * expr 
  (* | ASTNot of oplogU * expr
  | ASTOp of op * expr * expr *)
  | ASTExprArgs of args * expr
  (* APS2
  | ASTAlloc of expr 
  | ASTLen of expr
  | ASTNth of expr * expr
  | ASTVSet of expr * expr *expr *)

and exprs = 
  ASTExpr of expr
| ASTExprs of expr * exprs 

type def =
  ASTConst of string * typ * expr
| ASTFunc of string * typ * args * expr
| ASTFuncRec of string * typ * args * expr
(* aps1 *)
| ASTVar of string * typ
| ASTProc of string * args * block
| ASTProcRec of string * args * block

and stat =
  ASTEcho of expr
(* aps1 *)
(* | ASTSet of string * expr *)
| ASTIF of expr * block * block
| ASTWhile of expr * block
| ASTCall of string * exprs
(* APS2 *)
| ASTSet of lval * expr

(* APS2 *)
and lval = 
  ASTLvId of string 
| ASTLval of lval * expr
      
and cmds =
  ASTStat of stat
| ASTDef of def * cmds
(* aps1 *)
| ASTStats of stat * cmds

(* aps1 *)
and block = 
  ASTBlock of cmds

type prog = 
  ASTProg of cmds