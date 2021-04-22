grammar L;

program: sequence EOF;

sequence: statement* ;

statement: ignore | if_statement | while_statement | read | write | assign | decl;

ignore: expr ';';

if_statement: 'if' '(' expr ')' '{' sequence '}';

while_statement: 'while' '(' expr ')' '{' sequence '}';

read: 'read' '(' IDENT ')' ';';

write: 'print' '(' expr ')' ';';

assign: IDENT '=' expr ';';

decl: 'var' IDENT ';';

expr: IDENT
    | <assoc=right> expr POW expr
    | expr (MULT | DIV) expr
    | expr (PLUS | MINUS) expr
    | expr EQ expr
    | NUM;

POW: '^';
MULT: '*';
DIV: '/';
PLUS: '+';
MINUS: '-';
EQ: '==' | '!=' | '<=' | '>=' | '>' | '<';

IDENT: [a-zA-Z][a-zA-Z0-9_]*;

NUM: '0' | [1-9][0-9]*;

WS: [ \t\r\n]+ -> skip;