open Ast

let rec emit_type t =
  Printf.sprintf
    "Type:= %s"
    (match t with
    | Int -> "int"
    | Bool -> "bool")


and string_of_types types = String.concat "," (List.map emit_type types)



let rec emit_expr expr =
  match expr with
  | ASTNum number -> Printf.sprintf "num(%d)" number
  | ASTId identifiant -> Printf.sprintf "id(%s)" identifiant
  | ASTAnd (oplog , expr , expr1 )->
    Printf.sprintf "and(%s,%s)" (emit_expr expr) (emit_expr expr1)
  | ASTOr (oplog , expr , expr1 ) ->
    Printf.sprintf "or(%s,%s)" (emit_expr expr) (emit_expr expr1)


and string_of_exprs exprs = String.concat "," (List.map emit_expr exprs)

let emit_prog e = "prog([ " ^ emit_expr e ^ " ])"