
open Graph

val profondeur : int graph -> id -> id -> id list -> id list -> id list
val print_list : id list -> unit
val choose_next : int graph -> id -> id list -> id
val difference_not_empty : id list -> id list -> bool
val difference : id list -> id list -> id list
val next_nodes : int graph -> id -> id list 


val m_profondeur : int list graph -> id -> id -> id list -> id list -> int -> id list