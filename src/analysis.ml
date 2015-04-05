(* Analysis *)

open Ast

let print_apx apx domain_to_str = 
	(* print approximation *)
	for i = 0 to (Array.length apx) -1 do
	begin
		match apx.(i) with
		| (x, y, z) ->
			Printf.printf "(%i,%s,%s,%s)" (i+1) (domain_to_str x) (domain_to_str y) (domain_to_str z);
			print_newline()
	end
	done

(*
	prog 			- list representation of source code
	aprx 			- first approximation
	join 			- join of two states
	incr/decr/		- op. inside abstract domain
	iszero/notzero
*)
let analysis prog aprx join incr decr iszero notzero operator = 
	(* Kleene iterations *)
	let iterate apx =
	
		let step : ('a * 'a * 'a) array ref -> int -> 'a * 'a * 'a -> unit = fun apx' pc (x, y, z) -> 
			match List.nth prog pc with
				| INC X -> !apx'.(pc+1) <- join !apx'.(pc+1) (incr x, y, z)
				| INC Y -> !apx'.(pc+1) <- join !apx'.(pc+1) (x, incr y, z)
				| INC Z -> !apx'.(pc+1) <- join !apx'.(pc+1) (x, y, incr z)
				| DEC X -> !apx'.(pc+1) <- join !apx'.(pc+1) (decr x, y, z)
				| DEC Y -> !apx'.(pc+1) <- join !apx'.(pc+1) (x, decr y, z)
				| DEC Z -> !apx'.(pc+1) <- join !apx'.(pc+1) (x, y, decr z)
				
				| ZERO(X, pc', pc'') -> (
					!apx'.(pc'-1)  <- join !apx'.(pc'-1) (iszero x, y, z);
					!apx'.(pc''-1) <- join !apx'.(pc''-1) (notzero x, y, z)
					)
				| ZERO(Y, pc', pc'') -> (
					!apx'.(pc'-1)  <- join !apx'.(pc'-1) (x, iszero y, z);
					!apx'.(pc''-1) <- join !apx'.(pc''-1) (x, notzero y, z)
					)
				| ZERO(Z, pc', pc'') -> (
					!apx'.(pc'-1)  <- join !apx'.(pc'-1) (x, y, iszero z);
					!apx'.(pc''-1) <- join !apx'.(pc''-1) (x, y, notzero z)
					)
					
				| _ -> !apx'.(pc) <- !apx'.(pc)
		in
		let cur_apx  = ref (Array.copy apx) in
		let prev_apx = ref (Array.copy apx) in 		(* previous approximation *)
		let fix_point = ref false in				(* fix point flag *)
		while not !fix_point do                     
		begin
			for i = 0 to ((List.length prog)-1) do 
				step cur_apx i !cur_apx.(i)
			done;
			for i = 0 to (List.length prog) - 1 do 
				!cur_apx.(i) <- operator !prev_apx.(i) !cur_apx.(i)
			done;
			(* check if current apx equal to prev *)
			if (!cur_apx = !prev_apx)	
			then fix_point := true
			else prev_apx  := Array.copy !cur_apx
		end
		done;
		!cur_apx
	in
		iterate aprx 