%{
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

%}
  
%token <int> NUM
%token <string> IDENT
%token LPAR RPAR 
%token LBRA RBRA
%token COMA COLON SEMICOLON STAR ARROW
%token TRUE FALSE
%token ADD MINUS TIMES DIV
%token INT BOOL
%token OR AND NOT
%token CONST
%token ECHO IF FUN FUNC REC
%token EQUAL
%token LESS
(* aps1 *)
%token IF2 PROC CALL SET WHILE VAR



%type <Ast.expr> expr
%type <Ast.exprs> exprs
%type <Ast.cmds> cmds
%type <Ast.cmds> prog
%type <Ast.def> def
%type <Ast.typ> typ
%type <Ast.typs> typs
%type <Ast.stat> stat
%type <Ast.typeBoolInt> typeBoolInt
(* aps1 *)
%type <Ast.block> block
%type <Ast.blocks> blocks
/* APS1a */
%type <Ast.argp> argp
%type <Ast.argsp> argsp






%start prog

(* aps1 *)
%%
prog:  block    { $1 }
;

block :
  LBRA cmds RBRA { ASTBlock($2) }
;


cmds:
  stat                  { ASTStat ($1) }
| def SEMICOLON cmds    { ASTDef($1, $3) }
(* aps1 *)
| stat SEMICOLON cmds   { ASTStats ($1, $3) }
;

stat:
  ECHO expr             { ASTEcho($2) }
  (* aps1 *)
| SET IDENT expr        { ASTSet($2, $3) } 
| IF2 expr block block  { ASTIF($2, $3, $4) }
| WHILE expr block      { ASTWhile($2, $3) }
(* aps1a *)
| CALL IDENT exprsp       { ASTCall($2, $3) }
;

def:
  CONST IDENT typ  expr                   {ASTConst($2, $3, $4)}
  (* aps1 *)
| CONST IDENT typ                         { ASTVar($2, $3) }  
| FUNC IDENT typ LBRA args RBRA expr      {ASTFunc($2, $3 ,$5, $7)}
| FUN REC IDENT typ LBRA args RBRA expr   { ASTFuncRec($3, $4, $6, $8)}
(* aps1 *)
| PROC IDENT typ LBRA args RBRA block      { ASTProc($2, $3 ,$5, $7) }
| PROC REC IDENT typ LBRA args RBRA block      { ASTProcRec($3, $4, $6, $8) }

;

typeBoolInt:
  BOOL        {Int}          
| INT         {Bool}          
;

typ:
  typeBoolInt         { Type($1) }
| typs ARROW typ      { ASTTypeFunc($1, $3) }
;

typs:
  typ                  { ASTType($1) }
| typ STAR typs       {ASTTypes($1,$3)}
;

arg:
 IDENT COLON typ      {ASTArg1($1,$3)}
;

args:
  arg                   { ASTArg2($1) }
| arg COMA args         { ASTArgs($1,$3) }
;

(* aps1a *)
argp:
  IDENT COLON typ           { ASTArgP1($1, $3) }
| VALEUR IDENT COLON typ    { ArguPA($2, $4) }
;

  argsp:
  argp                      { ASTArgP2($1) }
| argp COMA argsp           { ASTArgsP($1, $3)}
;

expr:
  NUM                         { ASTNum($1) }
| IDENT                       { ASTId($1) }
| TRUE                        { ASTBool(true) }
| FALSE                       { ASTBool(false) }
| LPAR expr exprs RPAR        { ASTApp($2, $3) }
| LPAR IF expr expr expr RPAR { ASTIf($3, $4, $5) }
| LPAR AND expr expr RPAR     { ASTAnd(Ast.And, $3, $4) }
| LPAR OR expr expr RPAR      { ASTOr(Ast.Or,$3, $4) }
| LPAR NOT expr RPAR          { ASTNot(Ast.Not,$3) }
| LBRA args RBRA expr         { ASTExprArgs($2,$4) }
;

exprs :
  expr       { ASTExpr ($1) }
| expr exprs { ASTExprs($1,$2) }
;

(* aps1a *)
exprp:
  expr { ASTPr($1) }
| LPAR ADR expr RPAR { ASTCallAdr($3) }
;

exprsp:
  exprp { ASTExprp($1)}
| exprp exprsp { ASTExprsp($1, $2) }
;




