open Ast
open Interval
open Analysis

(* let run prog = print_endline ("Interval \n") *)

let it_to_str (l, h) = Printf.sprintf "[%.1f, %.1f]" l h


let operation op a b = match (a, b) with 
	| ((x, y, z), (x',y',z')) -> (op x x', op y y', op z z')
	
let apx p_len = Array.append [|((0.0, infinity), (0.0,0.0), (0.0,0.0))|] 
		               (Array.make (p_len - 1) (Interval.bot, Interval.bot, Interval.bot) )

(*let run prog = 
	Analysis.analysis prog (apx (List.length prog))  
								 (operation Interval.join)
								 Interval.incr 
								 Interval.decr
								 Interval.iszero
								 Interval.notzero
								 (operation Interval.wide_op)*)
		               
let run prog = 
	let upper_apx = Analysis.analysis prog (apx (List.length prog))  
								 (operation Interval.join)
								 Interval.incr 
								 Interval.decr
								 Interval.iszero
								 Interval.notzero
								 (operation Interval.wide_op)
	in
		Analysis.analysis prog upper_apx
			(operation Interval.join)
			Interval.incr
			Interval.decr
			Interval.iszero
			Interval.notzero
			(operation Interval.narrow_op)