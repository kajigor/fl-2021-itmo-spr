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

printer :: Program -> String
printer (Program st) = printStmt st

printStmt :: Stmt -> String
printStmt (Ignore expr              ) = printExpr expr
printStmt (If expr stmt else_branch ) = "if (" ++ printExpr expr ++ ") {" ++ printStmt stmt ++ "}" ++ maybe "" (\s -> " else { " ++ printStmt s ++ " }") else_branch
printStmt (While expr stmt          ) = "while (" ++ printExpr expr ++ ") {" ++ printStmt stmt ++ "}"
printStmt (Read var                 ) = "input(" ++ var ++ ");"
printStmt (Write expr               ) = "print(" ++ printExpr expr ++ ");"
printStmt (Assign var expr          ) = var ++ " = " ++ printExpr expr ++ ";"
printStmt (Seq stmts                ) = foldr (\stmt str -> printStmt stmt ++ "; " ++ str) "" stmts



printExpr :: Expr -> String
printExpr (Ident var) = var
printExpr (Num i) = show i
printExpr (BinOp op lhs rhs) = "(" ++ printExpr lhs ++ printOp op ++ " " ++ printExpr rhs ++ ")"

printOp :: Operator -> String
printOp Pow   = "**"
printOp Mult  = "*"
printOp Div   = "//"
printOp Plus  = "+"
printOp Minus = "-"
printOp Eq    = "=="
printOp Neq   = "!="
printOp Le    = "<="
printOp Lt    = "<"
printOp Ge    = ">="
printOp Gt    = ">"
