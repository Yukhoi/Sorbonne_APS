open Ast

type value = 
  InN of int
  |InF of expr * string list * env list
  |InFR of expr * string * string list * env list

  and env = string * value
  
(*recuperer id dans le pair(id,type)*)
let recup_iden arg =
  match arg with 
    ASTArg1(id, _) -> id
(*recuperer chaque argument dans son list*)
let rec recup_args args =
  match args with
  |ASTArgs(arg,args) -> [recup_iden arg] @ recup_args args
  |ASTArg2(arg) -> [recup_iden arg] 
  

(*si la valeur est dans l'environement*)
let rec is_in_env id env =
  match env with
  |(i,_) :: l -> if (String.equal id i) then true else is_in_env id l
  |[] -> false

(*recupere la valeur dans l'environement*)
let rec recup_env id env = 
  match env with
  |(i,v) :: l -> if (String.equal id i) then v else recup_env id l
  |[] -> failwith ("error recupere env")

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
  |InN(_) -> true
  |_ -> false

(*s'il est opertion unaire*)
let is_uop op = 
  match op with 
  |Not -> true
    (* Catch-all case for potential future unary operators *)

let eval_uop op e =
  match op with 
  |Not -> (if get_int e = 1 then InN(0)
          else InN(1))


let eval_opperateur op vs = 
  match vs with
  |[v1 ; v2] ->
    (match op with
        "eq" -> (if (get_int(v1) = get_int(v2)) then InN(1) else InN(0))
      | "lt" -> (if (get_int(v1) < get_int(v2)) then InN(1) else InN(0))
      | "add" -> InN(get_int(v1) + get_int(v2))
      | "sub" -> InN(get_int(v1) - get_int(v2))
      | "mult" -> InN(get_int(v1) * get_int(v2))
      | "div" -> InN(get_int(v1) / get_int(v2))
      |_ -> assert false)
  | [v] -> 
    (  match op,v with
      |"not",InN(n) -> InN(if n=0 then 1 else 0)
      |_-> assert false)
  |_ -> assert false
  

let call e vs = 
  match e with
  |ASTId(op) -> eval_opperateur op vs
  |_ -> assert false

let is_operateur e =
  match e with 
  |ASTId("add" | "sub" | "mult" | "div" | "eq" | "lt") -> true
  |_ -> false

let rec eval_expr expr env = 
  match expr with 
  |ASTBool(e) -> if (e) then InN(1) else InN(0)
  |ASTNum (e) -> InN(e)
  |ASTId(id) -> if is_in_env id env then recup_env id env else failwith (id ^ " is not in environement")
  |ASTAnd(_,e1,e2) -> if eval_expr e1 env = InN(1) then eval_expr e2 env else InN(0)
  |ASTOr(_,e1,e2) -> if eval_expr e1 env = InN(0) then eval_expr e2 env else InN(1)
  |ASTIf(con,e1,e2) -> if eval_expr con env = InN(1) then eval_expr e1 env else eval_expr e2 env
  |ASTExprArgs(args,e) -> InF(e, recup_args(args) ,env)
  |ASTApp(expr, exprs) -> let vs = (verify_env exprs env) in
                          if is_operateur expr then call expr vs else 
                            match (eval_expr expr env) with 
                                |InF(e', clo, environement) ->
                                  (*construire un nouveau environement*)
                                  let new_env = (assoc_iden_val clo vs) @ environement in
                                    eval_expr e' new_env
                                |InFR(e', x , clo, environement) as fr ->
                                      (*construire un nouveau environement*)
                                      let new_env = (assoc_iden_val clo vs) @ environement in
                                        eval_expr e' ((x,fr)::new_env)
                                | InN(n) -> InN(n)
(*verifier des valeurs et l'environement *)
and verify_env exprs env =
  match exprs with
    ASTExprs(e,es) -> (eval_expr e env)::(verify_env es env)
  | ASTExpr(e) -> (eval_expr e env)::[]


let eval_stat stat env output = 
  match stat with
    |ASTEcho (e) -> if is_num (eval_expr e env) then eval_expr e env :: output else failwith "fail in stat"


let eval_def def env = 
  match def with
      ASTConst(id, _, e) -> (id , eval_expr e env) :: env
    | ASTFunc (id ,_ ,args, e) ->(id , InF(e ,recup_args args ,env )) :: env
    | ASTFuncRec (id ,_ ,args, e ) -> (id , InFR(e , id, recup_args args , env)) ::env

let rec eval_cmds cmd env output = 
  match cmd with
   |ASTStat(stat) -> eval_stat stat env output
   |ASTDef(def ,cmds) -> eval_cmds cmds (eval_def def env) output

let print_val v = 
  match v with
   InN(n) -> Printf.printf "%d \n "n
   | _ -> failwith "not a printable value"

let eval_prog prog = 
  let print_output output =
    List.iter (function x -> print_val x) (List.rev output) in
  print_output (eval_cmds prog [] []) 
  
