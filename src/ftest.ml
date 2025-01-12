
open Tools
open Parcours
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
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
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
let l1 = [ 5 ; 4 ; 3 ; 2 ; 1 ] in
let a = nth_element 3 l1 in
Printf.printf "%d\n%!" a;
let crit =[[3;0;3];[5;3;0];[0;4;3]] in
let b = t_find_min_at_n 1 crit in
print_list b ;
let i1 = [1;3;4;0;2] in
let l2 = rearrange l1 i1 in
Printf.printf "\ndebut : %!";
print_list l2;
let contrainte = [4;2;3;4] in
let contexte = [6;6;6] in 
let ordre = [2;0;1] in 
let step = 0 in 
let nov_contexte = b_pivot contexte contrainte ordre step in 
Printf.printf "\ndebut : %!";
print_list nov_contexte;


Printf.printf "\ndebut test 2 : %!";
let contrainte = [0;5;3;5] in
print_list contrainte;
let contexte = [6;6;6] in 
let ordre = [1;2;0] in 
let step = 0 in 
let nov_contexte = b_pivot contexte contrainte ordre step in 
Printf.printf "\ndebut : %!";
print_list nov_contexte;
()

