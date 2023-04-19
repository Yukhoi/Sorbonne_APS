  open Ast

  type value = 
  InN of int
  |InF of expr * string list * env list
  |InFR of expr * string * string list * env list
    (* aps 1 *)
  |InA of int 
  |InP of block * string list * env list 
  |InPR of block * string * string list * env list 
  |None
  |Any
    (* aps 2 *)
  |InB of int * int

  and env = string * value
  
let newAddress mem = (
  let rec aux m a =
    match m with
      [] -> InA (a+1)
      |(k,_)::t when k > a -> aux t k
      |(k,_)::t  -> aux t a
  in aux mem 0)

let alloc_block mem n = 
  let adr = newAddress mem  in
    match adr with
      InA a -> (adr, mem@[(a,Any)])
      |_ -> failwith "Error in allocation"



  
(*recuperer id dans le pair(id,type)*)
let recup_iden arg =
  match arg with 
    ASTArg1(id, _) -> id


(*recuperer chaque argument dans son list*)
let rec recup_args args =
  match args with
  |ASTArgs(arg,args) -> [recup_iden arg] @ recup_args args
  |ASTArg2(arg) -> [recup_iden arg] 

(* string  *)
let is_op e = 
    match e with
      ("add" | "sub" | "mult" | "div" | "eq" | "lt"| "not") -> true
      |_ -> false

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
  |_ -> failwith "not a number"

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

  (* expr  *)
let is_operateur e =
  match e with 
  |ASTId("add" | "sub" | "mult" | "div" | "eq" | "lt"|"alloc"|"len"|"nth"|"vset"| "not") -> true
  |_ -> false

let call e vs = 
match e with
ASTId(op) -> eval_opperateur op vs
|_ -> assert false

