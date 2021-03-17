module LParser.AstStmt where

-- Имена переменных
type Var = String

data Operator
  = Pow -- Возведение в степень
  | Mult -- Умножение
  | Div -- Деление (с остатком)
  | Plus -- Сложение
  | Minus -- Вычитание
  | Eq -- Сравнение на равенство
  | Neq -- Сравнение на неравенство
  | Le -- Меньше или равно
  | Lt -- Меньше
  | Ge -- Больше или равно
  | Gt -- Больше
  deriving (Eq)

-- Выражения (expressions)
data Expr
  = Ident Var -- Идентификатор
  | Num Int -- Число
  | BinOp Operator Expr Expr -- Выражение с бинарным оператором
  deriving (Eq)

-- Инструкции (statements)
data Stmt
  = Ignore Expr -- Инструкция, которая является выражением (подразумевается, что значение выражения игнорируется)
  | If Expr Stmt (Maybe Stmt) -- Условное выражение. Первый операнд -- условие, второй -- ветка true, третий -- опциональная ветка else
  | While Expr Stmt -- Цикл с предусловием. Первый операнд -- условие
  | Read Var -- Прочитать значение переменной
  | Write Expr -- Напечатать значение выражения
  | Assign Var Expr -- Присвоить значение выражения переменной
  | Seq [Stmt] -- Последовательность инструкций
  | Decl Var
  deriving (Eq)

-- Абстрактное синтаксическое дерево программы
data Program = Program Stmt -- Программа является инструкцией
  deriving (Eq)

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

instance Show Expr where
  show (Ident var) = var
  show (Num x) = show x
  show (BinOp op e1 e2) = "(" ++ show e1 ++ ")" ++ show op ++ "(" ++ show e2 ++ ")"

instance Show Stmt where
  show (Ignore expr) = show expr ++ ";\n"
  show (If cond truBlock flsBlock) =
    "if (" ++ show cond ++ ") {\n" ++ show truBlock ++ "}" ++ case flsBlock of
      Nothing -> "\n"
      (Just flsStmt) -> " else {\n" ++ show flsStmt ++ "}\n"
  show (While cond block) = "while (" ++ show cond ++ ") {\n" ++ show block ++ "}\n"
  show (Read var) = "read(" ++ var ++ ");\n"
  show (Write expr) = "print(" ++ show expr ++ ");\n"
  show (Assign var expr) = var ++ " = " ++ show expr ++ ";\n"
  show (Seq []) = ""
  show (Seq (x : xs)) = show x ++ show (Seq xs)
  show (Decl var) = "var " ++ var ++ ";\n"

printer :: Program -> String
printer (Program prog) = show prog

instance Show Program where
  show = printer