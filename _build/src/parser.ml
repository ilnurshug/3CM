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

open Parsing;;
let _ = parse_error;;
# 3 "src/parser.mly"
# 18 "src/parser.ml"
let yytransl_const = [|
  258 (* X *);
  259 (* Y *);
  260 (* Z *);
  261 (* INC *);
  262 (* DEC *);
  263 (* ZERO *);
  264 (* ELSE *);
  265 (* STOP *);
    0 (* EOF *);
  266 (* NEWLINE *);
    0|]

let yytransl_block = [|
  257 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\003\000\003\000\
\003\000\000\000"

let yylen = "\002\000\
\000\000\003\000\002\000\002\000\005\000\001\000\001\000\001\000\
\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\006\000\010\000\000\000\
\007\000\008\000\009\000\003\000\004\000\000\000\000\000\000\000\
\002\000\000\000\005\000"

let yydgoto = "\002\000\
\007\000\008\000\012\000"

let yysindex = "\002\000\
\251\254\000\000\003\255\003\255\003\255\000\000\000\000\000\255\
\000\000\000\000\000\000\000\000\000\000\010\255\251\254\004\255\
\000\000\012\255\000\000"

let yyrindex = "\000\000\
\014\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\014\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\001\000\000\000\004\000"

let yytablesize = 16
let yytable = "\003\000\
\004\000\005\000\001\000\006\000\009\000\010\000\011\000\013\000\
\014\000\015\000\016\000\018\000\019\000\001\000\000\000\017\000"

let yycheck = "\005\001\
\006\001\007\001\001\000\009\001\002\001\003\001\004\001\004\000\
\005\000\010\001\001\001\008\001\001\001\000\000\255\255\015\000"

let yynames_const = "\
  X\000\
  Y\000\
  Z\000\
  INC\000\
  DEC\000\
  ZERO\000\
  ELSE\000\
  STOP\000\
  EOF\000\
  NEWLINE\000\
  "

let yynames_block = "\
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 22 "src/parser.mly"
                                 ( [] )
# 97 "src/parser.ml"
               : Ast.inst list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'inst) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.inst list) in
    Obj.repr(
# 23 "src/parser.mly"
                                 ( _1::_3 )
# 105 "src/parser.ml"
               : Ast.inst list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'var) in
    Obj.repr(
# 26 "src/parser.mly"
                                 ( Ast.INC _2 )
# 112 "src/parser.ml"
               : 'inst))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'var) in
    Obj.repr(
# 27 "src/parser.mly"
                                 ( Ast.DEC _2 )
# 119 "src/parser.ml"
               : 'inst))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 28 "src/parser.mly"
                                 ( Ast.ZERO (_2, 
				 	     int_of_string _3,
					     int_of_string _5) )
# 130 "src/parser.ml"
               : 'inst))
; (fun __caml_parser_env ->
    Obj.repr(
# 31 "src/parser.mly"
                                 ( Ast.STOP )
# 136 "src/parser.ml"
               : 'inst))
; (fun __caml_parser_env ->
    Obj.repr(
# 34 "src/parser.mly"
                                 ( Ast.X )
# 142 "src/parser.ml"
               : 'var))
; (fun __caml_parser_env ->
    Obj.repr(
# 35 "src/parser.mly"
                                 ( Ast.Y )
# 148 "src/parser.ml"
               : 'var))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "src/parser.mly"
                                 ( Ast.Z )
# 154 "src/parser.ml"
               : 'var))
(* Entry instlist *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let instlist (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.inst list)
