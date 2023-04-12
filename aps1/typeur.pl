/*fonctions auxillieres*/
get_typeArgs([],[]).
get_typeArgs([(_,T)|ARGS],[T|RES]) :-
	get_typeArgs(ARGS,RES).

assoc(X, [(X,V)|_], V).
assoc(X, [_|XS], V) :- assoc(X, XS, V).
		
checkArgs(_,[],[]).
checkArgs(G,[ARG|ARGS],[ARGTYPE|ARGSTYPE]) :-
	typeExpr(G,ARG,ARGTYPE),
	checkArgs(G,ARGS,ARGSTYPE).

inEnv([(X,T)|G], X, T).
inEnv([_|G], X, T) :- inEnv(G, X, T).

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
typeProg(G, prog(X), void) :- typeBlock(G, X, void).

/*block*/
typeBlock(G, block(X), void) :- typeCmds(G, X, void).

/*command*/
/*stat*/
typeCmds(G, stat(X), void) :- typeStat(G, X, void).
/*def*/
typeCmds(G, [def(X)| Y], void) :- 
    typeDef(G, X, CB),
    typeCmds(CB, Y, void).
/*stats*/
typeCmds(G, stats(X)|Y, void) :- 
    typeStat(G, X, void),
    typeCmds(CB, Y, void).


/*def*/
/*const*/
typeDef(G, const(X, T, E), [(X,T)|G]) :- 
    append((X,T),G,G1),
    typeExpr(G1, E, T).
/*var*/
typeVar(G, var(X, T), [(X,T)|G]).     
/*func*/
typeDef(G, fun(X, T, ARG, E), [(X,(TARG, T))|G]) :- 
    append(ARG, G, G1),
    get_typeArgs(ARG,TARG),
    typeExpr(G1, E ,T).
/*func rec*/
typeDef(G, funRec(X, T, ARG, E), [(X,(TARG, T))|G]) :-
    get_typeArgs(ARG,TARG),
    append(ARG, G, G1),
    typeExpr([(X,typeFunc(TARG, T))|G1], E ,T).
/*proc*/
typeDef(G, proc(X, ARGS, B), [(X,(TARG, void))|G]) :-
    get_typeArgs(ARG,TARG),
    append(ARG, G, G1),
    typeBlock(G1, B, void).
/*proc rec*/
typeDef(G, proc(X, ARGS, B), [(X,(TARG, void))|G]) :-
    get_typeArgs(ARG,TARG),
    append(ARG, G, G1),
    typeBlock([(X,typeProc(TARG, T))|G1], B, void).


/*stat*/
/*echo*/
typeStat(G,echo(E),void) :- typeExpr(G,E,int).
/*set*/
typeStat(G,set(E, T),void) :- 
    inEnv(G, E, T),
    typeExpr(G, E, T).
/*IF*/
typeStat(G,iF(CON, BK1, BK2), void) :- 
    typeExpr(G, CON, bool),
    typeBlock(G, BK1, void),
    typeBlock(G, BK2, void).
/*while*/
typeStat(G, wHile(CON, BK1), void) :-
    typeExpr(G, CON, bool),
    typeBlock(G, BK1, void).
/*call*/
typeStat(G, call(X, ARGS), void) :-
    inEnv(X, (TARGS,void)),
    get_typeArgs(ARGS,RES),
    checkArgs(G, ARGS, RES).



/*expr*/
typeExpr(_,true , bool).
typeExpr(_,false , bool).
/*num*/
typeExpr(G ,N, int) :- integer(N).
/*id*/
typeExpr(G, id(X), T) :- inEnv(G, X, T)
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
typeExpr(G,app(id(F),ARGS),TF) :-
	assoc(F,G,(ARGSTYPE,TF)),
	checkArgs(G,ARGS,ARGSTYPE).
		
typeExpr(G,app(func(ARGSTYPE,BODY),ARGS),TF) :-
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

