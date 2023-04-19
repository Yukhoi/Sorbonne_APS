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
%token INT BOOL VOID VEC
%token OR AND NOT 
%token CONST
%token ECHO IF FUN FUNC REC
(* aps1 *)
%token IF2 PROC CALL SET WHILE VAR
// (* aps2 *)
// %token ALLOC LEN NTH VSET 

%type <Ast.expr> expr
%type <Ast.exprs> exprs
%type <Ast.cmds> cmds
%type <Ast.prog> prog
%type <Ast.def> def
%type <Ast.typ> typ
%type <Ast.typs> typs
%type <Ast.stat> stat
%type <Ast.typeBoolInt> typeBoolInt
(* aps1 *)
%type <Ast.block> block







%start prog

(* aps1 *)
%%
prog: LBRA cmds RBRA  { ASTProg($2) }
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
// | SET IDENT expr        { ASTSet($2, $3) } 

| IF2 expr block block  { ASTIF($2, $3, $4) }
| WHILE expr block      { ASTWhile($2, $3) }
| CALL IDENT exprs       { ASTCall($2, $3) }

  (* APS2 *)
 | SET lval expr            { ASTSet($2, $3) }
;

(* APS2 *)
lval:
	IDENT                       { ASTLvId($1)}
	| LPAR expr lval expr RPAR     { ASTLval($3,$4) }
  ;

def:
  CONST IDENT typ  expr                   {ASTConst($2, $3, $4)}
  (* aps1 *)
| VAR IDENT typ                         { ASTVar($2, $3) }  
| FUNC IDENT typ LBRA args RBRA expr      {ASTFunc($2, $3 ,$5, $7)}
| FUN REC IDENT typ LBRA args RBRA expr   { ASTFuncRec($3, $4, $6, $8)}
(* aps1 *)
| PROC IDENT LBRA args RBRA block      { ASTProc($2, $4, $6) }
| PROC REC IDENT LBRA args RBRA block      { ASTProcRec($3, $5, $7) }

;

typeBoolInt:
  BOOL        {Int}          
| INT         {Bool}          
;

typeVoid:
|  VOID        {Void}

typ:
  typeBoolInt         { Type($1) }
| typeVoid            { TypeVoid($1) }
| typs ARROW typ      { ASTTypeFunc($1, $3) }
(* APS2 *)
| LPAR VEC typ RPAR         { TypeVec($3) }

;

typs:
  typ                  {ASTType($1)}
| typ STAR typs       {ASTTypes($1,$3)}
;

arg:
 IDENT COLON typ      {ASTArg1($1,$3)}
;

args:
  arg                   {ASTArg2($1)}
| arg COMA args         {ASTArgs($1,$3)}
;


expr:
  NUM                         { ASTNum($1) }
| IDENT                       { ASTId($1) }
| TRUE                        { ASTBool(true) }
 | FALSE                      { ASTBool(false) }
| LPAR expr exprs RPAR        { ASTApp($2, $3) }
| LPAR IF expr expr expr RPAR { ASTIf($3, $4, $5) }
| LPAR AND expr expr RPAR     { ASTAnd(Ast.And, $3, $4) }
| LPAR OR expr expr RPAR      {ASTOr(Ast.Or,$3, $4)}
// | LPAR NOT expr RPAR          { ASTNot(Ast.Not,$3) }
| LBRA args RBRA expr         {ASTExprArgs($2,$4)}
(* APS2 *)
// | LPAR LEN expr RPAR        { ASTLen($3) }
// | LPAR ALLOC expr RPAR      { ASTAlloc($3) }
// | LPAR NTH expr expr RPAR   { ASTNth($3,$4) }
// | LPAR VSET expr expr expr RPAR   { ASTVSet($3,$4,$5) }
;

exprs :
  expr       {ASTExpr ($1) }
| expr exprs {ASTExprs($1,$2)}
;






