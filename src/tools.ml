(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
(*returns a new graph having the same nodes than gr, but no arc*)
let clone_nodes (gr:'a graph) = n_fold gr (new_node) empty_graph;;

(*maps all arcs of gr by function f*)
let gmap gr f =
  let new_gr = clone_nodes gr in
  (* Étape 2 : Transformer et ajouter les arcs *)
  e_fold gr (fun acc arc -> let nouv_arc = { src = arc.src; tgt = arc.tgt; lbl = f arc.lbl } in
  new_arc acc nouv_arc) new_gr;;


(*adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created.*)
let add_arc g id1 id2 n = match find_arc g id1 id2 with
  |None -> new_arc g  { src = id1; tgt = id2; lbl = n }
  |Some a-> new_arc g  { src = id1; tgt = id2; lbl = n +  a.lbl};;


let rec path_from_node_list graphe node_list = match node_list with
  |x::y::rest ->(find_arc graphe x y)::(path_from_node_list graphe (y::rest));
  |_->[];;
let extract_arcs (lst : ('id arc option) list) : ('id arc) list =
    List.filter_map (fun x -> x) lst
  ;;
  

  let rec min_from_path path =
    match path with
    | [] -> failwith "Empty path: no minimum value"
    | [x] -> x.lbl 
    | x :: rest ->
        let min_rest = min_from_path rest in
        if x.lbl < min_rest then x.lbl else min_rest
  ;;

  let decrease_arc graphe arc min = let new_graphe = add_arc graphe arc.src arc.tgt (-min) in
  add_arc new_graphe arc.tgt arc.src min;;
  
  let rec decrease_path graphe path min= match (graphe,path) with
    |(g,a::prest)->let new_graph = decrease_arc g a min in decrease_path new_graph prest min;
    |(g,[])->g;;