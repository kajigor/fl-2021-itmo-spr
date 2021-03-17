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

instance Show Operator where
    show Pow = "^"
    show Mult = "*"
    show Div = "/"
    show Plus = "+"
    show Minus = "-"
    show Eq = "=="
    show Neq = "!="
    show Le = "<="
    show Lt = "<"
    show Ge = ">="
    show Gt = ">"

-- Выражения (expressions)
data Expr = Ident Var                -- Идентификатор
          | Num Int                  -- Число
          | BinOp Operator Expr Expr -- Выражение с бинарным оператором

instance Show Expr where
    show (Ident var) = var
    show (Num x) = show x
    show (BinOp op expr1 expr2) = "(" ++ show expr1 ++ ")" ++ show op ++ "(" ++ show expr2 ++ ")"

-- Инструкции (statements)
data Stmt = Ignore Expr               -- Инструкция, которая является выражением (подразумевается, что значение выражения игнорируется)
          | If Expr Stmt (Maybe Stmt) -- Условное выражение. Первый операнд -- условие, второй -- ветка true, третий -- опциональная ветка else
          | While Expr Stmt           -- Цикл с предусловием. Первый операнд -- условие
          | Read Var                  -- Прочитать значение переменной
          | Write Expr                -- Напечатать значение выражения
          | Assign Var Expr           -- Присвоить значение выражения переменной
          | Seq [Stmt]                -- Последовательность инструкций

instance Show Stmt where
  show (Ignore expr) = show expr ++ ";\n"

  show (If expr trueBranch elseBranch) = "if (" ++ show expr ++ ") begin\n " ++ show trueBranch ++ " end\n" ++ (elseShow elseBranch)
    where elseShow Nothing = ""
          elseShow (Just stmt) = " else begin\n " ++ show stmt ++ " end\n"

  show (While expr stmt) = "while (" ++ show expr ++ ") begin\n " ++ show stmt ++ " end\n"
  show (Read var) = ">> " ++ var ++ ";\n"
  show (Write expr) = "<< " ++ show expr ++ ";\n"
  show (Assign var expr) = var ++ " = " ++ show expr ++ ";\n"

  show (Seq []) = ""
  show (Seq (x:xs)) = show x ++ show (Seq xs)

-- Абстрактное синтаксическое дерево программы
data Program = Program Stmt -- Программа является инструкцией

printer :: Program -> String
printer (Program s) = show s

-- Пример
readStmt = Read "a"

ifStmt = If condition (Seq [Assign "x" (Num 100)]) (Just (Seq [Assign "x" (BinOp Minus (Ident "x") (Num 100))]))
  where condition = BinOp Ge (Ident "x") (Num 10)

whileStmt = While condition (Seq [Write (Ident "x")])
  where condition = Num 1

stmtSeq = Seq [readStmt, ifStmt, whileStmt]

main = do
  putStr (printer $ Program stmtSeq)