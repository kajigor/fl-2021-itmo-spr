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
    show Pow = "**"
    show Mult = "*"
    show Div = "/"
    show Plus = "+"
    show Minus = "-"
    show Eq = "=="
    show Neq = "^="
    show Le = "<="
    show Lt = "<"
    show Ge = ">="
    show Gt = ">"

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

instance Show Stmt where
    show (Ignore x) = show x ++ ";\n"

    show (If cond t f) = "if(" ++ show cond ++ "){\n" ++ show t ++"\n}" ++ case f of
        Nothing -> ""
        Just altbody -> "else{\n" ++ show altbody ++ "\n}" 

    show (While cond body) = "while(" ++ show cond ++ "){\n" ++ show body ++"\n}"  

    show (Read v) = "input(" ++ v ++ ");\n" 
    show (Write e) = " print(" ++ show e ++ ");\n"

    show (Assign param exp) = "auto " ++ param ++ " = " ++ show exp ++ ";\n"

    show (Seq (x:rest)) = show x ++ "\n" ++ show (Seq rest)
    show (Seq []) = ""

instance Show Expr where
    show (Ident v) = v
    show (Num i) = show i
    show (BinOp op e1 e2) = "(" ++ show e1 ++ show op ++ show e2 ++ ")"

-- Абстрактное синтаксическое дерево программы
data Program = Program Stmt -- Программа является инструкцией


instance Show Program where
    show (Program stmt) = show stmt

printer :: Program -> String
printer = show