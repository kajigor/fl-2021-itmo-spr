grammar SuperLanguage;

/*
    Parser rules
*/

program: statement EOF;

expr
    : <assoc=right> expr op=POW expr # Pow
    | expr (MULT | DIV) expr         # Mult
    | expr (PLUS | MINUS) expr       # Add
    | expr (EQ | NEQ) expr           # Eq
    | expr (LT | GT | LE | GE) expr  # Comp
    | NUMBER                         # Num
    | IDENTIFIER                     # Ident
    | braceExpression                # Paren
    ;

braceExpression
    : LRB expr RRB
    ;

statement
    : expr SEMICOLON
    | IF braceExpression statement (ELSE statement)?
    | WHILE braceExpression statement
    | READ IDENTIFIER SEMICOLON
    | WRITE expr SEMICOLON
    | IDENTIFIER ASSIGN expr SEMICOLON
    | seq
    ;

seq: LB statement* RB;


/*
    Lexer rules
*/

WS: [ \t\r\n]+ -> skip;

// Section: keywords
ASSIGN: '=';
IF: 'if';
ELSE: 'else';
WHILE: 'while';
READ: 'read';
WRITE: 'write';

// Section: numbers
NUMBER: (PLUS | MINUS)? DigitNonZero Digit*;
fragment Digit: '0' .. '9';
fragment DigitNonZero: '1' .. '9';

// Section: operators
POW: '^';
MULT: '*';
DIV: '/';
PLUS: '+';
MINUS: '-';
EQ: '==';
NEQ: '!=';
LE: '<=';
LT: '<';
GE: '>=';
GT: '>';

// Section: braces
LRB: '(';
RRB: ')';
LB: '{';
RB: '}';

SEMICOLON: ';';

IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
