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

type opAnd = And

type opOr = Or

type oplogU = Not

type typeBoolInt = Bool|Int

type typ =
  Type of typeBoolInt
| ASTTypeFunc of typs * typ
| TypeVoid of void


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
  | ASTNot of oplogU * expr
  | ASTOp of op * expr * expr
  | ASTExprArgs of args * expr


and exprs = 
  ASTExpr of expr
| ASTExprs of expr * exprs 

type def =
  ASTConst of string * typ * expr
| ASTFunc of string * typ * args * expr
| ASTFuncRec of string * typ * args * expr
| ASTVar of string * typ
| ASTProc of string * args * block
| ASTProcRec of string * args * block

and stat =
  ASTEcho of expr
| ASTSet of string * expr
| ASTIF of expr * block * block
| ASTWhile expr * block
| ASTCall string * exprs
      
and cmds =
  ASTStat of stat
| ASTDef of def * cmds
| ASTStats of stat * cmds


and block = 
  ASTBlock of cmds

type blocks = 
  ASTBlocks of block
| ASTBlockS of block * blocks

type prog = 
  ASTProg of cmds

	
  let string_of_op op = 
    match op with
      Add -> "add"
    | Mul -> "mul"
    | Sub -> "sub"
    | Div -> "div"
    | Eq -> "eq"
    | Lt -> "lt"