module AstStmt where

-- Имена переменных
type Var = String

data Operator = Pow   -- Возведение в степень
              | Mult  -- Умножение
              | Div   -- Деление (с остатком)
              | Plus  -- Сложение
              | Minus -- Вычитание
              | Eq    -- Сравнение на равенство
              | Neq   -- Сравнение на неравенство
              | Le    -- Меньше или равно
              | Lt    -- Меньше
              | Ge    -- Больше или равно
              | Gt    -- Больше

-- Выражения (expressions)
data Expr = Ident Var                -- Идентификатор
          | Num Int                  -- Число
          | BinOp Operator Expr Expr -- Выражение с бинарным оператором

-- Инструкции (statements)
data Stmt = Ignore Expr               -- Инструкция, которая является выражением (подразумевается, что значение выражения игнорируется)
          | If Expr Stmt (Maybe Stmt) -- Условное выражение. Первый операнд -- условие, второй -- ветка true, третий -- опциональная ветка else
          | While Expr Stmt           -- Цикл с предусловием. Первый операнд -- условие
          | Read Var                  -- Прочитать значение переменной
          | Write Expr                -- Напечатать значение выражения
          | Assign Var Expr           -- Присвоить значение выражения переменной
          | Seq [Stmt]                -- Последовательность инструкций

-- Абстрактное синтаксическое дерево программы
data Program = Program Stmt -- Программа является инструкцией

toOp :: Operator -> String
toOp Pow = "^"
toOp Mult = "*"
toOp Div = "/"
toOp Plus = "+"
toOp Minus = "-" 
toOp Eq = "=="
toOp Neq = "!="
toOp Le = "<="
toOp Lt = "<"
toOp Ge = ">="
toOp Gt = ">"

printExpr :: Expr -> String
printExpr (Ident sname) = sname
printExpr (Num num) = show num
printExpr (BinOp op ex1 ex2) =
    let op' = toOp op
        ex1' = printExpr ex1
        ex2' = printExpr ex2
    in ex1' ++ " " ++ op' ++ " " ++ ex2'

printIf :: Expr -> Stmt -> Maybe Stmt -> String
printIf ex stmt1 (Just stmt2) = "if (" ++ printExpr ex ++ ") " 
        ++ printStmt stmt1 ++ "else " 
        ++ printStmt stmt2
printIf ex stmt1 Nothing = "if (" ++ printExpr ex ++ ") " 
        ++ printStmt stmt1 

printWhile :: Expr -> Stmt -> String
printWhile ex stmt = "while (" ++ printExpr ex ++ ") " 
    ++ printStmt stmt

printStmt :: Stmt -> String
printStmt stmt =
    case stmt of
        Ignore ex         -> printExpr ex ++ ";"
        If ex stmt1 stmt2 -> printIf ex stmt1 stmt2
        While ex stmt     -> printWhile ex stmt           
        Read var          -> "read " ++ var                 
        Write ex          -> "write " ++ printExpr ex       
        Assign var ex     -> var ++ " = " ++ printExpr ex         
        Seq xs            -> "{" ++ foldr (\stmt str -> printStmt stmt ++ " " ++ str) "}" xs

printer :: Program -> String
printer (Program stmt) = printStmt stmt

test1 = Program $ Seq [Read "a", While (BinOp Le (Ident "a") (Num 100)) (Seq [Write (Ident "a"), Assign "a" (BinOp Minus (Ident "a") (Num 1))])]
