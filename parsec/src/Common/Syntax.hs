module Common.Syntax where
    
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
              deriving (Show, Eq)

-- Выражения (expressions)
data Expr = Ident Var                -- Идентификатор
          | Num Int                  -- Число
          | BinOp Operator Expr Expr -- Выражение с бинарным оператором
          deriving (Show, Eq)

-- Инструкции (statements)
data Stmt = Ignore Expr               -- Инструкция, которая является выражением (подразумевается, что значение выражения игнорируется)
          | If Expr Stmt (Maybe Stmt) -- Условное выражение. Первый операнд -- условие, второй -- ветка true, третий -- опциональная ветка else
          | While Expr Stmt           -- Цикл с предусловием. Первый операнд -- условие
          | Read Var                  -- Прочитать значение переменной
          | Write Expr                -- Напечатать значение выражения
          | Assign Var Expr           -- Присвоить значение выражения переменной
          | Seq [Stmt]                -- Последовательность инструкций
          deriving (Show, Eq)

-- Абстрактное синтаксическое дерево программы
data Program = Program Stmt deriving (Show, Eq) -- Программа является инструкцией
