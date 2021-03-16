module LangParser.AstStmt where
import qualified Data.Map as Map

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
              | Or    -- Или
              | And   -- И
              deriving (Eq)

-- Выражения (expressions)
data Expr = Ident Var                -- Идентификатор
          | Num Int                  -- Число
          | BinOp Operator Expr Expr -- Выражение с бинарным оператором
          deriving (Eq)

-- Инструкции (statements)
data Stmt = Ignore Expr               -- Инструкция, которая является выражением (подразумевается, что значение выражения игнорируется)
          | If Expr Stmt (Maybe Stmt) -- Условное выражение. Первый операнд -- условие, второй -- ветка true, третий -- опциональная ветка else
          | While Expr Stmt           -- Цикл с предусловием. Первый операнд -- условие
          | Read Var                  -- Прочитать значение переменной
          | Write Expr                -- Напечатать значение выражения
          | Assign Var Expr           -- Присвоить значение выражения переменной
          | Seq [Stmt]                -- Последовательность инструкций
          deriving (Eq)

-- Абстрактное синтаксическое дерево программы
newtype Program = Program Stmt -- Программа является инструкцией
    deriving (Eq)


stringToOperator = Map.fromList  [
    ("^",  Pow  ),
    ("*",  Mult ),
    ("/",  Div  ),
    ("+",  Plus ),
    ("-",  Minus),
    ("==", Eq   ),
    ("!=", Neq  ),
    ("<=", Le   ),
    ("<",  Lt   ),
    (">=", Ge   ),
    (">",  Gt   ),
    ("||", Or   ),
    ("&&",  And   )]

instance Show Operator where
    show Pow   = "^"
    show Mult  = "*"
    show Div   = "/"
    show Plus  = "+"
    show Minus = "-"
    show Eq    = "=="
    show Neq   = "!="
    show Le    = "<="
    show Lt    = "<"
    show Ge    = ">="
    show Gt    = ">"
    show Or    = "||"
    show And    = "&&"
    

instance Show Expr where
    show (Ident a) = a
    show (Num a) = if a < 0 then "(" ++ show a ++ ")" else show a
    show (BinOp op e1 e2) = "(" ++ show e1 ++ " " ++ show op ++ " " ++ show e2 ++ ")"


increaseTab :: String -> String
increaseTab tab = if null tab then "  " else tab ++ "  "

showWithTab :: String -> Stmt -> String
showWithTab tab (If con st1 st2) = tab ++ "if ( " ++ show con ++ " ) " ++ "{\n" ++ showWithTab (increaseTab tab) st1 ++ "\n" ++ tab ++ "} else {\n" ++ showSt2 ++ "\n" ++ tab ++ "}" where
    showSt2 = case st2 of 
        Just v -> showWithTab (increaseTab tab) v
        Nothing -> ""

showWithTab tab (While con st) = tab ++ "loop ( " ++ show con ++ " ) " ++ "{\n" ++ showWithTab (increaseTab tab) st ++ "\n" ++ tab ++ "}"
showWithTab tab (Assign ident exp) = tab ++ ident ++ " := " ++ show exp ++ ";"
showWithTab tab (Read ident) = tab ++ "in " ++ ident ++ ";"
showWithTab tab (Write exp) = tab ++ "out " ++ show exp ++ ";"
showWithTab tab (Seq x) = unlines $ map (showWithTab tab) x

instance Show Stmt where
    show st = showWithTab "" st

instance Show Program where
    show (Program st) = show st


printer :: Program -> String
printer = show