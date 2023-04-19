/*fonctions auxillieres*/
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

checkArgsCall(_,[],[]).
checkArgsCall(G,[ARG|ARGS],[ARGTYPE|ARGSTYPE]) :-
	typeExprp(G,ARG,ARGTYPE),
	checkArgsCall(G,ARGS,ARGSTYPE).


inEnv(G, X, TARGS) :- member((_,_,ref(ref(_))),G), false.
inEnv([(X,TARGS,T)|G], X, TARGS).
inEnv([_|G], X, TARGS) :- 
    inEnv(G, X, TARGS).

/*env initial*/
g0([(id(add),[int,int],int),
    (id(sub),[int,int],int),
    (id(mult),[int,int],int), 
    (id(mult),[int,int],int), 
    (id(div),[int,int],int), 
    (id(eq),[int,int],bool), 
    (id(lt),[int,int],bool),
    (id(not),[bool],bool)]).

/*block*/
typeBlock(G, block(X), void) :- typeCmds(G, X, void).

/*programme*/
typeProg(prog(X), void) :- g0(G),
    typeCmds(G, X, void).

/*command*/
/*stat*/
typeCmds(_,[],void).
typeCmds(G, [stat(X)], void) :- typeStat(G, X, void).
/*def*/
typeCmds(G, [def(X)| Y], void) :- 
    typeDef(G, X, CB),
    typeCmds(CB, Y, void).
/*stats*/
typeCmds(G, [stat(X)|Y], void) :- 
    typeStat(G, X, void),
    typeCmds(G, Y, void).


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
/* aps1 */
/*proc*/
typeDef(G, proc(X, ARGS, B), G2) :-
    append([(id(X),TARG, void)],G,G2),
    get_typeArgs(ARG,TARG),
    append(ARG, G, G1),
    typeBlock(G1, B, void).
/*proc rec*/
typeDef(G, procRec(X, ARGS, B), G2) :-
    get_typeArgs(ARG,TARG),
    append([(id(X),TARG, void)], G, G2),
    append(ARG, G2, G1),
    typeBlock(G1, B, void).
/* aps1a */
/*var*/
typeDef(G, var(X, T), [(id(X),[],ref(T))|G]).


/*stat*/
/*echo*/
typeStat(G,echo(E),void) :- typeExpr(G,E,int).
/* aps1 */
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
    inEnv(G, X, ARGSTYPE),
	checkArgsCall(G, ARGS, ARGSTYPE).
/* (aps1a) set*/
typeStat(G,set(X, E),void) :- 
    get_typeArgs([id(X)],T),
    T\=ref(_),
    fail.
typeStat(G,set(X, E),void) :- 
    typeExpr(G, X, ref(T)),
    typeExpr(G, E, T).




/*expr*/
typeExpr(_,_,ref(ref(_))) :-  fail.
typeExpr(_,true , bool).
typeExpr(_,false , bool).
/*num*/
typeExpr(G ,N, int) :- integer(N).
/*id normal*/
typeExpr([(id(X),[],T)], id(X), T).
typeExpr([(id(X),[],T)|_], id(X), T).
/*(aps1a) id ref*/
typeExpr([(id(X),[],ref(T))], id(X), T).
typeExpr([(id(X),[],ref(T))|_], id(X), T).
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

/* (aps1a) appel*/
typeExprp(G,X,T) :-
	typeExpr(G,X,T).
typeExprp(G,adr(X), T) :-
	typeExpr(G,X,T).
