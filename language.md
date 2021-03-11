**Язык программирования L**

**Алфавит** 
'a...bA...B0...9_'

**Структура программы**
'begin' statements 'end'

Пробелы разделяют слова языка. Отступы не имеют никакого смысла кроме визуального удобства. После каждого выражения стоит ';'.

В условном выражении число <=0 считается как false, > 0 - как true.

**Идентификаторы**
`if`, `while`, `or`, `else`, `and`, `begin`, `end`, `for`, `not`, `function`, `true`, `false` etc.

`if` :: 'if' '(' term ')' 'begin' sequence 'end' 'else' 'begin' sequence 'end'; ветки 'else' может не быть
`while` :: 'while' '(' term ')' 'begin' sequence 'end'
`assign` :: var '=' term
`read` :: '>>' var
`print` :: '<<' term

`sequence` :: statement ';' | sequence+
`statement` :: term | if | while | assign | read | print
`term` :: '(' term ')' | term binop term | not term | var | num

`num` :: '-'? ('0' | ... | '9')+, целое число
`var` :: любое слово над алфавитом

`binop` :: '^' | '*' | '/' | '+' | '-' | '<=' | '<' | '=>' | '>' | '==' | '!='
`not`  :: '!'
