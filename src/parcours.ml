
open Graph

let rec print_list node_list = 
  match node_list with
  |x::rest->Printf.printf "%d\t%!" x;print_list rest;(*%! = flush comme en JAVA ? à chercher*)
  |[]->Printf.printf "fin%!";;



let difference lst1 lst2 =
  List.filter (fun x -> not (List.mem x lst2)) lst1;;

let difference_not_empty lst1 lst2 =
  List.exists (fun x -> not (List.mem x lst2)) lst1;;

let next_nodes graphe current = (List.map (fun arc -> arc.tgt) (List.filter (fun x -> x.lbl > 0) (out_arcs graphe current)));;

let m_next_nodes graphe current n = (List.map (fun arc -> arc.tgt) (List.filter (fun x -> (List.nth x.lbl n) > 0) (out_arcs graphe current)));;


let choose_next graphe current lvoisin = let lnext = difference (next_nodes graphe current) lvoisin in match lnext with 
|[]->failwith "erreur choose";
|x::_->x;;

let m_choose_next graphe current lvoisin n = let lnext = difference (m_next_nodes graphe current n) lvoisin in match lnext with 
|[]->failwith "erreur choose";
|x::_->x;;

let rec profondeur (graphe : int graph) (current : id) (target : id) (pathstack : id list) (visited : id list) : id list =  match (pathstack,visited) with
  |(p::_,_) when (p = target) -> List.rev pathstack
  |([],__)->[]
  |(p::prest,v) when (difference_not_empty (next_nodes graphe current) v) -> let nx = choose_next graphe current (v) in profondeur graphe nx target (nx::p::prest) (nx::v)
  |(_::prest,v) when (not ((difference_not_empty (next_nodes graphe current) v)) && (prest = [])) ->[]

  |(_::pp::prest,v) when not (difference_not_empty (next_nodes graphe current) v) -> profondeur graphe pp target (pp::prest) (v)
  |(_,_)->failwith "erreur profondeur"
  


;;

let rec m_profondeur (graphe : int list graph) (current : id) (target : id) (pathstack : id list) (visited : id list) (n : int): id list =  match (pathstack,visited) with
  |(p::_,_) when (p = target) -> List.rev pathstack
  |([],__)->[]
  |(p::prest,v) when (difference_not_empty (m_next_nodes graphe current n) v) -> let nx = m_choose_next graphe current v n in m_profondeur graphe nx target (nx::p::prest) (nx::v) n
  |(_::prest,v) when (not ((difference_not_empty (m_next_nodes graphe current n) v)) && (prest = [])) ->[]

  |(_::pp::prest,v) when not (difference_not_empty (m_next_nodes graphe current n) v) -> m_profondeur graphe pp target (pp::prest) v n
  |(_,_)->failwith "erreur profondeur"
  


;;































