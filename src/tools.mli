open Graph

val clone_nodes: 'a graph -> 'b graph (*returns a new graph having the same nodes than gr, but no arc*)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

val add_arc: int graph -> id -> id -> int -> int graph
val path_from_node_list : 'a graph -> id list -> 'a arc option list (*changed*)
val min_from_path : int arc list -> int
val decrease_path : int graph -> int arc list -> int -> int graph
val extract_arcs : 'id arc option list -> 'id arc list



val m_add_arc: int list graph -> id -> id -> int list -> int list graph
val m_resolve : int list -> int list -> int list

val m_decrease_path : int list graph -> int list arc list -> int -> int -> int -> int list graph

val m_inf : int -> int list -> int list -> bool
val string_to_int_list : string -> int list
val nth_element : int -> int list -> int

val t_find_min_at_n : int -> int list list -> int list
val m_find_min_at_n : int -> int list arc list -> int list arc
val drop : int -> 'a list -> 'a list



val my_string_to_int_list : string -> int list
