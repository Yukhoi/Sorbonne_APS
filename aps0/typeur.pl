get_typeArgs([],[]).
get_typeArgs([(_,T)|ARGS],[T|RES]) :-
	get_typeArgs(ARGS,RES).


/*programme*/
typeProg(G, prog(X), void) :- typeCmds(G, X, void).

/*commands*/
/*stat*/
typeCmds(G, stat(X), void) :- typeStat(G, X, void).
/*def*/
typeCmds(G, [def(X)| Y], void) :- 
    typeDef(G, X, CB),
    typeCmds(CB, Y, void).


/*def*/
/*const*/
typeDef(G, const(X, T, E), [(X,T)|G]) :- typeExpr(G, E, T).
/*func*/
typeDef(G, fun(X, T, ARG, E), [(X,typeFunc(TARG, T))|G]) :- 
    append(ARG, G, G1),
    get_typeArgs(ARG,TARG),
    typeExpr(G1, E ,T).
/*func rec*/
typeDef(G, funRec(X, T, ARG, E), [(X,typeFunc(TARG, T))|G]) :-
    get_typeArgs(ARG,TARG),
    append(ARG, G, G1),
    typeExpr([(X,typeFunc(TARG, T))|G1], E ,T).

/*stat*/
typeStat(G,echo(E),void) :- typeExpr(G,E,int).

/*expr*/
typeExpr(_,true , bool).
typeExpr(_,false , bool).
/*num*/
typeExpr(G ,N, int) :- integer(N).
/*id*/
typeExpr([(X,T)|G], id(X), T).
typeExpr([_|G],id(X),T) :- typeExpr(G,id(X),T).
/*if*/
typeExpr(G,if(CON, E1, E2), T) :- 
    typeExpr(G, CON, bool),
    typeExpr(G, E1, T),
    typeExpr(G, E2, T).
/*or*/
typeExpr(G, or(E1,E2),bool) :-
    typeExpr(G , E1, bool ),
    typeExpr(G , E2, bool ).
/*and*/
typeExpr(G, and(E1,E2),bool) :-
    typeExpr(G , E1, bool ),
    typeExpr(G , E2, bool ).
/*app*/
typeExpr(G, (E, EXPRS), T) :-
    typeExpr(G, E, (ARGS_T, T)),
    typeExprList(G, EXPRS, ARGS_T).

typeExprList(G, [], []).
typeExprList(G, [E|ES], [T|TS]):-
    typeExprList(G, ES, TS),
    typeExprList(G, E, T).

/*abstraction*/
typeExpr(G, func(ARGS, E), typeFunc(TARG,T)) :-
    append(ARG, G, G1),
    get_typeArgs(ARG,TARG),
    typeExpr(G1, E ,T).

/*ehos*/
typeEchos(G, echo(E), void) :-
    typeExpr(G, E, int).
