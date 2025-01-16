
open Tools
open Parcours
open Gfile
open Ff
let () =

  (* Check the number of command-line arguments /open Parcours*)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  (*
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in*)
(*
  let test_path = profondeur int_graph 0 12 [0] [0] in
  print_list test_path ;
  let min = (min_from_path (extract_arcs(path_from_node_list int_graph test_path))) in
  let new_graph = decrease_path int_graph (extract_arcs(path_from_node_list int_graph test_path)) min in
*)

  (* Open file *)

  (*
  let graph = from_file infile in
  let int_graph = add_arc (gmap graph (int_of_string )) 4 10 (0) in
  let new_graph = init int_graph 0 12 in
  let modified_graph = gmap new_graph (string_of_int) in 
  let () = export (outfile^".dot") modified_graph in
  let _step_graph = recursion new_graph 0 12 2 2 in
  ()
*)


(*

*)

let infile = Sys.argv.(1)
and outfile = Sys.argv.(4) in
let graph = from_file infile in
let () = export (outfile^"1.dot") graph in
let m_int_graph = gmap graph (my_string_to_int_list) in


Printf.printf "test path : \t%!";(*
*)
let m_min = m_find_min_at_n 0 (extract_arcs (path_from_node_list m_int_graph (m_profondeur m_int_graph 0 3 [0] [0] 0))) in
let m_path = extract_arcs (path_from_node_list m_int_graph (m_profondeur m_int_graph 0 3 [0] [0] 0)) in
let ordre = [0;1;2] in
let step = 0 in 
let nov_graphe = m_decrease_path m_int_graph m_path m_min 3 0 in  
print_list contexte;
Printf.printf("\n%!");

Printf.printf("-----------------------\n%!");

let otherfile = "graphs/graph2.txt" in
let graph = from_file otherfile in
let int_graph = add_arc (gmap graph (int_of_string )) 4 10 (0) in
let new_graph = init int_graph 0 12 in
let modified_graph = gmap new_graph (string_of_int) in 
let () = export (outfile^"2.dot") modified_graph in
let _step_graph = recursion new_graph 0 12 2 2 in
()

