type token =
  | INT of (string)
  | X
  | Y
  | Z
  | INC
  | DEC
  | ZERO
  | ELSE
  | STOP
  | EOF
  | NEWLINE

val instlist :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.inst list
