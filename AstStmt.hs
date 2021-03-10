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
    show (BinOp op e1 e2) = "(" ++ show e1 ++ ")" ++ show op ++ "(" ++ show e2 ++ ")"

-- Инструкции (statements)
data Stmt = Ignore Expr               -- Инструкция, которая является выражением (подразумевается, что значение выражения игнорируется)
          | If Expr Stmt (Maybe Stmt) -- Условное выражение. Первый операнд -- условие, второй -- ветка true, третий -- опциональная ветка else
          | While Expr Stmt           -- Цикл с предусловием. Первый операнд -- условие
          | Read Var                  -- Прочитать значение переменной
          | Write Expr                -- Напечатать значение выражения
          | Assign Var Expr           -- Присвоить значение выражения переменной
          | Seq [Stmt]                -- Последовательность инструкций
          | Decl Var
instance Show Stmt where
  show (Ignore expr) = show expr ++ ";\n"
  show (If cond truBlock flsBlock) = "if (" ++ show cond ++ ") {\n" ++ show truBlock ++ "}" ++ case flsBlock of Nothing -> "\n"
                                                                                                                (Just flsStmt) -> " else {\n" ++ show flsStmt ++ "}\n"
  show (While cond block) = "while (" ++ show cond ++ ") {\n" ++ show block ++ "}\n"
  show (Read var) = "read(" ++ var  ++ ");\n"
  show (Write expr) = "print(" ++ show expr ++ ");\n"
  show (Assign var expr) = var ++ " = " ++ show expr ++ ";\n"
  show (Seq []) = ""
  show (Seq (x:xs)) = show x ++ show (Seq xs)
  show (Decl var) = "var " ++ var ++ ";\n"

-- Абстрактное синтаксическое дерево программы
data Program = Program Stmt -- Программа является инструкцией

printer :: Program -> String
printer (Program prog) = show prog

opPlus3And3 = BinOp Plus (Num 2) (Num 3)
stmtDecl = Decl "x"
stmtRead = Read "x"
stmtAssign = Assign "x" (Num 100)
stmtIf = If (Ident "x") (Seq [(Ignore (Num 66)), Ignore opPlus3And3]) Nothing
stmtWhile = While (Num 1) (Write $ Ident "x")
stmtIfElse = If (Ident "x") (Ignore (Num 66)) $ Just stmtWhile
stmtSeq = Seq [stmtDecl, stmtAssign, stmtRead, stmtIf, stmtIfElse]

prog = Program stmtSeq

main = do
  putStr $ printer prog