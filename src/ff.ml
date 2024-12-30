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
  let fordfulkerson graphe source target = 
init graphe source target in
recursion graphe source target;;
*)









