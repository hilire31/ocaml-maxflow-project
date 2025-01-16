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


(*----------------------------Tools for multi-flux graphes----------------------------*)



let nth_element n lst =
  try List.nth lst n
  with Failure _ -> invalid_arg "Index n est hors limites de la liste.";;

let rec m_resolve lst1 lst2 =
(* Additionne deux listes d'entiers élément par élément *)
  match (lst1, lst2) with
  | [], [] -> []
  | x::xs, y::ys -> (x + y) :: m_resolve xs ys
  | [], y::ys -> y :: m_resolve [] ys  (* Si une liste est plus longue *)
  | x::xs, [] -> x :: m_resolve xs []  (* que l'autre, on la conserve *)
  ;;
  let rec m_add_to_nth n k lst =
    match lst with
    | [] -> failwith "Index out of bounds" (* Si la liste est vide ou si l'index dépasse la taille *)
    | x :: xs -> 
        if n = 0 then (x + k) :: xs (* Ajouter k au premier élément *)
        else x :: m_add_to_nth (n - 1) k xs (* Continuer à parcourir la liste *)
  ;;
  let rec lst_vide n = match n with
    |0->[]
    |_->0::lst_vide (n-1);;
  
  
  let m_add_arc g id1 id2 lst = match find_arc g id1 id2 with
    |None -> new_arc g  { src = id1; tgt = id2; lbl = lst }
    |Some a-> new_arc g  { src = id1; tgt = id2; lbl = (m_resolve lst a.lbl)};;

let m_inf n list1 list2 =
  nth_element n list1 < nth_element n list2;;


let m_decrease_arc graphe arc min number_of_flux step = let new_graphe = m_add_arc graphe arc.src arc.tgt (m_add_to_nth step (-min) (m_add_to_nth (number_of_flux+1) (-min) (lst_vide (number_of_flux+1)))) in
m_add_arc new_graphe arc.tgt arc.src (m_add_to_nth step (-min) (m_add_to_nth number_of_flux (-min) (lst_vide number_of_flux)));;

let rec m_decrease_path graphe path min number_of_flux step = match (graphe,path) with
|(g,a::prest)->let new_graph = m_decrease_arc g a min number_of_flux step in m_decrease_path new_graph prest min number_of_flux step;
|(g,[])->g;;


(* Convertit une chaîne de caractères en une liste d'entiers *)
let string_to_int_list str =
  str
  |> String.split_on_char ' ' (* Divise par espaces *)
  |> List.map int_of_string  (* Convertit chaque élément en entier *)
;;

let rec t_find_min_at_n n lists =
  match lists with
  | [] -> failwith "La liste est vide, aucun minimum à trouver."
  | [x] -> List.nth x n  (* Si une seule liste reste, c'est la minimum par défaut *)
  | x :: rest ->
      let min_rest = t_find_min_at_n n rest in
      if (List.nth x n < min_rest n && (List.nth x n) > 0 ) then List.nth x n
      else min_rest;;

let rec m_find_min_at_n n arcs =
  match arcs with
  | [] -> failwith "La liste d'arcs est vide, aucun minimum à trouver."
  | [x] -> x  (* Si un seul arc reste, c'est le minimum par défaut *)
  | x :: rest ->
      let min_rest = m_find_min_at_n n rest in
      if (List.nth x.lbl n < List.nth min_rest.lbl n && (List.nth x.lbl n) > 0) then x
      else min_rest;;





let rec drop n lst =
  match lst with
  | [] -> []  (* Si la liste est vide, retourner une liste vide *)
  | _ :: rest when n > 0 -> drop (n - 1) rest  (* Ignorer les \( n \) premiers éléments *)
  | _ -> lst;;  (* Retourner le reste de la liste une fois \( n \) atteint *)


let my_string_to_int_list s =
  (* Sépare la chaîne en une liste de sous-chaînes en utilisant ',' comme délimiteur *)
  let string_list = String.split_on_char ',' s in
  (* Convertit chaque sous-chaîne en entier *)
  List.map int_of_string string_list
;;
  