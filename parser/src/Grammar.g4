grammar Grammar;

program : ( WS* statement WS+ )* ;

statement : expr                                       # Expression
          | '?' WS+ expr WS+ '{' program '}'
            (WS+ ':' WS+ '{' program '}')?             # If
          | '@' WS+ expr WS+ '{' program '}'           # While
          | '>>' WS+ ID                                # Read
          | '<<' WS+ expr                              # Write
          | ID WS+ '{' WS+ expr WS+ '}'                # Assignment
          ;

expr : ID                                              # Id
     | NUMBER                                          # Number
     | '(' WS* expr WS* ')'                            # Braces
     | <assoc=right>
       expr WS* op='^' WS* expr                        # Pow
     | expr WS* op=('*' | '%') WS* expr                # MulDiv
     | expr WS* op=('+' | '-') WS* expr                # PlusMinus
     | expr WS* op=('<~' | '<' | '~>' | '>') WS* expr  # Compare
     | expr WS* op=('~' | '!') WS* expr                # Eq
     ;

fragment ALPHA : 'a' .. 'z' | 'A' .. 'Z' ;
fragment DIGIT : '0' .. '9' ;

NUMBER : ('+' | '-')* DIGIT+ ;
ID : ( DIGIT )* ALPHA ( ALPHA | DIGIT )* ;
WS : [ \t\n] ;
