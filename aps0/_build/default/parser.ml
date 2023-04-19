
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | TRUE
    | TIMES
    | STAR
    | SEMICOLON
    | RPAR
    | REC
    | RBRA
    | OR
    | NUM of (
# 16 "parser.mly"
       (int)
# 23 "parser.ml"
  )
    | NOT
    | MINUS
    | LPAR
    | LESS
    | LBRA
    | INT
    | IF
    | IDENT of (
# 17 "parser.mly"
       (string)
# 35 "parser.ml"
  )
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


# 70 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState01 : ('s, _menhir_box_prog) _menhir_state
    (** State 01.
        Stack shape : .
        Start symbol: prog. *)

  | MenhirState04 : (('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 04.
        Stack shape : FUN IDENT.
        Start symbol: prog. *)

  | MenhirState08 : (('s, _menhir_box_prog) _menhir_cell1_typs, _menhir_box_prog) _menhir_state
    (** State 08.
        Stack shape : typs.
        Start symbol: prog. *)

  | MenhirState10 : ((('s, _menhir_box_prog) _menhir_cell1_typs, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 10.
        Stack shape : typs typ.
        Start symbol: prog. *)

  | MenhirState11 : ((('s, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR, _menhir_box_prog) _menhir_state
    (** State 11.
        Stack shape : typ STAR.
        Start symbol: prog. *)

  | MenhirState13 : (((('s, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 13.
        Stack shape : typ STAR typ.
        Start symbol: prog. *)

  | MenhirState14 : ((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 14.
        Stack shape : FUN IDENT typ.
        Start symbol: prog. *)

  | MenhirState15 : (((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 15.
        Stack shape : FUN IDENT typ LBRA.
        Start symbol: prog. *)

  | MenhirState17 : (('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_state
    (** State 17.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState18 : ((('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 18.
        Stack shape : IDENT typ.
        Start symbol: prog. *)

  | MenhirState20 : ((((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 20.
        Stack shape : FUN IDENT typ LBRA args.
        Start symbol: prog. *)

  | MenhirState22 : (('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_state
    (** State 22.
        Stack shape : LPAR.
        Start symbol: prog. *)

  | MenhirState23 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_state
    (** State 23.
        Stack shape : LPAR OR.
        Start symbol: prog. *)

  | MenhirState24 : (('s, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 24.
        Stack shape : LBRA.
        Start symbol: prog. *)

  | MenhirState26 : ((('s, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 26.
        Stack shape : LBRA args.
        Start symbol: prog. *)

  | MenhirState30 : (('s, _menhir_box_prog) _menhir_cell1_arg, _menhir_box_prog) _menhir_state
    (** State 30.
        Stack shape : arg.
        Start symbol: prog. *)

  | MenhirState32 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 32.
        Stack shape : LPAR OR expr.
        Start symbol: prog. *)

  | MenhirState35 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_state
    (** State 35.
        Stack shape : LPAR IF.
        Start symbol: prog. *)

  | MenhirState36 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 36.
        Stack shape : LPAR IF expr.
        Start symbol: prog. *)

  | MenhirState37 : ((((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 37.
        Stack shape : LPAR IF expr expr.
        Start symbol: prog. *)

  | MenhirState40 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_state
    (** State 40.
        Stack shape : LPAR AND.
        Start symbol: prog. *)

  | MenhirState41 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 41.
        Stack shape : LPAR AND expr.
        Start symbol: prog. *)

  | MenhirState44 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 44.
        Stack shape : LPAR expr.
        Start symbol: prog. *)

  | MenhirState47 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 47.
        Stack shape : expr expr.
        Start symbol: prog. *)

  | MenhirState50 : (('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 50.
        Stack shape : FUN IDENT.
        Start symbol: prog. *)

  | MenhirState51 : ((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 51.
        Stack shape : FUN IDENT typ.
        Start symbol: prog. *)

  | MenhirState52 : (((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 52.
        Stack shape : FUN IDENT typ LBRA.
        Start symbol: prog. *)

  | MenhirState54 : ((((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 54.
        Stack shape : FUN IDENT typ LBRA args.
        Start symbol: prog. *)

  | MenhirState56 : (('s, _menhir_box_prog) _menhir_cell1_ECHO, _menhir_box_prog) _menhir_state
    (** State 56.
        Stack shape : ECHO.
        Start symbol: prog. *)

  | MenhirState59 : (('s, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 59.
        Stack shape : CONST IDENT.
        Start symbol: prog. *)

  | MenhirState60 : ((('s, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 60.
        Stack shape : CONST IDENT typ.
        Start symbol: prog. *)

  | MenhirState64 : (('s, _menhir_box_prog) _menhir_cell1_def, _menhir_box_prog) _menhir_state
    (** State 64.
        Stack shape : def.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_arg = 
  | MenhirCell1_arg of 's * ('s, 'r) _menhir_state * (Ast.arg)

and ('s, 'r) _menhir_cell1_args = 
  | MenhirCell1_args of 's * ('s, 'r) _menhir_state * (Ast.args)

and ('s, 'r) _menhir_cell1_def = 
  | MenhirCell1_def of 's * ('s, 'r) _menhir_state * (Ast.def)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr)

and ('s, 'r) _menhir_cell1_typ = 
  | MenhirCell1_typ of 's * ('s, 'r) _menhir_state * (Ast.typ)

and ('s, 'r) _menhir_cell1_typs = 
  | MenhirCell1_typs of 's * ('s, 'r) _menhir_state * (Ast.typs)

and ('s, 'r) _menhir_cell1_AND = 
  | MenhirCell1_AND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CONST = 
  | MenhirCell1_CONST of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ECHO = 
  | MenhirCell1_ECHO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FUN = 
  | MenhirCell1_FUN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 17 "parser.mly"
       (string)
# 268 "parser.ml"
)

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 17 "parser.mly"
       (string)
# 275 "parser.ml"
)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LBRA = 
  | MenhirCell1_LBRA of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAR = 
  | MenhirCell1_LPAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OR = 
  | MenhirCell1_OR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_STAR = 
  | MenhirCell1_STAR of 's * ('s, 'r) _menhir_state

and _menhir_box_prog = 
  | MenhirBox_prog of (Ast.cmds) [@@unboxed]

let _menhir_action_01 =
  fun _1 _3 ->
    (
# 83 "parser.mly"
                      ( ASTArg1(_1,_3) )
# 301 "parser.ml"
     : (Ast.arg))

let _menhir_action_02 =
  fun _1 ->
    (
# 87 "parser.mly"
                        ( ASTArg2(_1) )
# 309 "parser.ml"
     : (Ast.args))

let _menhir_action_03 =
  fun _1 _3 ->
    (
# 88 "parser.mly"
                        ( ASTArgs(_1,_3) )
# 317 "parser.ml"
     : (Ast.args))

let _menhir_action_04 =
  fun _1 ->
    (
# 54 "parser.mly"
                        ( ASTStat (_1) )
# 325 "parser.ml"
     : (Ast.cmds))

let _menhir_action_05 =
  fun _1 _3 ->
    (
# 55 "parser.mly"
                        (ASTDef(_1, _3))
# 333 "parser.ml"
     : (Ast.cmds))

let _menhir_action_06 =
  fun _2 _3 _4 ->
    (
# 63 "parser.mly"
                          (ASTConst(_2, _3, _4))
# 341 "parser.ml"
     : (Ast.def))

let _menhir_action_07 =
  fun _2 _3 _5 _7 ->
    (
# 64 "parser.mly"
                                    (ASTFunc(_2, _3 ,_5, _7))
# 349 "parser.ml"
     : (Ast.def))

let _menhir_action_08 =
  fun _3 _4 _6 _8 ->
    (
# 65 "parser.mly"
                                        (ASTFuncRec(_3, _4, _6, _8))
# 357 "parser.ml"
     : (Ast.def))

let _menhir_action_09 =
  fun _1 ->
    (
# 93 "parser.mly"
                              ( ASTNum(_1) )
# 365 "parser.ml"
     : (Ast.expr))

let _menhir_action_10 =
  fun _1 ->
    (
# 94 "parser.mly"
                              ( ASTId(_1) )
# 373 "parser.ml"
     : (Ast.expr))

let _menhir_action_11 =
  fun _2 _3 ->
    (
# 95 "parser.mly"
                              ( ASTApp(_2, _3) )
# 381 "parser.ml"
     : (Ast.expr))

let _menhir_action_12 =
  fun _3 _4 _5 ->
    (
# 96 "parser.mly"
                              ( ASTIf(_3, _4, _5) )
# 389 "parser.ml"
     : (Ast.expr))

let _menhir_action_13 =
  fun _3 _4 ->
    (
# 97 "parser.mly"
                              ( ASTAnd(Ast.And, _3, _4) )
# 397 "parser.ml"
     : (Ast.expr))

let _menhir_action_14 =
  fun _3 _4 ->
    (
# 98 "parser.mly"
                              ( ASTOr(Ast.Or,_3, _4) )
# 405 "parser.ml"
     : (Ast.expr))

let _menhir_action_15 =
  fun _2 _4 ->
    (
# 99 "parser.mly"
                              ( ASTExprArgs(_2,_4) )
# 413 "parser.ml"
     : (Ast.expr))

let _menhir_action_16 =
  fun _1 ->
    (
# 104 "parser.mly"
             ( ASTExpr (_1) )
# 421 "parser.ml"
     : (Ast.exprs))

let _menhir_action_17 =
  fun _1 _2 ->
    (
# 105 "parser.mly"
             ( ASTExprs(_1,_2))
# 429 "parser.ml"
     : (Ast.exprs))

let _menhir_action_18 =
  fun _2 ->
    (
# 50 "parser.mly"
                        ( _2 )
# 437 "parser.ml"
     : (Ast.cmds))

let _menhir_action_19 =
  fun _2 ->
    (
# 59 "parser.mly"
                        ( ASTEcho(_2) )
# 445 "parser.ml"
     : (Ast.stat))

let _menhir_action_20 =
  fun _1 ->
    (
# 74 "parser.mly"
                      ( TypeBoolInt(_1) )
# 453 "parser.ml"
     : (Ast.typ))

let _menhir_action_21 =
  fun _1 _3 ->
    (
# 75 "parser.mly"
                      ( ASTTypeFunc(_1, _3))
# 461 "parser.ml"
     : (Ast.typ))

let _menhir_action_22 =
  fun () ->
    (
# 69 "parser.mly"
              (Bool)
# 469 "parser.ml"
     : (Ast.typeBoolInt))

let _menhir_action_23 =
  fun () ->
    (
# 70 "parser.mly"
              (Int)
# 477 "parser.ml"
     : (Ast.typeBoolInt))

let _menhir_action_24 =
  fun _1 ->
    (
# 79 "parser.mly"
                        ( ASTType(_1))
# 485 "parser.ml"
     : (Ast.typs))

let _menhir_action_25 =
  fun _1 _3 ->
    (
# 80 "parser.mly"
                        ( ASTTypes(_1,_3))
# 493 "parser.ml"
     : (Ast.typs))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ADD ->
        "ADD"
    | AND ->
        "AND"
    | ARROW ->
        "ARROW"
    | BOOL ->
        "BOOL"
    | COLON ->
        "COLON"
    | COMA ->
        "COMA"
    | CONST ->
        "CONST"
    | DIV ->
        "DIV"
    | ECHO ->
        "ECHO"
    | EQUAL ->
        "EQUAL"
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
    | INT ->
        "INT"
    | LBRA ->
        "LBRA"
    | LESS ->
        "LESS"
    | LPAR ->
        "LPAR"
    | MINUS ->
        "MINUS"
    | NOT ->
        "NOT"
    | NUM _ ->
        "NUM"
    | OR ->
        "OR"
    | RBRA ->
        "RBRA"
    | REC ->
        "REC"
    | RPAR ->
        "RPAR"
    | SEMICOLON ->
        "SEMICOLON"
    | STAR ->
        "STAR"
    | TIMES ->
        "TIMES"
    | TRUE ->
        "TRUE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_66 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRA ->
          let _2 = _v in
          let _v = _menhir_action_18 _2 in
          MenhirBox_prog _v
      | _ ->
          _eRR ()
  
  let rec _menhir_goto_cmds : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState01 ->
          _menhir_run_66 _menhir_stack _v _tok
      | MenhirState64 ->
          _menhir_run_65 _menhir_stack _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_65 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_def -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _v _tok ->
      let MenhirCell1_def (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_05 _1 _3 in
      _menhir_goto_cmds _menhir_stack _v _menhir_s _tok
  
  let rec _menhir_run_57 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ECHO -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _v _tok ->
      let MenhirCell1_ECHO (_menhir_stack, _menhir_s) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_19 _2 in
      let _1 = _v in
      let _v = _menhir_action_04 _1 in
      _menhir_goto_cmds _menhir_stack _v _menhir_s _tok
  
  let rec _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FUN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REC ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _menhir_s = MenhirState04 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | INT ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState50 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_23 () in
      _menhir_goto_typeBoolInt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typeBoolInt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _1 = _v in
      let _v = _menhir_action_20 _1 in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState59 ->
          _menhir_run_60 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState50 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState17 ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState04 ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState11 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState08 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_60 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState60
      | NUM _v_0 ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState60
      | LPAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState60
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState60
      | IDENT _v_1 ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState60
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_24 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_typ as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STAR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState11 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_22 () in
      _menhir_goto_typeBoolInt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_21 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_09 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState60 ->
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState56 ->
          _menhir_run_57 _menhir_stack _v _tok
      | MenhirState54 ->
          _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState20 ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState47 ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState44 ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState22 ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState41 ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState40 ->
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState37 ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState36 ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState35 ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState32 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState23 ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState26 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_61 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_typ (_menhir_stack, _, _3) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_CONST (_menhir_stack, _menhir_s) = _menhir_stack in
      let _4 = _v in
      let _v = _menhir_action_06 _2 _3 _4 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_def : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_def (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _menhir_s = MenhirState64 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | FUN ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ECHO ->
              _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONST ->
              _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_56 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ECHO (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState56 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _v ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_22 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState22 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OR ->
          let _menhir_stack = MenhirCell1_OR (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState23 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _v ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LPAR ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRA ->
              _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | NUM _v ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState35 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _v ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LPAR ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRA ->
              _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | IDENT _v ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | AND ->
          let _menhir_stack = MenhirCell1_AND (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState40 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _v ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LPAR ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRA ->
              _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_24 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState24 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_16 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState17 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_27 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_10 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_58 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CONST (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _menhir_s = MenhirState59 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_55 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _5) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typ (_menhir_stack, _, _3) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_FUN (_menhir_stack, _menhir_s) = _menhir_stack in
      let _7 = _v in
      let _v = _menhir_action_07 _2 _3 _5 _7 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_49 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _6) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typ (_menhir_stack, _, _4) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _3) = _menhir_stack in
      let MenhirCell1_FUN (_menhir_stack, _menhir_s) = _menhir_stack in
      let _8 = _v in
      let _v = _menhir_action_08 _3 _4 _6 _8 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_47 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState47
      | LPAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState47
      | LBRA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState47
      | IDENT _v_1 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState47
      | RPAR ->
          let _1 = _v in
          let _v = _menhir_action_16 _1 in
          _menhir_goto_exprs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_exprs : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState47 ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState44 ->
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_48 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_17 _1 _2 in
      _menhir_goto_exprs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_45 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_expr (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_11 _2 _3 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_44 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState44
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState44
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState44
      | IDENT _v_1 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState44
      | _ ->
          _eRR ()
  
  and _menhir_run_42 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_AND (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _4 = _v in
          let _v = _menhir_action_13 _3 _4 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_41 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState41
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState41
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState41
      | IDENT _v_1 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState41
      | _ ->
          _eRR ()
  
  and _menhir_run_38 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _4) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_IF (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _5 = _v in
          let _v = _menhir_action_12 _3 _4 _5 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_37 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState37
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
      | IDENT _v_1 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState37
      | _ ->
          _eRR ()
  
  and _menhir_run_36 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState36
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState36
      | IDENT _v_1 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState36
      | _ ->
          _eRR ()
  
  and _menhir_run_33 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_OR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _4 = _v in
          let _v = _menhir_action_14 _3 _4 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_32 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState32
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState32
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState32
      | IDENT _v_1 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState32
      | _ ->
          _eRR ()
  
  and _menhir_run_28 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _menhir_s) = _menhir_stack in
      let _4 = _v in
      let _v = _menhir_action_15 _2 _4 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typs : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState11 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState59 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState50 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState17 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState08 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState04 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_12 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_typs (_menhir_stack, _menhir_s, _v) in
      _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer
  
  and _menhir_run_08 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_typs -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState08 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_typs (_menhir_stack, _menhir_s, _v) in
      _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer
  
  and _menhir_run_51 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState51
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, MenhirState51) in
          let _menhir_s = MenhirState52 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_24 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | COMA | RBRA ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_01 _1 _3 in
          (match (_tok : MenhirBasics.token) with
          | COMA ->
              let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
              let _menhir_s = MenhirState30 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
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
          let _v = _menhir_action_24 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_args : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState52 ->
          _menhir_run_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState30 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState24 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState15 ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_53 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState54 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _v ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_31 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_arg -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_arg (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_03 _1 _3 in
      _menhir_goto_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_25 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState26 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _v ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_19 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState20 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _v ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRA ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_14 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, MenhirState14) in
          let _menhir_s = MenhirState15 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_24 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_13 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState13
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_24 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_typs as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState10
      | ARROW | COMA | IDENT _ | LBRA | LPAR | NUM _ | RBRA ->
          let MenhirCell1_typs (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_21 _1 _3 in
          _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRA ->
          let _menhir_s = MenhirState01 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | FUN ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ECHO ->
              _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONST ->
              _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
