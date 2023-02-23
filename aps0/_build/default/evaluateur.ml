open Ast

type value = 
  InN of int
  |InF of expr * string list * env list

  and env = string * value

let recup_iden arg =
  match arg with 
    ASTArg1(id, t) -> id

let recup_args args =
  match args with
  |ASTArgs(arg,args) -> recup_iden arg @ recup_args args
  |ASTArg2(arg) -> recup_iden arg 
  

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

(*recupere la valeur de int*)
let get_int v =
  match v with
  |InN(v) -> valeur
  |_ -> failwith "not a number"

(*s'il est opertion unaire*)
let is_uop op = 
  match op with 
  |Not -> true
  |_ -> false

let eval_uop op e =
  match op with 
  |Not -> (if get_int e = 1 then 0
          else 1)
  |_ -> failwith "not a Not"

(*verifier s'il est operateur algo*)
let is_op op = 
  match op with
      Eq -> true
    | Lt -> true
    | Add -> true
    | Sub -> true
    | Mul -> true
    | Div -> true

let eval_op op e1 e2 = 
  match op with
      Eq -> (if (get_int(e1) = get_int(e2)) then 1 else 0)
    | Lt -> (if (get_int(e1) < get_int(e2)) then 1 else 0)
    | Add -> get_int(e1) + get_int(e2)
    | Sub -> get_int(e1) - get_int(e2)
    | Mul -> get_int(e1) * get_int(e2)
    | Div -> get_int(e1) / get_int(e2)


let rec eval_expr expr env = 
  match expr with 
  |ASTBool(e) -> if (e) then InN(1) else InN(0)
  |ASTNum (e) -> InN(e)
  |ASTId(id) -> if is_in_env id env then recup_env id env else failwith (id ^ "is not in environement")
  |ASTNot(op,e) -> if is_uop op then eval_uop op (eval_expr e env) else failwith ("not an unary oprator")
  |ASTNot(x,e1,e2)-> if is_op op then eval_op op (eval_expr e1 env) (eval_expr e2 env) else failwith "not a binary operator"
  |ASTAnd(a,e1,e2) -> if eval_expr e1 env = InN(1) then eval_expr e2 env else InN(0)
  |ASTOr(o,e1,e2) -> if eval_expr e1 env = InN(0) then eval_expr e2 env else InN(1)
  |ASTIf(i,con,e1,e2) -> if eval_expr con env = InN(1) then eval_expr e1 env else eval_expr env e2 env
  |ASTExprArgs(args,e) -> InF(e, recup_args(args) ,env)

let eval_stat stat env output = 
  match stat with
    |ASTEcho (e) -> if InN(e) then eval_expr e env :: output


let eval_def def env = 
  match def with
      ASTConst(id,e,t) -> if eval_expr e env then (id , eval_expr e env)
    | ASTFunc (id ,t ,args, e) ->(id)
    