let rec eval_expr expr env mem = 
  match expr with 
  |ASTBool(e) -> if (e) then (InN(1),mem) else (InN(0),mem)
  |ASTNum (e) -> (InN(e),mem)
  (* aps 2 *)
  |ASTId(id) -> (match recup_env id env with
                  InA(a) -> (recup_mem a mem ,mem)
                  | v -> (v,mem))
  |ASTAnd(_,e1,e2) -> if eval_expr e1 env mem = (InN(1),mem) then eval_expr e2 env mem else (InN(0),mem)
  |ASTOr(_,e1,e2) -> if eval_expr e1 env mem = (InN(0),mem) then eval_expr e2 env mem else (InN(1),mem)
  |ASTIf(con,e1,e2) -> if eval_expr con env mem = (InN(1),mem) then eval_expr e1 env mem else eval_expr e2 env mem
  |ASTExprArgs(args,e) -> (InF(e, recup_args(args) ,env),mem)
  |ASTApp(expr, exprs) -> let vs = (verify_env exprs env mem) in
                            if is_operateur expr then call expr vs else 
                              let (c , mem') = (eval_expr expr env mem) in
                              match c with 
                                  |InF(e', clo, environement) ->
                                    (*construire un nouveau environement*)
                                    let new_env = (assoc_iden_val clo vs) @ environement in
                                      eval_expr e' new_env mem
                                  |InFR(e', x , clo, environement) as fr ->
                                        (*construire un nouveau environement*)
                                        let new_env = (assoc_iden_val clo vs) @ environement in
                                          eval_expr e' ((x,fr)::new_env) mem
                                  (* | InN(n) -> InN(n) *)
                                  | _ -> failwith "error in app"
(*verifier des valeurs et l'environement *)
and verify_env exprs env mem=
  match exprs with
    ASTExprs(e,es) -> let (c , mem') = (eval_expr expr env mem) in
      c ::(verify_env es env mem)
  | ASTExpr(e) -> let (c , mem') = (eval_expr expr env mem) in
      c::[]        

and eval_opperateur op vs env mem = 
  match vs with
  |[val1 ; val2] ->
    (match op with
        "eq" -> let (val1',mem') = eval_expr val1 env mem in let (val2',mem') = eval_expr val2 env mem' in
                (match (get_int val1') == (get_int val2') with
                  true -> (InN(1),mem')
                  |false -> (InN(0),mem')
                )
      | "lt" -> (if (get_int(val1) < get_int(val2)) then InN(1) else InN(0))
      | "add" -> InN(get_int(val1) + get_int(val2))
      | "sub" -> InN(get_int(val1) - get_int(val2))
      | "mult" -> InN(get_int(val1) * get_int(val2))
      | "div" -> InN(get_int(val1) / get_int(val2))
      | "nth" -> let val1' = eval_expr val1 env mem in
                  let val2' = eval_expr val2 env mem' in
                  (match val1', val2' with
                  ((InB(a , n)) ,(InN(i)) )->(recup_mem (a+i) mem', mem'')
                |_ -> failwith "Error in NTH, not in memory")
      |_ -> assert false)
  | [v] -> 
    (  match op,v with
      |"not",InN(n) -> InN(if n=0 then 1 else 0)
      |"alloc",v -> (match eval_expr (v env mem) with
                      (InN(n), mem') -> let (a , mem'')= alloc_block mem' n in 
                                        InB((a,n),mem'')
                                        |_ ->failwith "Error in ALLOC") 
      |"len" , v -> (match eval_expr (v env mem) with
                      InB((a ,n),mem') -> (InN(n),mem')
                      |_ -> failwith "Error in LEN")
      |_-> assert false)
  |[val1 ; val2 ; v3]->
    (
      match op with
        "vset" -> let(val1', mem') = eval_expr val1 env mem     in 
                  let(val2',mem'')  = eval_expr val2 env mem in
                  let(v3',mem''')  = eval_expr v3 env mem in
                  ( match val1',val2',v3' with
                  (InB(a , n), InN(i) , v) -> let mem3 = (set_mem (a+i) v mem''' ) in ((InB(a , n)),mem3)
                  |_ -> failwith "Error in VSET ")
    )
  |_ -> assert false


  
  
and eval_expr_for_call expr env mem = 
  match expr with 
  |ASTBool(e) -> if (e) then InN(1) else InN(0)
  |ASTNum (e) -> InN(e)
  |ASTId(id) -> if is_in_env id env then recup_env id env 
                  else failwith (id ^ "is not in environement")
  |ASTAnd(_,e1,e2) -> if eval_expr e1 env mem = InN(1) then eval_expr e2 env mem else InN(0)
  |ASTOr(_,e1,e2) -> if eval_expr e1 env mem = InN(0) then eval_expr e2 env mem else InN(1)
  |ASTIf(con,e1,e2) -> if eval_expr con env mem = InN(1) then eval_expr e1 env mem else eval_expr e2 env mem
  |ASTExprArgs(args,e) -> InF(e, recup_args(args) ,env)
  |ASTApp(expr, exprs) -> (let vs = (verify_env exprs env mem) in
                            if is_operateur expr then call expr vs else 
                              (match (eval_expr expr env mem) with 
                                  |InF(e', clo, environement) ->
                                    (*construire un nouveau environement*)
                                    let new_env = (assoc_iden_val clo vs) @ environement in
                                      eval_expr e' new_env mem
                                  |InFR(e', x , clo, environement) as fr ->
                                        (*construire un nouveau environement*)
                                        let new_env = (assoc_iden_val clo vs) @ environement in
                                          eval_expr e' ((x,fr)::new_env) mem
                                  | InN(n) -> InN(n)
                                  | _ -> (failwith "error in app")))
(*verifier des valeurs et l'environement *)
and verify_env_for_call exprs env mem=
  match exprs with
    ASTExprs(e,es) -> (eval_expr_for_call e env mem)::(verify_env_for_call es env mem)
  | ASTExpr(e) -> (eval_expr_for_call e env mem)::[]

                                
and eval_stat stat env output mem= 
  match stat with
    |ASTEcho(e) -> if is_num (eval_expr e env mem) then (mem, (eval_expr e env mem:: output) ) else failwith "fail in echo"
    (* aps 2 *)
    |ASTSet (id, e) -> ( let a = eval_lvalue id env mem and (v,mem') = eval_expr e env mem in 
                          match a with
                              adr -> let mem' = set_mem adr v mem' in (mem',flux)
                        )
    (* |ASTSet (id, e) -> (if (is_in_env id env) then (match recup_env id env with 
                                                  |InA(a) -> (set_mem a (eval_expr e env mem) mem, output)
                                                  |_-> failwith ("pb in set,content of "^ id ^" is not a adress" ))
                        else failwith "fail in set") *)
    |ASTIF (e,bk1,bk2) -> (if eval_expr e env mem == InN(1) then eval_block bk1 env output mem
                          else eval_block bk2 env output mem)
    |ASTWhile (e,bk) ->(if eval_expr e env mem == InN(1) then (let (mem',output') = eval_block bk env output mem in
                                                                eval_stat stat env output' mem')
                          else (mem,output))                
    |ASTCall(id, args) -> let vs = (verify_env_for_call args env mem) in
                            (if is_op id then (mem,(eval_opperateur id vs)::output) else
                              (match recup_env id env with
                                |InP(bk', argus ,env_proc) ->  
                                  (*construire un noveau env*)
                                  (let new_env = (assoc_iden_val argus vs) @ env_proc in
                                    eval_block bk' new_env output mem)
                                |InPR(bk', x, argus ,env_proc) as pr -> 
                                  (*construire un nouveau env*)
                                  (let new_env = (assoc_iden_val argus vs) @ env_proc in
                                    eval_block bk' ((x, pr)::new_env) output mem)
                                |_ -> failwith "error in calling functions"))


and eval_def def env mem= 
  match def with
      (* aps 2 *)
      ASTConst(id,_,e) -> let (v , mem') =  eval_expr e env mem in ((id, e')::env,mem')
      (* ASTConst(id,_,e) -> ((id , eval_expr e env mem) :: env,mem)  *)
    | ASTVar(id, _) -> ((id , InA(List.length mem)) :: env, (mem @ [(List.length mem), InN(-1)])) (*a verifier*)
    | ASTProc(id, args, bk) -> ((id, InP(bk ,recup_args args ,env)) :: env, mem)
    | ASTProcRec(id, args, bk) -> ((id , InPR(bk , id, recup_args args , env)) :: env, mem)
    | ASTFunc (id ,_,args, e) ->((id , InF(e ,recup_args args ,env )) :: env, mem)
    | ASTFuncRec (id ,_ ,args, e ) -> ((id , InFR(e , id, recup_args args , env)) ::env, mem)

and eval_lvalue lval env mem =
    match lval with
      ASTLvId id -> (match recup_env id env with
                        |InA(a) -> (a , mem)
                        |InB(a , n ) -> (a+1 , mem)
                        |_ -> failwith "Not an Lvalue")
      |ASTLval (lval, e) -> (match eval_lvalue lval env mem with
                            (a , mem) -> (match eval_expr e env mem with
                                            (InN(i),mem') -> (match recup_mem (a+i) mem' with
                                                              InN(n) -> ((a+i),mem')
                                                              |Block(a',n) -> ((a'+i),mem')
                                                              |_ ->failwith "Error in lnth")
                                            |_ -> failwith "Error in lnth")
                              )

and eval_cmds cs env output mem = 
  match cs with
    ASTStat(stat) -> (eval_stat stat env output mem)
    |ASTDef(def ,cmds) -> (let (env', mem') = eval_def def env mem in
                            eval_cmds cmds env' output mem')
  | ASTStats(s, cmds) -> (let (mem', output') = eval_stat s env output mem in
                            eval_cmds cmds env output' mem')

and eval_block cs env output mem =
  match cs with
  |ASTBlock(cs) -> (eval_cmds cs env output mem)
                                

let print_val v = 
  match v with
  | InN(n) -> Printf.printf "%d \n "n
  | _ -> failwith "not a printable value"



let eval_prog prog = 
  match prog with
  |ASTProg(cmds) -> let (_, new_output) = eval_cmds cmds [] [] [] in
                    print_output new_output 
and print_output output =
  List.iter (function x -> print_val x) (List.rev output)