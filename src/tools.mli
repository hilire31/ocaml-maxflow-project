open Graph

val clone_nodes: 'a graph -> 'b graph (*returns a new graph having the same nodes than gr, but no arc*)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph
val add_arc: int graph -> id -> id -> int -> int graph

val path_from_node_list : int graph -> id list -> int arc option list
val min_from_path : int arc list -> int
val decrease_path : int graph -> int arc list -> int -> int graph
val extract_arcs : 'id arc option list -> 'id arc list