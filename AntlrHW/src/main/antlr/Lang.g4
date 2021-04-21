grammar Lang;

program : blockExpr EOF;

blockExpr : LBR expr (';' expr)* RBR;

expr : expr op=(STAR|SLASH|PERCENT) expr
     | expr op=(PLUS|MINUS) expr
     | expr op=(LT|LE|GE|GT) expr
     | expr op=(EQ|NEQ) expr
     | expr op=AND expr
     | expr op=OR expr
     | LPAR expr RPAR
     | nonBinExpr;

// Если использовать binExpr и подставить его
// в expr, то antlr ругается на взаимную рекурсию
//binExpr : expr op=(STAR|SLASH|PERCENT) expr
//        | expr op=(PLUS|MINUS) expr
//        | expr op=(LT|LE|GE|GT) expr
//        | expr op=(EQ|NEQ) expr
//        | expr op=AND expr
//        | expr op=OR expr
//        | LPAR expr RPAR;

nonBinExpr : writeExpr | readExpr | ifExpr | assignExpr | (NOT? basicExpr);

readExpr : READ LPAR IDENT RPAR;
writeExpr : WRITE LPAR expr RPAR;
basicExpr : IDENT | NUMBER | TRUE | FALSE;
assignExpr : IDENT ASSIGN blockExpr;
ifExpr : IF LPAR expr RPAR blockExpr (ELSE blockExpr)?;

fragment DIGIT : [0-9];
fragment LETTER : [a-zA-Z];

NOT : '!';
LPAR : '(';
RPAR : ')';
LBR : '{';
RBR : '}';
TRUE : 'true';
FALSE : 'false';
READ : 'read';
WRITE : 'write';
NUMBER : MINUS? DIGIT+;
MINUS : '-';
ASSIGN : '=';
IF : 'if';
ELSE : 'else';
IDENT : (LETTER|'_')(LETTER|DIGIT|'_')*;
STAR : '*';
SLASH : '/';
PERCENT : '%';
PLUS : '+';
LT : '<';
LE : '<=';
GE : '>=';
GT : '>';
EQ : '==';
NEQ : '!=';
AND : '&&';
OR : '||';
WS : [ \t\r\n]+ -> skip;
