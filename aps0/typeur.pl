get_typeArgs([],[]).
get_typeArgs([(_,[],T)|ARGS],[T|RES]) :-
	get_typeArgs(ARGS,RES).



/*check si la fonction est bien typee*/
assoc(X, [(X,V)], V).
assoc(X, [(X,V)|_], V).
assoc(X, [_|XS], V) :- assoc(X, XS, V).

checkArgs(_,[],[]).
checkArgs(G,[ARG|ARGS],[ARGTYPE|ARGSTYPE]) :-
	typeExpr(G,ARG,ARGTYPE),
	checkArgs(G,ARGS,ARGSTYPE).

/*env initial*/
g0([(id(add),[int,int],int),
    (id(sub),[int,int],int),
    (id(mult),[int,int],int), 
    (id(mult),[int,int],int), 
    (id(div),[int,int],int), 
    (id(eq),[int,int],bool), 
    (id(lt),[int,int],bool),
    (id(not),[bool],bool)]).

/*programme*/
typeProg(prog(X), void) :- g0(G),
    typeCmds(G, X, void).

/*command*/
/*stat*/
typeCmds(_,[],void).

typeCmds(G, [stat(X)|Y], void) :- 
    typeStat(G, X, void),
    typeCmds(G, Y, void).

/*def*/
typeCmds(G, [def(X)| Y], void) :- 
    typeDef(G, X, G1),
    typeCmds(G1, Y, void).


/*def*/
/*const*/
typeDef(G, const(X, T, E), [(id(X),[],T)|G]) :- 
    typeExpr([(id(X),[],T)|G], E, T).
/*func*/
typeDef(G, fun(X, T, ARG, E),G2) :- 
    append([(id(X),TARG, T)],G,G2),
    append(ARG, G, G1),
    get_typeArgs(ARG,TARG),
    typeExpr(G1, E ,T).
/*func rec*/
typeDef(G, funRec(X, T, ARG, E), G2) :-
    get_typeArgs(ARG,TARG),
    append([(id(X),TARG, T)], G, G2),
    append(ARG, G2, G1),
    typeExpr(G1, E ,T).

/*stat*/
typeStat(G,echo(E),void) :- typeExpr(G,E,int).

/*expr*/
typeExpr(_,true , bool).
typeExpr(_,false , bool).
/*num*/
typeExpr(_ ,N, int) :- integer(N).
/*id*/
typeExpr([(id(X),[],T)], id(X), T).
typeExpr([(id(X),[],T)|_], id(X), T).
typeExpr([_|G],id(X),T) :- typeExpr(G,id(X),T).
/*if*/
typeExpr(G,if(CON, E1, E2), T) :- 
    typeExpr(G, CON, bool),
    typeExpr(G, E1, T),
    typeExpr(G, E2, T).
/*or*/
typeExpr(G, or(E1,E2),bool) :-
    typeExpr(G , E1, bool),
    typeExpr(G , E2, bool).
/*and*/
typeExpr(G, and(E1,E2),bool) :-
    typeExpr(G , E1, bool ),
    typeExpr(G , E2, bool ).
/*app*/
/*typeExpr(G, app(E, EXPRS), T) :-
    typeExpr(G, E, (ARGS_T, T)),
    typeExprList(G, EXPRS, ARGS_T).

typeExprList(G, [], []).
typeExprList(G, [E|ES], [T|TS]):-
    typeExprList(G, ES, TS),
    typeExprList(G, E, T).*/

typeExpr(G,app(id(F),ARGS),TF) :-
	assoc(id(F),G,(ARGSTYPE,TF)),
	checkArgs(G,ARGS,ARGSTYPE).
		
typeExpr(G,app(fun(ARGSTYPE,BODY),ARGS),TF) :-
	get_typeArgs(ARGSTYPE,RES),
	checkArgs(G,ARGS,RES),
	append(ARGSTYPE,G,CB),
	typeExpr(CB,BODY,TF).
	
typeExpr(G,app(app(X,Y),ARGS),TR) :-
	get_type(ARGS,LT),
	typeExpr(G,app(X,Y),(LT,TR)).


/*abstraction*/
typeExpr(G, abs(ARGS, E), (TARG,T)) :-
    append(ARGS, G, G1),
    get_typeArgs(ARGS,TARG),
    typeExpr(G1, E ,T).
