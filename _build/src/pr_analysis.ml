open Ast
open Parity
open Analysis

(* let run prog = print_endline ("Analysis \n") *)

(* converts element of parity domain to string *)
let pr_to_str p = match p with
	| Top -> "Top"
	| Bottom -> "Bottom"
	| Even -> "Even"
	| Odd -> "Odd"

(* join two approximations *)
let join a b = match (a, b) with
	| ((x, y, z), (x',y',z')) -> (Parity.join x x', Parity.join y y', Parity.join z z')
	
let apx p_len = Array.append [|(Top, Even, Even)|] 
		          (Array.make (p_len - 1) (Bottom, Bottom, Bottom) )

let snd a b = b
		          
let run prog = Analysis.analysis prog (apx (List.length prog)) 
                                 join 
                                 Parity.incr Parity.decr Parity.iszero Parity.notzero
                                 snd