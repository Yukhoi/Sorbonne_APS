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

let string_of_op op = 
  match op with
    Add -> "add"
  | Mul -> "mul"
  | Sub -> "sub"
  | Div -> "div"
  | Eq -> "eq"
  | Lt -> "lt"

type opAnd = And

type opOr = Or

type oplogU = Not

type typeBoolInt = Bool|Int
(* aps1 *)
type typeVoid = Void

type typ =
  Type of typeBoolInt
| ASTTypeFunc of typs * typ
(* aps1 *)
| TypeVoid of typeVoid

and typs =
    ASTType of typ
  | ASTTypes of typ * typs

type arg = 
    ASTArg1 of string * typ
type args = 
    ASTArg2 of arg
  | ASTArgs of arg * args

(* aps1a *)
and argp = 
    ASTArgP1 of string * typ 
  | ArguPA of string * typ
and argsp = 
    ASTArgP2 of argp 
  | ASTArgsP of argp * argsp

type expr =
    ASTNum of int
  | ASTId of string
  | ASTBool of bool
  | ASTApp of expr * exprs
  | ASTIf of expr * expr * expr
  | ASTAnd of opAnd * expr * expr
  | ASTOr of opOr * expr * expr 
  | ASTExprArgs of args * expr


and exprs = 
  ASTExpr of expr
| ASTExprs of expr * exprs 

(* aps1a*)
and exprp = 
    ASTPr of expr
  | ASTCallAdr of expr
and exprsp =
    ASTExprp of exprp
  | ASTExprsp of exprp * exprsp

type def =
  ASTConst of string * typ * expr
| ASTFunc of string * typ * args * expr
| ASTFuncRec of string * typ * args * expr
(* aps1 *)
| ASTVar of string * typ
(* aps1a *)
| ASTProc of string * argsp * block
| ASTProcRec of string * argsp * block

and stat =
  ASTEcho of expr
(* aps1 *)
| ASTSet of string * expr
| ASTIF of expr * block * block
| ASTWhile of expr * block
(* aps1a *)
| ASTCall of string * exprsp
      
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