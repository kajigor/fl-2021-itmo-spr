# Syntax notation

The grammar below uses the following BNF-style conventions:

[x] denotes zero or one occurrences of x.

{x} denotes zero or more occurrences of x.


## Operators
* _InfixOp_:
    
    | `^`  -- exponentiation

    | `*`  -- multiplication

    | `/`  -- division (with remainder)

    | `+`  -- addition

    | `-`  -- subtraction

    | `==` -- comparison for equality

    | `!=` -- comparison for inequality

    | `<=` -- less or equal

    | `<`  -- less

    | `>=` -- greater or equal

    | `>`  -- greater

## Literals
* _NumLiteral_: sequence of digits matching `/[1-9]+[0-9]*/` regex

## Keywords
* _Keyword_:

    | _Assign_

    | _If_

    | _Else_

    | _While_

    | _Read_

    | _Write_

* _Assign_: `=`

* _If_: `if`

* _Else_: `else`

* _While_: `while`

* _Read_: `read`

* _Write_: `write`

* _Ignore_: `;`


## Identifier

* _VariableName_: sequence of characters matching `/[a-zA-Z_]+[a-zA-Z0-9_]*/` regex but not a _Keyword_

## Delimiters
* _Delimiter_: sequence of any whitespace characters matching `/\s+/` regex

## Braces
* _LRB_: `(`
* _RRB_ : `)`
* _LB_: `{`
* _RB_: `}`

## Expression
* _Expression_:

    | _VariableName_ -- identifier

    | _NumLiteral_ --  number

    | _Expression_ [_Delimiter_] _InfixOp_ [_Delimiter_] _Expression_ --    binary operator expression
    
    | _BraceExpression_

* _BraceExpression_:

    | _LRB_ [_Delimiter_] _Expression_ [_Delimiter_] _RRB_ -- expression in round braces

## Statements
* _Statement_:
    
    | _Expression_ _Ignore_ -- instruction that is an expression
    
    | _If_ [_Delimiter_] _BraceExpression_ [_Delimiter_] _Statement_ [_Delimiter_] [_Else_ _Statement_] -- conditional expression. The first operand is the condition, the second is a true branch, the third is an optional false branch
    
    | _While_ [_Delimiter_] _BraceExpression_ [_Delimiter_]         _Statement_ -- loop with condition. _BraceExpression_ is a condition
    
    | _Read_ _Delimiter_ _VariableName_ -- read value into variable
    
    | _Write_ _Delimiter_ _Expression_ -- print expression value
    
    | _VariableName_ [_Delimiter_] _Assign_ [_Delimiter_]   _Expression_            -- assign value to variable

    | _Seq_
    
* _Seq_:

    | _LB_ [_Delimiter_] {_Statement_ _Delimiter_} [_Delimiter_] _RB_ -- sequence of statements, maybe empty

* _Program_:
    
    | _Statement_
