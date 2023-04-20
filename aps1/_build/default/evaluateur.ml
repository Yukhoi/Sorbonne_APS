open Ast

type value = 
  InN of int
  |InF of expr * string list * env list
  |InFR of expr * string * string list * env list
  |InA of int 
  |InP of block * string list * env list 
  |InPR of block * string * string list * env list 
  |None

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
  |[] -> failwith ("error recupere env for " ^ id)

(*recupere la valeur dans la memoire*)
let rec recup_mem a mem = 
  match mem with
  |(id,v) :: l -> if id == a then v else recup_mem a l
  |[] -> failwith ("error recupere mem")

let rec set_mem a v mem =
  match mem with 
  |(id,e) :: l -> if id == a then (id, v) :: l else (id, e) :: set_mem a v l
  |[] -> failwith ("error in set, not found in mem")

(*associer les valeur et env*)
let assoc_iden_val expr env = 
  List.map2 (fun a e->(a,e)) expr env

(*recupere la valeur de int*)
let get_int v =
  match v with
  |InN(v) -> v
  |_ -> failwith ("not a number")

let is_num e = 
  match e with 
  |InN(_) -> true
  |_ -> false

(*s'il est opertion unaire*)
let is_uop op = 
  match op with 
  |Not -> true

let eval_uop op e =
  match op with 
  |Not -> (if get_int e = 1 then InN(0)
          else InN(1))

let is_operateur e =
  match e with 
  |ASTId("add" | "sub" | "mult" | "div" | "eq" | "lt" | "not") -> true
  |_ -> false
          
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


let is_op e =
  match e with
  ("add" | "sub" | "mult" | "div" | "eq" | "lt" | "not") -> true
  |_ -> false

let rec eval_expr expr env mem = 
  match expr with 
  |ASTBool(e) -> if (e) then InN(1) else InN(0)
  |ASTNum (e) -> InN(e)
  |ASTId(id) -> if is_in_env id env then match recup_env id env with 
                                          |InA(a) -> recup_mem a mem
                                          |v -> v
                  else failwith (id ^ " is not in environement")
  |ASTAnd(_,e1,e2) -> if eval_expr e1 env mem = InN(1) then eval_expr e2 env mem else InN(0)
  |ASTOr(_,e1,e2) -> if eval_expr e1 env mem = InN(0) then eval_expr e2 env mem else InN(1)
  |ASTIf(con,e1,e2) -> if eval_expr con env mem = InN(1) then eval_expr e1 env mem else eval_expr e2 env mem
  |ASTExprArgs(args,e) -> InF(e, recup_args(args) ,env)
  |ASTApp(expr, exprs) -> let vs = (verify_env exprs env mem) in
                            if is_operateur expr then call expr vs else 
                              match (eval_expr expr env mem) with 
                                  |InF(e', clo, environement) ->
                                    (*construire un nouveau environement*)
                                    let new_env = (assoc_iden_val clo vs) @ environement in
                                      eval_expr e' new_env mem
                                  |InFR(e', x , clo, environement) as fr ->
                                        (*construire un nouveau environement*)
                                        let new_env = (assoc_iden_val clo vs) @ environement in
                                          eval_expr e' ((x,fr)::new_env) mem
                                  | InN(n) -> InN(n)
                                  | _ -> failwith "error in app"
(*verifier des valeurs et l'environement *)
and verify_env exprs env mem=
  match exprs with
    ASTExprs(e,es) -> (eval_expr e env mem)::(verify_env es env mem)
  | ASTExpr(e) -> (eval_expr e env mem)::[]


let rec eval_expr_for_call expr env mem = 
  match expr with 
  |ASTBool(e) -> if (e) then InN(1) else InN(0)
  |ASTNum (e) -> InN(e)
  |ASTId(id) -> if is_in_env id env then recup_env id env 
                  else failwith (id ^ "is not in environement")
  |ASTAnd(_,e1,e2) -> if eval_expr e1 env mem = InN(1) then eval_expr e2 env mem else InN(0)
  |ASTOr(_,e1,e2) -> if eval_expr e1 env mem = InN(0) then eval_expr e2 env mem else InN(1)
  |ASTIf(con,e1,e2) -> if eval_expr con env mem = InN(1) then eval_expr e1 env mem else eval_expr e2 env mem
  |ASTExprArgs(args,e) -> InF(e, recup_args(args) ,env)
  |ASTApp(expr, exprs) -> let vs = (verify_env exprs env mem) in
                            if is_operateur expr then call expr vs else 
                              match (eval_expr expr env mem) with 
                                  |InF(e', clo, environement) ->
                                    (*construire un nouveau environement*)
                                    let new_env = (assoc_iden_val clo vs) @ environement in
                                      eval_expr e' new_env mem
                                  |InFR(e', x , clo, environement) as fr ->
                                        (*construire un nouveau environement*)
                                        let new_env = (assoc_iden_val clo vs) @ environement in
                                          eval_expr e' ((x,fr)::new_env) mem
                                  | InN(n) -> InN(n)
                                  | _ -> failwith "error in app"
(*verifier des valeurs et l'environement *)
and verify_env_for_call exprs env mem=
  match exprs with
    ASTExprs(e,es) -> (eval_expr_for_call e env mem)::(verify_env_for_call es env mem)
  | ASTExpr(e) -> (eval_expr_for_call e env mem)::[]

let rec eval_stat stat env output mem= 
  match stat with
    |ASTEcho(e) -> if is_num (eval_expr e env mem) then (mem, (eval_expr e env mem:: output) ) else failwith "fail in echo"
    |ASTSet (id, e) -> (if (is_in_env id env) then (match recup_env id env with 
                                                  |InA(a) -> (set_mem a (eval_expr e env mem) mem, output)
                                                  |_-> failwith ("pb in set,content of "^ id ^" is not a adress" ))
                        else failwith "fail in set")
    |ASTIF (e,bk1,bk2) -> (if eval_expr e env mem == InN(1) then eval_block bk1 env output mem
                          else eval_block bk2 env output mem)
    |ASTWhile (e,bk) ->(if eval_expr e env mem == InN(1) then (let (mem',output') = eval_block bk env output mem in
                                                                eval_stat stat env output' mem')
                          else (mem,output))                
    |ASTCall(id, args) -> let vs = (verify_env_for_call args env mem) in
                            if is_op id then (mem,(eval_opperateur id (verify_env args env mem))::output) else
                              (match recup_env id env with
                                |InP(bk', argus ,env_proc) ->  
                                  (*construire un noveau env*)
                                  (let new_env = (assoc_iden_val argus vs) @ env_proc in
                                    eval_block bk' new_env output mem)
                                |InPR(bk', x, argus ,env_proc) as pr -> 
                                  (*construire un nouveau env*)
                                  (let new_env = (assoc_iden_val argus vs) @ env_proc in
                                    eval_block bk' ((x, pr)::new_env) output mem)
                                |_ -> failwith "error in calling functions")


and eval_def def env mem= 
  match def with
      ASTConst(id,_,e) -> ((id , eval_expr e env mem) :: env,mem) 
    | ASTVar(id, _) -> ((id , InA(List.length mem)) :: env, (mem @ [(List.length mem), InN(-1)])) (*a verifier*)
    | ASTProc(id, args, bk) -> ((id, InP(bk ,recup_args args ,env)) :: env, mem)
    | ASTProcRec(id, args, bk) -> ((id , InPR(bk , id, recup_args args , env)) :: env, mem)
    | ASTFunc (id ,_,args, e) ->((id , InF(e ,recup_args args ,env )) :: env, mem)
    | ASTFuncRec (id ,_ ,args, e ) -> ((id , InFR(e , id, recup_args args , env)) ::env, mem)


and eval_cmds cs env output mem = 
  match cs with
   ASTStat(stat) -> eval_stat stat env output mem
  |ASTDef(def ,cmds) -> (let (env', mem') = eval_def def env mem in
                            eval_cmds cmds env' output mem')
  | ASTStats(s, cmds) -> (let (mem', output') = eval_stat s env output mem in
                            eval_cmds cmds env output' mem')

and eval_block cs env output mem =
  match cs with
  |ASTBlock(cs) -> eval_cmds cs env output mem

let print_val v = 
  match v with
   InN(n) -> Printf.printf "%d \n "n
   | _ -> failwith "not a printable value"



let rec eval_prog prog = 
  match prog with
  |ASTProg(cmds) -> let (_, new_output) = eval_cmds cmds [] [] [] in
                      print_output new_output
  and print_output output =
    List.iter (function x -> print_val x) (List.rev output) 
    
