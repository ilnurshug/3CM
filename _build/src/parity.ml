(* parity domain module *)
type parity = Bottom | Top | Even | Odd

let bot = Bottom

let leq a b = match (a, b) with
	  (Bottom, _) | (_, Top) -> true
	| _           -> false
	
let join a b = match (a, b) with
	| (Top, _) | (_, Top) | (Even, Odd) | (Odd, Even) -> Top
	| (Bottom, b) -> b
	| (a, Bottom) -> a
	| (Odd, Odd)  -> Odd
	| (Even, Even) -> Even

let iszero a = match a with
	  Even | Top -> Even
	| Odd  | Bottom -> Bottom

let notzero a = match a with
	| Odd -> Odd
	| Top -> Top
	| Even -> Even
	| Bottom -> Bottom

let incr a = match a with
	  Even -> Odd
	| Odd  -> Even
	| Top  -> Top
	| _    -> Bottom

let decr a = match a with
	  Odd  -> Even
	| Even -> Top         (* ??? *)
	| Top  -> Top
	| _    -> Bottom