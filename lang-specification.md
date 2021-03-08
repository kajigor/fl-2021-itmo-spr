

## Описание конкретного синтаксиса

```bash
language ::= sequence 

sequence ::= statement | statement sequence
statement ::= if | while | read | write | assign
compound_statement ::= '{' sequence '}' | '{}'

if ::= 'if' condition compound_statement 'else' compound_statement
while ::= 'loop' condition compound_statement
assign ::= ident ':=' expr ';'
read ::= 'in' ident ';'
write ::= 'out' expr ';'

expr ::= ident | num | expr operator expr

condition ::= '(' expr ')'

operator ::=  '+' | '-' | '*' | '/' | '\^' | '<' | '>' | '==' | '!=' | '<=' | '>=' | '&&' | '||'

ident ::= [a-zA-Z][a-zA-Z0-9_]*

num ::= nat | '(-'nat')'
nat ::= [0-9] | [1-9][0-9]*
```

### Замечания

Пробелы нужны только для разделения ключевых слов и восприятия текста. Значимыми они не являются.

Else ветка обязательна в условии. Но может быть пустой благодаря compound_statement.

Унарных операторов нет. Для отрицательных чисел вводится специальное обрамление в скобки '(-'nat')', например (-123).

## Приоритет операторов

| Приоритет | Оператор             | Ассоциативность   |
| :-------- | :------------------- | :---------------- |
| Высший    | ^                    | Правоассоциативна |
|           | *, /                 | Левоассоциативна  |
|           | +, -                 | Левоассоциативна  |
|           | ==, /=, <=, <, >=, > | Неассоциативна    |
|           | &&                   | Правоассоциативна |
| Низший    | \|\|                 | Правоассоциативна |