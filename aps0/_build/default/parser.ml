
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

  | MenhirState03 : (('s, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 03.
        Stack shape : FUNC IDENT.
        Start symbol: prog. *)

  | MenhirState07 : (('s, _menhir_box_prog) _menhir_cell1_typs, _menhir_box_prog) _menhir_state
    (** State 07.
        Stack shape : typs.
        Start symbol: prog. *)

  | MenhirState09 : ((('s, _menhir_box_prog) _menhir_cell1_typs, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 09.
        Stack shape : typs typ.
        Start symbol: prog. *)

  | MenhirState10 : ((('s, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR, _menhir_box_prog) _menhir_state
    (** State 10.
        Stack shape : typ STAR.
        Start symbol: prog. *)

  | MenhirState12 : (((('s, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 12.
        Stack shape : typ STAR typ.
        Start symbol: prog. *)

  | MenhirState13 : ((('s, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 13.
        Stack shape : FUNC IDENT typ.
        Start symbol: prog. *)

  | MenhirState14 : (((('s, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 14.
        Stack shape : FUNC IDENT typ LBRA.
        Start symbol: prog. *)

  | MenhirState16 : (('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_state
    (** State 16.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState17 : ((('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 17.
        Stack shape : IDENT typ.
        Start symbol: prog. *)

  | MenhirState19 : ((((('s, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 19.
        Stack shape : FUNC IDENT typ LBRA args.
        Start symbol: prog. *)

  | MenhirState21 : (('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_state
    (** State 21.
        Stack shape : LPAR.
        Start symbol: prog. *)

  | MenhirState22 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_state
    (** State 22.
        Stack shape : LPAR OR.
        Start symbol: prog. *)

  | MenhirState23 : (('s, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 23.
        Stack shape : LBRA.
        Start symbol: prog. *)

  | MenhirState25 : ((('s, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 25.
        Stack shape : LBRA args.
        Start symbol: prog. *)

  | MenhirState29 : (('s, _menhir_box_prog) _menhir_cell1_arg, _menhir_box_prog) _menhir_state
    (** State 29.
        Stack shape : arg.
        Start symbol: prog. *)

  | MenhirState31 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 31.
        Stack shape : LPAR OR expr.
        Start symbol: prog. *)

  | MenhirState34 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_NOT, _menhir_box_prog) _menhir_state
    (** State 34.
        Stack shape : LPAR NOT.
        Start symbol: prog. *)

  | MenhirState37 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_state
    (** State 37.
        Stack shape : LPAR IF.
        Start symbol: prog. *)

  | MenhirState38 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 38.
        Stack shape : LPAR IF expr.
        Start symbol: prog. *)

  | MenhirState39 : ((((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 39.
        Stack shape : LPAR IF expr expr.
        Start symbol: prog. *)

  | MenhirState42 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_state
    (** State 42.
        Stack shape : LPAR AND.
        Start symbol: prog. *)

  | MenhirState43 : (((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 43.
        Stack shape : LPAR AND expr.
        Start symbol: prog. *)

  | MenhirState46 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 46.
        Stack shape : LPAR expr.
        Start symbol: prog. *)

  | MenhirState49 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 49.
        Stack shape : expr expr.
        Start symbol: prog. *)

  | MenhirState54 : (('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 54.
        Stack shape : FUN IDENT.
        Start symbol: prog. *)

  | MenhirState55 : ((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 55.
        Stack shape : FUN IDENT typ.
        Start symbol: prog. *)

  | MenhirState56 : (((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_state
    (** State 56.
        Stack shape : FUN IDENT typ LBRA.
        Start symbol: prog. *)

  | MenhirState58 : ((((('s, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 58.
        Stack shape : FUN IDENT typ LBRA args.
        Start symbol: prog. *)

  | MenhirState60 : (('s, _menhir_box_prog) _menhir_cell1_ECHO, _menhir_box_prog) _menhir_state
    (** State 60.
        Stack shape : ECHO.
        Start symbol: prog. *)

  | MenhirState63 : (('s, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 63.
        Stack shape : CONST IDENT.
        Start symbol: prog. *)

  | MenhirState64 : ((('s, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 64.
        Stack shape : CONST IDENT typ.
        Start symbol: prog. *)

  | MenhirState68 : (('s, _menhir_box_prog) _menhir_cell1_def, _menhir_box_prog) _menhir_state
    (** State 68.
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

and ('s, 'r) _menhir_cell1_FUNC = 
  | MenhirCell1_FUNC of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 17 "parser.mly"
       (string)
# 276 "parser.ml"
)

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 17 "parser.mly"
       (string)
# 283 "parser.ml"
)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LBRA = 
  | MenhirCell1_LBRA of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAR = 
  | MenhirCell1_LPAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NOT = 
  | MenhirCell1_NOT of 's * ('s, 'r) _menhir_state

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
                      (ASTArg1(_1,_3))
# 312 "parser.ml"
     : (Ast.arg))

let _menhir_action_02 =
  fun _1 ->
    (
# 87 "parser.mly"
                        (ASTArg2(_1))
# 320 "parser.ml"
     : (Ast.args))

let _menhir_action_03 =
  fun _1 _3 ->
    (
# 88 "parser.mly"
                        (ASTArgs(_1,_3))
# 328 "parser.ml"
     : (Ast.args))

let _menhir_action_04 =
  fun _1 ->
    (
# 54 "parser.mly"
                        ( ASTStat (_1) )
# 336 "parser.ml"
     : (Ast.cmds))

let _menhir_action_05 =
  fun _1 _3 ->
    (
# 55 "parser.mly"
                        (ASTDef(_1, _3))
# 344 "parser.ml"
     : (Ast.cmds))

let _menhir_action_06 =
  fun _2 _3 _4 ->
    (
# 63 "parser.mly"
                          (ASTConst(_2, _3, _4))
# 352 "parser.ml"
     : (Ast.def))

let _menhir_action_07 =
  fun _2 _3 _5 _7 ->
    (
# 64 "parser.mly"
                                     (ASTFunc(_2, _3 ,_5, _7))
# 360 "parser.ml"
     : (Ast.def))

let _menhir_action_08 =
  fun _3 _4 _6 _8 ->
    (
# 65 "parser.mly"
                                        (ASTFuncRec(_3, _4, _6, _8))
# 368 "parser.ml"
     : (Ast.def))

let _menhir_action_09 =
  fun _1 ->
    (
# 93 "parser.mly"
                              ( ASTNum(_1) )
# 376 "parser.ml"
     : (Ast.expr))

let _menhir_action_10 =
  fun _1 ->
    (
# 94 "parser.mly"
                              ( ASTId(_1) )
# 384 "parser.ml"
     : (Ast.expr))

let _menhir_action_11 =
  fun _2 _3 ->
    (
# 95 "parser.mly"
                              ( ASTApp(_2, _3) )
# 392 "parser.ml"
     : (Ast.expr))

let _menhir_action_12 =
  fun _3 _4 _5 ->
    (
# 96 "parser.mly"
                              ( ASTIf(_3, _4, _5) )
# 400 "parser.ml"
     : (Ast.expr))

let _menhir_action_13 =
  fun _3 _4 ->
    (
# 97 "parser.mly"
                              ( ASTAnd(Ast.And, _3, _4) )
# 408 "parser.ml"
     : (Ast.expr))

let _menhir_action_14 =
  fun _3 _4 ->
    (
# 98 "parser.mly"
                              (ASTOr(Ast.Or,_3, _4))
# 416 "parser.ml"
     : (Ast.expr))

let _menhir_action_15 =
  fun _3 ->
    (
# 99 "parser.mly"
                              (ASTNot(Ast.Not,_3))
# 424 "parser.ml"
     : (Ast.expr))

let _menhir_action_16 =
  fun _2 _4 ->
    (
# 100 "parser.mly"
                              (ASTExprArgs(_2,_4))
# 432 "parser.ml"
     : (Ast.expr))

let _menhir_action_17 =
  fun _1 ->
    (
# 105 "parser.mly"
             (ASTExpr (_1) )
# 440 "parser.ml"
     : (Ast.exprs))

let _menhir_action_18 =
  fun _1 _2 ->
    (
# 106 "parser.mly"
             (ASTExprs(_1,_2))
# 448 "parser.ml"
     : (Ast.exprs))

let _menhir_action_19 =
  fun _2 ->
    (
# 50 "parser.mly"
                        ( _2 )
# 456 "parser.ml"
     : (Ast.cmds))

let _menhir_action_20 =
  fun _2 ->
    (
# 59 "parser.mly"
                        ( ASTEcho(_2) )
# 464 "parser.ml"
     : (Ast.stat))

let _menhir_action_21 =
  fun _1 ->
    (
# 74 "parser.mly"
                      ( TypeBoolInt(_1) )
# 472 "parser.ml"
     : (Ast.typ))

let _menhir_action_22 =
  fun _1 _3 ->
    (
# 75 "parser.mly"
                      ( ASTTypeFunc(_1, _3))
# 480 "parser.ml"
     : (Ast.typ))

let _menhir_action_23 =
  fun () ->
    (
# 69 "parser.mly"
              (Bool)
# 488 "parser.ml"
     : (Ast.typeBoolInt))

let _menhir_action_24 =
  fun () ->
    (
# 70 "parser.mly"
              (Int)
# 496 "parser.ml"
     : (Ast.typeBoolInt))

let _menhir_action_25 =
  fun _1 ->
    (
# 79 "parser.mly"
                        ( ASTType(_1))
# 504 "parser.ml"
     : (Ast.typs))

let _menhir_action_26 =
  fun _1 _3 ->
    (
# 80 "parser.mly"
                        ( ASTTypes(_1,_3))
# 512 "parser.ml"
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
  
  let rec _menhir_run_70 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRA ->
          let _2 = _v in
          let _v = _menhir_action_19 _2 in
          MenhirBox_prog _v
      | _ ->
          _eRR ()
  
  let rec _menhir_goto_cmds : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState01 ->
          _menhir_run_70 _menhir_stack _v _tok
      | MenhirState68 ->
          _menhir_run_69 _menhir_stack _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_69 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_def -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _v _tok ->
      let MenhirCell1_def (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_05 _1 _3 in
      _menhir_goto_cmds _menhir_stack _v _menhir_s _tok
  
  let rec _menhir_run_61 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ECHO -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _v _tok ->
      let MenhirCell1_ECHO (_menhir_stack, _menhir_s) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_20 _2 in
      let _1 = _v in
      let _v = _menhir_action_04 _1 in
      _menhir_goto_cmds _menhir_stack _v _menhir_s _tok
  
  let rec _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FUNC (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_24 () in
              _menhir_run_08_spec_03 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | BOOL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_23 () in
              _menhir_run_08_spec_03 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_08_spec_03 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _1 = _v in
      let _v = _menhir_action_21 _1 in
      _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState03 _tok
  
  and _menhir_run_13 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState13
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, MenhirState13) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState14
          | _ ->
              _eRR ())
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_25 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_typ as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_24 () in
          _menhir_run_08_spec_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | BOOL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_23 () in
          _menhir_run_08_spec_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_08_spec_10 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _1 = _v in
      let _v = _menhir_action_21 _1 in
      _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState10 _tok
  
  and _menhir_run_12 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState12
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_25 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_typs : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState10 ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState63 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState54 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState16 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState07 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState03 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_11 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_typs (_menhir_stack, _menhir_s, _v) in
      _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer
  
  and _menhir_run_07 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_typs -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_24 () in
          _menhir_run_08_spec_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | BOOL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_23 () in
          _menhir_run_08_spec_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_08_spec_07 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_typs -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _1 = _v in
      let _v = _menhir_action_21 _1 in
      _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07 _tok
  
  and _menhir_run_09 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_typs as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState09
      | ARROW | COMA | IDENT _ | LBRA | LPAR | NUM _ | RBRA ->
          let MenhirCell1_typs (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_22 _1 _3 in
          _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_typ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState63 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState54 ->
          _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState16 ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState03 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState10 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState07 ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_64 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | NUM _v_0 ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LPAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | IDENT _v_2 ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_25 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_65 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
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
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | FUNC ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState68
          | FUN ->
              _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState68
          | ECHO ->
              _menhir_run_60 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState68
          | CONST ->
              _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState68
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_52 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FUN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REC ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NUM _ ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_24 () in
                  _menhir_run_08_spec_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | BOOL ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_23 () in
                  _menhir_run_08_spec_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_08_spec_54 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _1 = _v in
      let _v = _menhir_action_21 _1 in
      _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState54 _tok
  
  and _menhir_run_55 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState55
      | LBRA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, MenhirState55) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56
          | _ ->
              _eRR ())
      | ARROW ->
          let _1 = _v in
          let _v = _menhir_action_25 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_15 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_24 () in
              _menhir_run_08_spec_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | BOOL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_23 () in
              _menhir_run_08_spec_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_08_spec_16 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _1 = _v in
      let _v = _menhir_action_21 _1 in
      _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState16 _tok
  
  and _menhir_run_17 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | COMA | RBRA ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_01 _1 _3 in
          (match (_tok : MenhirBasics.token) with
          | COMA ->
              let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState29
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
          let _v = _menhir_action_25 _1 in
          _menhir_goto_typs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_args : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState56 ->
          _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState29 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState23 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState14 ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_57 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState58
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState58
      | IDENT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_59 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUN _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _6) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typ (_menhir_stack, _, _4) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _3) = _menhir_stack in
      let MenhirCell1_FUN (_menhir_stack, _menhir_s) = _menhir_stack in
      let _8 = _v in
      let _v = _menhir_action_08 _3 _4 _6 _8 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_21 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OR ->
          let _menhir_stack = MenhirCell1_OR (_menhir_stack, MenhirState21) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _1 = _v in
              let _v = _menhir_action_09 _1 in
              _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
          | LPAR ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState22
          | LBRA ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState22
          | IDENT _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _1 = _v in
              let _v = _menhir_action_10 _1 in
              _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
          | _ ->
              _eRR ())
      | NUM _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v in
          let _v = _menhir_action_09 _1 in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState21 _tok
      | NOT ->
          let _menhir_stack = MenhirCell1_NOT (_menhir_stack, MenhirState21) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _1 = _v in
              let _v = _menhir_action_09 _1 in
              _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | LPAR ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState34
          | LBRA ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState34
          | IDENT _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _1 = _v in
              let _v = _menhir_action_10 _1 in
              _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState21
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState21
      | IF ->
          let _menhir_stack = MenhirCell1_IF (_menhir_stack, MenhirState21) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _1 = _v in
              let _v = _menhir_action_09 _1 in
              _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState37 _tok
          | LPAR ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
          | LBRA ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
          | IDENT _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _1 = _v in
              let _v = _menhir_action_10 _1 in
              _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState37 _tok
          | _ ->
              _eRR ())
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v in
          let _v = _menhir_action_10 _1 in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState21 _tok
      | AND ->
          let _menhir_stack = MenhirCell1_AND (_menhir_stack, MenhirState21) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _1 = _v in
              let _v = _menhir_action_09 _1 in
              _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState42 _tok
          | LPAR ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState42
          | LBRA ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState42
          | IDENT _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _1 = _v in
              let _v = _menhir_action_10 _1 in
              _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState42 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_31 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
      | IDENT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_32 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
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
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState64 ->
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState60 ->
          _menhir_run_61 _menhir_stack _v _tok
      | MenhirState58 ->
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState19 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState49 ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState46 ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState21 ->
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState43 ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState42 ->
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState39 ->
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState38 ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState37 ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState34 ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState31 ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState22 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState25 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_51 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _5) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_typ (_menhir_stack, _, _3) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_FUNC (_menhir_stack, _menhir_s) = _menhir_stack in
      let _7 = _v in
      let _v = _menhir_action_07 _2 _3 _5 _7 in
      _menhir_goto_def _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_49 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState49 _tok
      | LPAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState49
      | LBRA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState49
      | IDENT _v_2 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState49 _tok
      | RPAR ->
          let _1 = _v in
          let _v = _menhir_action_17 _1 in
          _menhir_goto_exprs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_23 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRA (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23
      | _ ->
          _eRR ()
  
  and _menhir_goto_exprs : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState49 ->
          _menhir_run_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState46 ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_50 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_18 _1 _2 in
      _menhir_goto_exprs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_47 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_expr (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_11 _2 _3 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_46 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState46 _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState46
      | IDENT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState46 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_44 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
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
  
  and _menhir_run_43 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_AND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState43
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState43
      | IDENT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_40 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
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
  
  and _menhir_run_39 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState39
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState39
      | IDENT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_38 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState38 _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState38
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState38
      | IDENT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState38 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_35 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_NOT -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_NOT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_15 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_27 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LBRA, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_LBRA (_menhir_stack, _menhir_s) = _menhir_stack in
      let _4 = _v in
      let _v = _menhir_action_16 _2 _4 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_30 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_arg -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_arg (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_03 _1 _3 in
      _menhir_goto_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_24 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
      | IDENT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_cell1_LBRA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_0 in
          let _v = _menhir_action_09 _1 in
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState19
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState19
      | IDENT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v_2 in
          let _v = _menhir_action_10 _1 in
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_60 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ECHO (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NUM _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v in
          let _v = _menhir_action_09 _1 in
          _menhir_run_61 _menhir_stack _v _tok
      | LPAR ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState60
      | LBRA ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState60
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _1 = _v in
          let _v = _menhir_action_10 _1 in
          _menhir_run_61 _menhir_stack _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_62 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CONST (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NUM _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_24 () in
              _menhir_run_08_spec_63 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | BOOL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_23 () in
              _menhir_run_08_spec_63 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_08_spec_63 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_CONST _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _1 = _v in
      let _v = _menhir_action_21 _1 in
      _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState63 _tok
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_typs (_menhir_stack, _menhir_s, _v) in
      _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRA ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | FUNC ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState01
          | FUN ->
              _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState01
          | ECHO ->
              _menhir_run_60 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState01
          | CONST ->
              _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState01
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
