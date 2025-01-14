(*open Graph*)

open Parcours
open Tools
open Gfile

let init graphe source target = 
  let path = profondeur graphe source target [source] [source] in 
  match path with 
  |[]->failwith "pas de flow à augmenter"
  |path->let min = (min_from_path (extract_arcs(path_from_node_list graphe path))) in
  decrease_path graphe (extract_arcs(path_from_node_list graphe path)) min;;  


let rec recursion graphe source target step flow= 
  let path = profondeur graphe source target [source] [source] in 
  match path with 
  |[]-> graphe
  |path->let min = (min_from_path (extract_arcs(path_from_node_list graphe path))) in
  let step_graph = decrease_path graphe (extract_arcs(path_from_node_list graphe path)) min in 
  let modified_graph = gmap step_graph (string_of_int) in 
  export ("step"^(string_of_int step)^".dot") modified_graph;
  let next_flow = (flow+min) in
  Printf.printf "flow step %d = %d\n%!" step next_flow;
  recursion step_graph source target (step+1) next_flow;;

(* 

val m_step : int list graph -> int -> int -> int -> int list -> int -> int list -> int list

let m_step graphe src tgt n ordre step contexte = 
  let m_min = m_find_min_at_n 0 (extract_arcs (path_from_node_list graphe (m_profondeur graphe src tgt [src] [tgt] n))) in
  b_pivot contexte m_min.lbl ordre step ;;



*) 





