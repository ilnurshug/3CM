(* Interval domain *)

let bot = (infinity, neg_infinity)

let leq (l,h) (l',h') = l' <= l && h <= h'

let join (l,h) (l',h') = (min l l', max h h')

let incr : float*float -> float*float = fun (l, h) -> (l +. 1.0, h +. 1.0)

let decr : float*float -> float*float = fun (l, h) -> (l -. 1.0, h -. 1.0)

let iszero : float*float -> float*float = fun (l, h) -> 
	if l <= 0.0 && 0.0 <= h then (0.0,0.0) else (infinity, neg_infinity)

let notzero : float*float -> float*float = fun (l, h) -> 
	if l > 0.0 || h < 0.0 || (l < 0.0 && 0.0 < h) 
	then (l, h)
	else if h == 0.0 then (l, h -. 1.0)
	else (l +. 1.0, h)
	

let wide_op : float*float -> float*float -> float*float = fun (l,h) (l',h') ->
							if l == infinity && h == neg_infinity then (l',h')
							else if l' == infinity && h' == neg_infinity then (l,h)
							else 
							begin
								let a = if l' < l then neg_infinity else l in
								let b = if h' > h then infinity else h in
								(a, b)
							end
	
let wide : (float*float -> float*float) -> float*float -> float*float = fun func i -> wide_op i (func i) 

let narrow_op : float*float -> float*float -> float*float = fun (l,h) (l',h') ->
							if l == infinity && h == neg_infinity then bot
							else if l' == infinity && h' == neg_infinity then bot
							else 
							begin
								let a = if l == neg_infinity then l' else l in
								let b = if h == infinity then h' else h in
								(a, b)
							end
							
let narrow : (float*float -> float*float) -> float*float -> float*float = fun func i -> narrow_op i (func i) 