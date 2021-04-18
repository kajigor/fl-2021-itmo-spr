grammar Expr;

start : stmt EOF;

stmt : expr |
    'if' WS? expr '{' WS? stmt WS? '}' WS? else? |
    'while' WS? '{' WS? stmt  WS? '}' |
    'read('IDENT');' |
    'write('expr');' |
    'var' WS? IDENT WS? '=' WS? expr ';'|
    stmt(stmt)+
    ;
expr: IDENT | NUM | e;
else: 'else' WS? '{' stmt '}';


e : <assoc=right> e op=POW e # Pow
  | e op=(MULT | DIV) e      # MULT
  | e op=(PLUS | MINUS) e    # Sum
  | NUM                      # Num
  ;


MULT : '*';
DIV : '/';
PLUS : '+';
MINUS : '-';
POW : '^';
NUM : '0' | ('1' .. '9') ('0' .. '9')*;
IDENT: [a-zA-Z_]+[a-zA-Z_0-9];

WS : [ \t\r\n] -> skip ;

