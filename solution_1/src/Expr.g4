grammar Expr;

language : sequence EOF;

sequence : statement | statement WS* sequence;
statement : n_if | n_while | n_read | n_write | n_assign;
compound_statement : '{' WS* sequence WS* '}' | '{' WS* '}';

n_if : 'if' SPACES* condition WS* compound_statement WS* 'else' WS* compound_statement;
n_while : 'loop' SPACES* condition WS* compound_statement;
n_assign : IDENT SPACES* ':=' SPACES* expr SPACES* ';';
n_read : 'in' SPACES* IDENT SPACES* ';';

n_write : 'out' SPACES* expr SPACES* ';';

expr : IDENT | NUM | binary_operation | '(' SPACES* expr SPACES* ')';

condition : '(' SPACES* expr SPACES* ')';

binary_operation : <assoc=right> binary_operation op='^' binary_operation
    | binary_operation op=('*' | '/') binary_operation
    | binary_operation op=('+' | '-') binary_operation
    | binary_operation op=('<' | '>' | '==' | '!=' | '<=' | '>=') binary_operation
    | <assoc=right> binary_operation op='&&' binary_operation
    | <assoc=right> binary_operation op='||' binary_operation
    | '(' SPACES* binary_operation SPACES* ')'
    | NUM
    | IDENT
    ;

IDENT: [a-zA-Z][a-zA-Z0-9_]*;

NUM : NAT | '(' SPACES* '-' SPACES* NAT SPACES* ')';

NAT : '0' | [1-9] [0-9]*;

SPACES : [ \t]+ -> skip;

WS : [ \t\r\n]+ -> skip;