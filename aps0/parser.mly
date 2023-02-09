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
%token TRUE FALSE
%token EQUAL
%token LESS



%type <Ast.expr> expr
%type <Ast.exprs> exprs
%type <Ast.cmds> cmds
%type <Ast.cmds> prog
%type <Ast.def> def
%type <Ast.typ> typ
%type <Ast.typs> typs




%start prog

%%
prog: LBRA cmds RBRA    { $2 }
;

cmds:
  stat                  { [ASTStat $1] }
| def SEMICOLON cmds    {ASTDef($1, $3)}
;

stat:
  ECHO expr             { ASTEcho($2) }
;

def:
  CONST IDENT typ  expr   {ASTConst($2, $3, $4)}
| FUNC IDENT typ LBRA args RBRA expr {ASTFunc($2, $3 ,$5, $7)}
| FUN REC IDENT typ LBRA args RBRA expr {ASTFuncRec($3, $4 $6, $8)}
;

typ:
  BOOL                  {BOOL}
| INT                   {INT}
| typs ARROW typ      {ASTTypeFunc($1, $3)}
;

typs:
  typ                  {ASTType($1)}
| typ STAR typs       {ASTTypes($1,$3)}
;
arg:
 IDENT COLON typs      {ASTArg1($1,$3)}
;

args:
  arg                   {ASTArg2($1)}
| arg COMA args         {ASTArgs(1,3)}
;

stat:
  ECHO expr             {ASTEcho(1)}
;

expr:
  NUM                   { ASTNum($1) }
| IDENT                 { ASTId($1) }
| LPAR expr exprs RPAR  { ASTApp($2, $3) }
| LPAR IF expr expr expr RPAR {ASTIf($3, $4, $5)}
| LPAR AND expr expr RPAR {ASTAnd($3, $4)}
| LPAR OR expr expr RPAR {ASTOR($3, $4)}
| LBRA args RBRA expr     {ASTExprArgs($2,$4)}

;

exprs :
  expr       {ASTExpr ($1) }
| expr exprs {ASTExprs($1::$2)}
;


