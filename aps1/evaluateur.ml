open Ast

type value = 
  InN of int
  |InF of expr * string list * env list
  |InFR of expr * string * string list * env list
  |InA of int 
  |InP of block * string list * ident list 
  |InPR of value 
  |None

  and env = string * value
  
(*recuperer id dans le pair(id,type)*)
let recup_iden arg =
  match arg with 
    ASTArg1(id, t) -> id
(*recuperer chaque argument dans son list*)
let rec recup_args args =
  match args with
  |ASTArgs(arg,args) -> [recup_iden arg] @ recup_args args
  |ASTArg2(arg) -> [recup_iden arg] 
  

(*si la valeur est dans l'environement*)
let rec is_in_env id env =
  match env with
  |(i,v) :: l -> if (String.equal id i) then true else is_in_env id l
  |[] -> false

(*recupere la valeur dans l'environement*)
let rec recup_env id env = 
  match env with
  |(i,v) :: l -> if (String.equal id i) then v else recup_env id l
  |[] -> failwith ("error recupere env")

(*recupere la valeur dans la memoire*)
let rec recup_mem a mem = 
  match mem with
  |(id,v) :: l -> if id == a then v else recup_mem a l
  |[] -> failwith ("error recupere env")

let rec set_mem a v mem =
  match mem with 
  |(id,e) :: l -> if id == a then (id, v) :: l else (id, e) :: set_mem a v l
  |[] -> []

(*associer les valeur et env*)
let assoc_iden_val expr env = 
  List.map2 (fun a e->(a,e)) expr env

(*recupere la valeur de int*)
let get_int v =
  match v with
  |InN(v) -> v
  |_ -> failwith "not a number"

let is_num e = 
  match e with 
  |InN(e) -> true
  |_ -> false

(*s'il est opertion unaire*)
let is_uop op = 
  match op with 
  |Not -> true
  |_ -> false

let eval_uop op e =
  match op with 
  |Not -> (if get_int e = 1 then InN(0)
          else InN(1))

(*verifier s'il est operateur algo*)
let is_op op = 
  match op with
      Eq -> true
    | Lt -> true
    | Add -> true
    | Sub -> true
    | Mul -> true
    | Div -> true

let eval_op op v1 v2 = 
  match op with
      Eq -> (if (get_int(v1) = get_int(v2)) then InN(1) else InN(0))
    | Lt -> (if (get_int(v1) < get_int(v2)) then InN(1) else InN(0))
    | Add -> InN(get_int(v1) + get_int(v2))
    | Sub -> InN(get_int(v1) - get_int(v2))
    | Mul -> InN(get_int(v1) * get_int(v2))
    | Div -> InN(get_int(v1) / get_int(v2))


let rec eval_expr expr env mem = 
  match expr with 
  |ASTBool(e) -> if (e) then InN(1) else InN(0)
  |ASTNum (e) -> InN(e)
  |ASTId(id) -> if is_in_env id env then match recup_env id env with 
                                          |InA(a) -> recup_mem a mem
                                          |v -> v
                  else failwith (id ^ "is not in environement")
  |ASTNot(op,e) -> if is_uop op then eval_uop op (eval_expr e env) else failwith ("not an unary oprator")
  |ASTOp(op,e1,e2)-> if is_op op then eval_op op (eval_expr e1 env) (eval_expr e2 env) else failwith "not a binary operator"
  |ASTAnd(a,e1,e2) -> if eval_expr e1 env = InN(1) then eval_expr e2 env else InN(0)
  |ASTOr(o,e1,e2) -> if eval_expr e1 env = InN(0) then eval_expr e2 env else InN(1)
  |ASTIf(con,e1,e2) -> if eval_expr con env = InN(1) then eval_expr e1 env else eval_expr e2 env
  |ASTExprArgs(args,e) -> InF(e, recup_args(args) ,env)
  |ASTApp(expr, exprs) -> match (eval_expr expr env) with 
                            |InF(e', clo, environement) ->
                              (*construire un nouveau environement*)
                              let new_env = (assoc_iden_val clo (verify_env exprs env)) @ environement in
                                eval_expr e' new_env
                            |InFR(e', x , clo, environement) as fr ->
                                  (*construire un nouveau environement*)
                                  let new_env = (assoc_iden_val clo (verify_env exprs env)) @ environement in
                                    eval_expr e' ((x,fr)::new_env)
                            | InN(n) -> InN(n)
(*verifier des valeurs et l'environement *)
and verify_env exprs env=
  match exprs with
    ASTExprs(e,es) -> (eval_expr e env)::(verify_env es env)
  | ASTExpr(e) -> (eval_expr e env)::[]


let eval_stat stat env output mem= 
  match stat with
    |ASTSet (id, e) -> if is_in_env id env then (match recup_env id env with 
                                                  |InA(a) -> set_mem a v mem
                                                  |_-> failwith "fail in set")
    |ASTIF
    |ASTEcho (e) -> if is_num (eval_expr e env) then eval_expr e env :: output else failwith "fail in stat"


let eval_def def env = 
  match def with
      ASTConst(id,t, e) -> (id , eval_expr e env) :: env
    | ASTFunc (id ,t ,args, e) ->(id , InF(e ,recup_args args ,env )) :: env
    | ASTFuncRec (id ,t ,args, e ) -> (id , InFR(e , id, recup_args args , env)) ::env


let rec eval_cmds cmds env output = 
  match cmds with
   ASTStat(stat) -> eval_stat stat output
   |ASTDef(def ,cmds) ->eval_cmds cmds (eval_def def env) output

let print_val v = 
  match v with
   InN(n) -> Printf.printf "%d \n "n
   | _ -> failwith "not a printable value"

let rec eval_prog prog = 
  match prog with
  ASTProg(cmds) -> print_output (eval_cmds cmds [] []) 
  and print_output output =
    List.iter (function x -> print_val x) (List.rev output) 
    
