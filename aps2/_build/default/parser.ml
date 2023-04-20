
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
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
    | NUM of (
# 16 "parser.mly"
       (int)
# 28 "parser.ml"
  )
    | NOT
    | LPAR
    | LBRA
    | INT
    | IF2
    | IF
    | IDENT of (
# 17 "parser.mly"
       (string)
# 39 "parser.ml"
  )
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
  
end

include MenhirBasics

# 1 "parser.mly"
  
(* ========================================================================== *)
(* == UPMC/master/info/4I506 -- Janvier 2016/2017                          == *)
(* == SU/FSI/master/info/MU4IN503 -- Janvier 2020/2021/2022                == *)
(* == Analyse des programmes et sémantiques                                == *)
(* ========================================================================== *)
(* == hello-APS Syntaxe ML                                                 == *)
(* == Fichier: parser.mly                                                  == *)
(* == Analyse syntaxique                                                   == *)
(* ========================================================================== *)

open Ast


# 72 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState001 : ('s, _menhir_box_prog) _menhir_state
    (** State 001.
        Stack shape : .
        Start symbol: prog. *)

  | MenhirState002 : (('s, _menhir_box_prog) _menhir_cell1_WHILE, _menhir_box_prog) _menhir_state
    (** State 002.
        Stack shape : WHILE.
        Start symbol: prog. *)

  | MenhirState005 : (('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_state
    (** State 005.
        Stack shape : LPAR.
        Start symbol: prog. *)

  | MenhirState006 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_state
    (** State 006.
        Stack shape : LPAR OR.
        Start symbol: prog. *)

  | MenhirState007 : (('s, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 007.
        Stack shape : LBRA.
        Start symbol: prog. *)

  | MenhirState009 : (('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_state
    (** State 009.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState012 : (('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_state
    (** State 012.
        Stack shape : LPAR.
        Start symbol: prog. *)

  | MenhirState016 : (('s, _menhir_box_prog) _menhir_cell1_typs, _menhir_box_prog) _menhir_state
    (** State 016.
        Stack shape : typs.
        Start symbol: prog. *)

  | MenhirState019 : ((('s, _menhir_box_prog) _menhir_cell1_typs, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 019.
        Stack shape : typs typ.
        Start symbol: prog. *)

  | MenhirState020 : ((('s, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR, _menhir_box_prog) _menhir_state
    (** State 020.
        Stack shape : typ STAR.
        Start symbol: prog. *)

  | MenhirState022 : (((('s, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 022.
        Stack shape : typ STAR typ.
        Start symbol: prog. *)

  | MenhirState023 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 023.
        Stack shape : LPAR typ.
        Start symbol: prog. *)

  | MenhirState025 : ((('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 025.
        Stack shape : IDENT typ.
        Start symbol: prog. *)

  | MenhirState027 : ((('s, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 027.
        Stack shape : LBRA args.
        Start symbol: prog. *)

  | MenhirState032 : (('s, _menhir_box_prog) _menhir_cell1_arg, _menhir_box_prog) _menhir_state
    (** State 032.
        Stack shape : arg.
        Start symbol: prog. *)

  | MenhirState034 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 034.
        Stack shape : LPAR OR expr.
        Start symbol: prog. *)

  | MenhirState037 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_state
    (** State 037.
        Stack shape : LPAR IF.
        Start symbol: prog. *)

  | MenhirState038 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 038.
        Stack shape : LPAR IF expr.
        Start symbol: prog. *)

  | MenhirState039 : ((((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 039.
        Stack shape : LPAR IF expr expr.
        Start symbol: prog. *)

  | MenhirState042 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_state
    (** State 042.
        Stack shape : LPAR AND.
        Start symbol: prog. *)

  | MenhirState043 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 043.
        Stack shape : LPAR AND expr.
        Start symbol: prog. *)

  | MenhirState046 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 046.
        Stack shape : LPAR expr.
        Start symbol: prog. *)

  | MenhirState049 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 049.
        Stack shape : expr.
        Start symbol: prog. *)

  | MenhirState051 : ((('s, _menhir_box_prog) _menhir_cell1_WHILE, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 051.
        Stack shape : WHILE expr.
        Start symbol: prog. *)

  | MenhirState052 : (('s, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 052.
        Stack shape : LBRA.
        Start symbol: prog. *)

  | MenhirState054 : (('s, _menhir_box_prog) _menhir_cell1_VAR _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 054.
        Stack shape : VAR IDENT.
        Start symbol: prog. *)

  | MenhirState055 : ((('s, _menhir_box_prog) _menhir_cell1_VAR _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 055.
        Stack shape : VAR IDENT typ.
        Start symbol: prog. *)

  | MenhirState056 : (('s, _menhir_box_prog) _menhir_cell1_SET, _menhir_box_prog) _menhir_state
    (** State 056.
        Stack shape : SET.
        Start symbol: prog. *)

  | MenhirState058 : (('s, _menhir_box_prog) _menhir_cell1_LPAR _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 058.
        Stack shape : LPAR IDENT.
        Start symbol: prog. *)

  | MenhirState060 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_lval, _menhir_box_prog) _menhir_state
    (** State 060.
        Stack shape : LPAR IDENT lval.
        Start symbol: prog. *)

  | MenhirState063 : ((('s, _menhir_box_prog) _menhir_cell1_SET, _menhir_box_prog) _menhir_cell1_lval, _menhir_box_prog) _menhir_state
    (** State 063.
        Stack shape : SET lval.
        Start symbol: prog. *)

  | MenhirState068 : (('s, _menhir_box_prog) _menhir_cell1_PROC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 068.
        Stack shape : PROC IDENT.
        Start symbol: prog. *)

  | MenhirState070 : ((('s, _menhir_box_prog) _menhir_cell1_PROC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 070.
        Stack shape : PROC IDENT args.
        Start symbol: prog. *)

  | MenhirState073 : (('s, _menhir_box_prog) _menhir_cell1_PROC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 073.
        Stack shape : PROC IDENT.
        Start symbol: prog. *)

  | MenhirState075 : ((('s, _menhir_box_prog) _menhir_cell1_PROC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 075.
        Stack shape : PROC IDENT args.
        Start symbol: prog. *)

  | MenhirState077 : (('s, _menhir_box_prog) _menhir_cell1_IF2, _menhir_box_prog) _menhir_state
    (** State 077.
        Stack shape : IF2.
        Start symbol: prog. *)

  | MenhirState078 : ((('s, _menhir_box_prog) _menhir_cell1_IF2, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 078.
        Stack shape : IF2 expr.
        Start symbol: prog. *)

  | MenhirState079 : (((('s, _menhir_box_prog) _menhir_cell1_IF2, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_block, _menhir_box_prog) _menhir_state
    (** State 079.
        Stack shape : IF2 expr block.
        Start symbol: prog. *)

  | MenhirState082 : (('s, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 082.
        Stack shape : FUNC IDENT.
        Start symbol: prog. *)

  | MenhirState083 : ((('s, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 083.
        Stack shape : FUNC IDENT typ.
        Start symbol: prog. *)

  | MenhirState084 : (((('s, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 084.
        Stack shape : FUNC IDENT typ LBRA.
        Start symbol: prog. *)

  | MenhirState086 : ((((('s, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 086.
        Stack shape : FUNC IDENT typ LBRA args.
        Start symbol: prog. *)

  | MenhirState090 : (('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 090.
        Stack shape : FUN IDENT.
        Start symbol: prog. *)

  | MenhirState091 : ((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 091.
        Stack shape : FUN IDENT typ.
        Start symbol: prog. *)

  | MenhirState092 : (((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 092.
        Stack shape : FUN IDENT typ LBRA.
        Start symbol: prog. *)

  | MenhirState094 : ((((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 094.
        Stack shape : FUN IDENT typ LBRA args.
        Start symbol: prog. *)

  | MenhirState096 : (('s, _menhir_box_prog) _menhir_cell1_ECHO, _menhir_box_prog) _menhir_state
    (** State 096.
        Stack shape : ECHO.
        Start symbol: prog. *)

  | MenhirState099 : (('s, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 099.
        Stack shape : CONST IDENT.
        Start symbol: prog. *)

  | MenhirState100 : ((('s, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 100.
        Stack shape : CONST IDENT typ.
        Start symbol: prog. *)

  | MenhirState103 : (('s, _menhir_box_prog) _menhir_cell1_CALL _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 103.
        Stack shape : CALL IDENT.
        Start symbol: prog. *)

  | MenhirState106 : (('s, _menhir_box_prog) _menhir_cell1_stat, _menhir_box_prog) _menhir_state
    (** State 106.
        Stack shape : stat.
        Start symbol: prog. *)

  | MenhirState108 : (('s, _menhir_box_prog) _menhir_cell1_def, _menhir_box_prog) _menhir_state
    (** State 108.
        Stack shape : def.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_arg = 
  | MenhirCell1_arg of 's * ('s, 'r) _menhir_state * (Ast.arg)

and ('s, 'r) _menhir_cell1_args = 
  | MenhirCell1_args of 's * ('s, 'r) _menhir_state * (Ast.args)

and ('s, 'r) _menhir_cell1_block = 
  | MenhirCell1_block of 's * ('s, 'r) _menhir_state * (Ast.block)

and ('s, 'r) _menhir_cell1_def = 
  | MenhirCell1_def of 's * ('s, 'r) _menhir_state * (Ast.def)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr)

and ('s, 'r) _menhir_cell1_lval = 
  | MenhirCell1_lval of 's * ('s, 'r) _menhir_state * (Ast.lval)

and ('s, 'r) _menhir_cell1_stat = 
  | MenhirCell1_stat of 's * ('s, 'r) _menhir_state * (Ast.stat)

and ('s, 'r) _menhir_cell1_typ = 
  | MenhirCell1_typ of 's * ('s, 'r) _menhir_state * (Ast.typ)

and ('s, 'r) _menhir_cell1_typs = 
  | MenhirCell1_typs of 's * ('s, 'r) _menhir_state * (Ast.typs)

and ('s, 'r) _menhir_cell1_AND = 
  | MenhirCell1_AND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CALL = 
  | MenhirCell1_CALL of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CONST = 
  | MenhirCell1_CONST of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ECHO = 
  | MenhirCell1_ECHO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FUN = 
  | MenhirCell1_FUN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FUNC = 
  | MenhirCell1_FUNC of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 17 "parser.mly"
       (string)
# 385 "parser.ml"
)

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 17 "parser.mly"
       (string)
# 392 "parser.ml"
)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IF2 = 
  | MenhirCell1_IF2 of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LBRA = 
  | MenhirCell1_LBRA of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAR = 
  | MenhirCell1_LPAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OR = 
  | MenhirCell1_OR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PROC = 
  | MenhirCell1_PROC of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SET = 
  | MenhirCell1_SET of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_STAR = 
  | MenhirCell1_STAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_VAR = 
  | MenhirCell1_VAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state

and _menhir_box_prog = 
  | MenhirBox_prog of (Ast.prog) [@@unboxed]

let _menhir_action_01 =
  fun _1 _3 ->
    (
# 122 "parser.mly"
                      (ASTArg1(_1,_3))
# 433 "parser.ml"
     : (Ast.arg))

let _menhir_action_02 =
  fun _1 ->
    (
# 126 "parser.mly"
                        (ASTArg2(_1))
# 441 "parser.ml"
     : (Ast.args))

let _menhir_action_03 =
  fun _1 _3 ->
    (
# 127 "parser.mly"
                        (ASTArgs(_1,_3))
# 449 "parser.ml"
     : (Ast.args))

let _menhir_action_04 =
  fun _2 ->
    (
# 57 "parser.mly"
                 ( ASTBlock(_2) )
# 457 "parser.ml"
     : (Ast.block))

let _menhir_action_05 =
  fun _1 ->
    (
# 62 "parser.mly"
                        ( ASTStat (_1) )
# 465 "parser.ml"
     : (Ast.cmds))

let _menhir_action_06 =
  fun _1 _3 ->
    (
# 63 "parser.mly"
                        ( ASTDef(_1, _3) )
# 473 "parser.ml"
     : (Ast.cmds))

let _menhir_action_07 =
  fun _1 _3 ->
    (
# 65 "parser.mly"
                        ( ASTStats (_1, _3) )
# 481 "parser.ml"
     : (Ast.cmds))

let _menhir_action_08 =
  fun _2 _3 _4 ->
    (
# 88 "parser.mly"
                                          (ASTConst(_2, _3, _4))
# 489 "parser.ml"
     : (Ast.def))

let _menhir_action_09 =
  fun _2 _3 ->
    (
# 90 "parser.mly"
                                        ( ASTVar(_2, _3) )
# 497 "parser.ml"
     : (Ast.def))

let _menhir_action_10 =
  fun _2 _3 _5 _7 ->
    (
# 91 "parser.mly"
                                          (ASTFunc(_2, _3 ,_5, _7))
# 505 "parser.ml"
     : (Ast.def))

let _menhir_action_11 =
  fun _3 _4 _6 _8 ->
    (
# 92 "parser.mly"
                                          ( ASTFuncRec(_3, _4, _6, _8))
# 513 "parser.ml"
     : (Ast.def))

let _menhir_action_12 =
  fun _2 _4 _6 ->
    (
# 94 "parser.mly"
                                       ( ASTProc(_2, _4, _6) )
# 521 "parser.ml"
     : (Ast.def))

let _menhir_action_13 =
  fun _3 _5 _7 ->
    (
# 95 "parser.mly"
                                           ( ASTProcRec(_3, _5, _7) )
# 529 "parser.ml"
     : (Ast.def))

let _menhir_action_14 =
  fun _1 ->
    (
# 132 "parser.mly"
                              ( ASTNum(_1) )
# 537 "parser.ml"
     : (Ast.expr))

let _menhir_action_15 =
  fun _1 ->
    (
# 133 "parser.mly"
                              ( ASTId(_1) )
# 545 "parser.ml"
     : (Ast.expr))

let _menhir_action_16 =
  fun () ->
    (
# 134 "parser.mly"
                              ( ASTBool(true) )
# 553 "parser.ml"
     : (Ast.expr))

let _menhir_action_17 =
  fun () ->
    (
# 135 "parser.mly"
                             ( ASTBool(false) )
# 561 "parser.ml"
     : (Ast.expr))

let _menhir_action_18 =
  fun _2 _3 ->
    (
# 136 "parser.mly"
                              ( ASTApp(_2, _3) )
# 569 "parser.ml"
     : (Ast.expr))

let _menhir_action_19 =
  fun _3 _4 _5 ->
    (
# 137 "parser.mly"
                              ( ASTIf(_3, _4, _5) )
# 577 "parser.ml"
     : (Ast.expr))

let _menhir_action_20 =
  fun _3 _4 ->
    (
# 138 "parser.mly"
                              ( ASTAnd(Ast.And, _3, _4) )
# 585 "parser.ml"
     : (Ast.expr))

let _menhir_action_21 =
  fun _3 _4 ->
    (
# 139 "parser.mly"
                              (ASTOr(Ast.Or,_3, _4))
# 593 "parser.ml"
     : (Ast.expr))

let _menhir_action_22 =
  fun _2 _4 ->
    (
# 140 "parser.mly"
                              (ASTExprArgs(_2,_4))
# 601 "parser.ml"
     : (Ast.expr))

let _menhir_action_23 =
  fun _1 ->
    (
# 144 "parser.mly"
             (ASTExpr (_1) )
# 609 "parser.ml"
     : (Ast.exprs))

let _menhir_action_24 =
  fun _1 _2 ->
    (
# 145 "parser.mly"
             (ASTExprs(_1,_2))
# 617 "parser.ml"
     : (Ast.exprs))

let _menhir_action_25 =
  fun _1 ->
    (
# 83 "parser.mly"
                             ( ASTLvId(_1))
# 625 "parser.ml"
     : (Ast.lval))

let _menhir_action_26 =
  fun _2 _3 _4 ->
    (
# 84 "parser.mly"
                                 ( if _2 = "nth" then ASTLval(_3,_4) else raise Parsing.Parse_error)
# 633 "parser.ml"
     : (Ast.lval))

let _menhir_action_27 =
  fun _2 ->
    (
# 53 "parser.mly"
                      ( ASTProg(_2) )
# 641 "parser.ml"
     : (Ast.prog))

let _menhir_action_28 =
  fun _2 ->
    (
# 69 "parser.mly"
                        ( ASTEcho(_2) )
# 649 "parser.ml"
     : (Ast.stat))

let _menhir_action_29 =
  fun _2 _3 _4 ->
    (
# 73 "parser.mly"
                        ( ASTIF(_2, _3, _4) )
# 657 "parser.ml"
     : (Ast.stat))

let _menhir_action_30 =
  fun _2 _3 ->
    (
# 74 "parser.mly"
                        ( ASTWhile(_2, _3) )
# 665 "parser.ml"
     : (Ast.stat))

let _menhir_action_31 =
  fun _2 _3 ->
    (
# 75 "parser.mly"
                         ( ASTCall(_2, _3) )
# 673 "parser.ml"
     : (Ast.stat))

let _menhir_action_32 =
  fun _2 _3 ->
    (
# 78 "parser.mly"
                            ( ASTSet(_2, _3) )
# 681 "parser.ml"
     : (Ast.stat))

let _menhir_action_33 =
  fun _1 ->
    (
# 108 "parser.mly"
                      ( TypeBoolInt(_1) )
# 689 "parser.ml"
     : (Ast.typ))

let _menhir_action_34 =
  fun _1 ->
    (
# 109 "parser.mly"
                      ( TypeVoid(_1) )
# 697 "parser.ml"
     : (Ast.typ))

let _menhir_action_35 =
  fun _1 _3 ->
    (
# 110 "parser.mly"
                      ( ASTTypeFunc(_1, _3) )
# 705 "parser.ml"
     : (Ast.typ))

let _menhir_action_36 =
  fun _3 ->
    (
# 112 "parser.mly"
                            ( TypeVec(_3) )
# 713 "parser.ml"
     : (Ast.typ))

let _menhir_action_37 =
  fun () ->
    (
# 100 "parser.mly"
            (Int)
# 721 "parser.ml"
     : (Ast.typeBoolInt))

let _menhir_action_38 =
  fun () ->
    (
# 101 "parser.mly"
               (Bool)
# 729 "parser.ml"
     : (Ast.typeBoolInt))

let _menhir_action_39 =
  fun () ->
    (
# 105 "parser.mly"
               (Void)
# 737 "parser.ml"
     : (Ast.typeVoid))

let _menhir_action_40 =
  fun _1 ->
    (
# 117 "parser.mly"
                       (ASTType(_1))
# 745 "parser.ml"
     : (Ast.typs))

let _menhir_action_41 =
  fun _1 _3 ->
    (
# 118 "parser.mly"
                      (ASTTypes(_1,_3))
# 753 "parser.ml"
     : (Ast.typs))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AND ->
        "AND"
    | ARROW ->
        "ARROW"
    | BOOL ->
        "BOOL"
    | CALL ->
        "CALL"
    | COLON ->
        "COLON"
    | COMA ->
        "COMA"
    | CONST ->
        "CONST"
    | ECHO ->
        "ECHO"
    | FALSE ->
        "FALSE"
    | FUN ->
        "FUN"
    | FUNC ->
        "FUNC"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | IF2 ->
        "IF2"
    | INT ->
        "INT"
    | LBRA ->
        "LBRA"
    | LPAR ->
        "LPAR"
    | NOT ->
        "NOT"
    | NUM _ ->
        "NUM"
    | OR ->
        "OR"
    | PROC ->
        "PROC"
    | RBRA ->
        "RBRA"
    | REC ->
        "REC"
    | RPAR ->
        "RPAR"
    | SEMICOLON ->
        "SEMICOLON"
    | SET ->
        "SET"
    | STAR ->
        "STAR"
    | TRUE ->
        "TRUE"
    | VAR ->
        "VAR"
    | VEC ->
        "VEC"
    | VOID ->
        "VOID"
    | WHILE ->
        "WHILE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_114 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      let _2 = _v in
      let _v = _menhir_action_27 _2 in
      MenhirBox_prog _v
  
  let rec _menhir_run_002 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState002 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM _v ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_003 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_16 () in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState100 ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState096 ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState094 ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState086 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState077 ->
          _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState063 ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState060 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState002 ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState103 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState049 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState046 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState005 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState043 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState042 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState039 ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState038 ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState037 ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState034 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState006 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState027 ->
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_101 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_typ (_menhir_stack, _, _3) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_CONST (_menhir_stack, _menhir_s) = _menhir_stack in
      let _4 = _v in
      let _v = _menhir_action_08 _2 _3 _4 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_def : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_def (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _menhir_s = MenhirState108 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | VAR ->
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SET ->
              _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PROC ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF2 ->
              _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FUNC ->
              _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FUN ->
              _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ECHO ->
              _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONST ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CALL ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_053 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState054 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_010 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_39 () in
      let _1 = _v in
      let _v = _menhir_action_34 _1 in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState099 ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState009 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState012 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState020 ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState016 ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_100 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | NUM _v_0 ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState100
      | LPAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | IDENT _v_1 ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState100
      | FALSE ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_40 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_020 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_typ as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STAR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState020 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_011 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VEC ->
          let _menhir_s = MenhirState012 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_013 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_37 () in
      _menhir_goto_typeBoolInt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typeBoolInt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _1 = _v in
      let _v = _menhir_action_33 _1 in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_014 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_38 () in
      _menhir_goto_typeBoolInt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_004 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_14 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_005 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState005 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | OR ->
          let _menhir_stack = MenhirCell1_OR (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState006 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM _v ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LPAR ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRA ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | NUM _v ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState037 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM _v ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LPAR ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRA ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | IDENT _v ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          let _menhir_stack = MenhirCell1_AND (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState042 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM _v ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LPAR ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRA ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_007 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState007 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_008 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState009 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_028 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_15 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_029 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_17 () in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typs : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState020 ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState099 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState090 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState082 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState054 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState009 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState016 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState012 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_021 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_typs (_menhir_stack, _menhir_s, _v) in
      _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer
  
  and _menhir_run_016 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_typs -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState016 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_015 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_typs (_menhir_stack, _menhir_s, _v) in
      _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer
  
  and _menhir_run_091 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState091
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, MenhirState091) in
          let _menhir_s = MenhirState092 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_40 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_083 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState083
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, MenhirState083) in
          let _menhir_s = MenhirState084 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_40 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_055 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_VAR _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState055
      | SEMICOLON ->
          let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
          let MenhirCell1_VAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_09 _2 _3 in
          _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_40 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_025 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState025
      | COMA | RBRA ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_01 _1 _3 in
          (match (_tok : MenhirBasics.token) with
          | COMA ->
              let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
              let _menhir_s = MenhirState032 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | RBRA ->
              let _1 = _v in
              let _v = _menhir_action_02 _1 in
              _menhir_goto_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _menhir_fail ())
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_40 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_args : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState092 ->
          _menhir_run_093 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState084 ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState073 ->
          _menhir_run_074 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState068 ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState032 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState007 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_093 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState094 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM _v ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_085 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState086 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM _v ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_074 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_PROC _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState075 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRA ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_052 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState052 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | VAR ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SET ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PROC ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF2 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FUNC ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FUN ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ECHO ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CONST ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CALL ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_056 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SET (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState056 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_057 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState058 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAR ->
              _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_059 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_25 _1 in
      _menhir_goto_lval _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_lval : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState056 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState058 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_063 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_SET as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_lval (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | NUM _v_0 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState063
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | IDENT _v_1 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState063
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | _ ->
          _eRR ()
  
  and _menhir_run_060 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_lval (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | NUM _v_0 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState060
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | IDENT _v_1 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState060
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | _ ->
          _eRR ()
  
  and _menhir_run_065 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PROC (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REC ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | LBRA ->
                  let _menhir_s = MenhirState068 in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | IDENT _v ->
                      _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRA ->
              let _menhir_s = MenhirState073 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_077 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF2 (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState077 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM _v ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_081 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FUNC (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState082 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_088 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FUN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REC ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _menhir_s = MenhirState090 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LPAR ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_096 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ECHO (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState096 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM _v ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_098 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CONST (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState099 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_102 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CALL (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState103 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM _v ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LPAR ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRA ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_069 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_PROC _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState070 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRA ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_033 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_arg -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_arg (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_03 _1 _3 in
      _menhir_goto_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_026 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState027 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM _v ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_023 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState023
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_36 _3 in
          _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_40 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_022 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_40 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_019 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_typs as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
      | ARROW | COMA | FALSE | IDENT _ | LBRA | LPAR | NUM _ | RBRA | RPAR | SEMICOLON | TRUE ->
          let MenhirCell1_typs (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_35 _1 _3 in
          _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_097 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ECHO -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ECHO (_menhir_stack, _menhir_s) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_28 _2 in
      _menhir_goto_stat _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_stat : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _menhir_stack = MenhirCell1_stat (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState106 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | VAR ->
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SET ->
              _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PROC ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF2 ->
              _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FUNC ->
              _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FUN ->
              _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ECHO ->
              _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONST ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CALL ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RBRA ->
          let _1 = _v in
          let _v = _menhir_action_05 _1 in
          _menhir_goto_cmds _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_cmds : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState001 ->
          _menhir_run_114 _menhir_stack _v
      | MenhirState052 ->
          _menhir_run_111 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState106 ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState108 ->
          _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_111 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_LBRA -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRA (_menhir_stack, _menhir_s) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_04 _2 in
      _menhir_goto_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_block : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState051 ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState079 ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState078 ->
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState075 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState070 ->
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_113 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_WHILE, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_WHILE (_menhir_stack, _menhir_s) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_30 _2 _3 in
      _menhir_goto_stat _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_080 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_IF2, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_block -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_block (_menhir_stack, _, _3) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_IF2 (_menhir_stack, _menhir_s) = _menhir_stack in
      let _4 = _v in
      let _v = _menhir_action_29 _2 _3 _4 in
      _menhir_goto_stat _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_079 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_IF2, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_block (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRA ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState079
      | _ ->
          _eRR ()
  
  and _menhir_run_076 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_PROC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _4) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_PROC (_menhir_stack, _menhir_s) = _menhir_stack in
      let _6 = _v in
      let _v = _menhir_action_12 _2 _4 _6 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_071 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_PROC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _5) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _3) = _menhir_stack in
      let MenhirCell1_PROC (_menhir_stack, _menhir_s) = _menhir_stack in
      let _7 = _v in
      let _v = _menhir_action_13 _3 _5 _7 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_110 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_stat -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_stat (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_07 _1 _3 in
      _menhir_goto_cmds _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_109 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_def -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_def (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_06 _1 _3 in
      _menhir_goto_cmds _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_095 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _6) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typ (_menhir_stack, _, _4) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _3) = _menhir_stack in
      let MenhirCell1_FUN (_menhir_stack, _menhir_s) = _menhir_stack in
      let _8 = _v in
      let _v = _menhir_action_11 _3 _4 _6 _8 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_087 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _5) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typ (_menhir_stack, _, _3) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_FUNC (_menhir_stack, _menhir_s) = _menhir_stack in
      let _7 = _v in
      let _v = _menhir_action_10 _2 _3 _5 _7 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_078 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IF2 as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRA ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState078
      | _ ->
          _eRR ()
  
  and _menhir_run_064 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_SET, _menhir_box_prog) _menhir_cell1_lval -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_lval (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_SET (_menhir_stack, _menhir_s) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_32 _2 _3 in
      _menhir_goto_stat _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_061 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_lval -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_lval (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _4 = _v in
          let _v = _menhir_action_26 _2 _3 _4 in
          _menhir_goto_lval _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_051 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_WHILE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRA ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState051
      | _ ->
          _eRR ()
  
  and _menhir_run_049 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState049
      | NUM _v_0 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState049
      | LPAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState049
      | LBRA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState049
      | IDENT _v_1 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState049
      | FALSE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState049
      | RBRA | RPAR | SEMICOLON ->
          let _1 = _v in
          let _v = _menhir_action_23 _1 in
          _menhir_goto_exprs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_exprs : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState103 ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState049 ->
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState046 ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_104 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_CALL _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_CALL (_menhir_stack, _menhir_s) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_31 _2 _3 in
      _menhir_goto_stat _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_050 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_24 _1 _2 in
      _menhir_goto_exprs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_047 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _2) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_18 _2 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_046 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | NUM _v_0 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState046
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | IDENT _v_1 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState046
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | _ ->
          _eRR ()
  
  and _menhir_run_044 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_AND (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _4 = _v in
          let _v = _menhir_action_20 _3 _4 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_043 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState043
      | NUM _v_0 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState043
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState043
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState043
      | IDENT _v_1 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState043
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState043
      | _ ->
          _eRR ()
  
  and _menhir_run_040 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _4) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_IF (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _5 = _v in
          let _v = _menhir_action_19 _3 _4 _5 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_039 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState039
      | NUM _v_0 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState039
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState039
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState039
      | IDENT _v_1 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState039
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState039
      | _ ->
          _eRR ()
  
  and _menhir_run_038 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | NUM _v_0 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState038
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | IDENT _v_1 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState038
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | _ ->
          _eRR ()
  
  and _menhir_run_035 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_OR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _4 = _v in
          let _v = _menhir_action_21 _3 _4 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_034 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | NUM _v_0 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState034
      | LPAR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | LBRA ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | IDENT _v_1 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState034
      | FALSE ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState034
      | _ ->
          _eRR ()
  
  and _menhir_run_030 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _menhir_s) = _menhir_stack in
      let _4 = _v in
      let _v = _menhir_action_22 _2 _4 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let rec _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRA ->
          let _menhir_s = MenhirState001 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | VAR ->
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SET ->
              _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PROC ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF2 ->
              _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FUNC ->
              _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FUN ->
              _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ECHO ->
              _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONST ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CALL ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
