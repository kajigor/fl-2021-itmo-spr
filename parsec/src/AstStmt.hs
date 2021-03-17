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
  show Pow   = "^"
  show Mult  = "*"
  show Div   = "%"
  show Plus  = "+"
  show Minus = "-"
  show Le    = "<~"
  show Lt    = "<"
  show Ge    = "~>"
  show Gt    = ">"
  show Eq    = "~"
  show Neq   = "!"

precedence :: Operator -> Int 
precedence Pow   = 8 
precedence Mult  = 7 
precedence Div   = 7 
precedence Plus  = 6
precedence Minus = 6
precedence Le    = 5
precedence Lt    = 5
precedence Ge    = 5
precedence Gt    = 5
precedence Eq    = 4
precedence Neq   = 4

-- Выражения (expressions)
data Expr = Ident Var                -- Идентификатор
          | Num Int                  -- Число
          | BinOp Operator Expr Expr -- Выражение с бинарным оператором

instance Show Expr where
  showsPrec _ (Ident var) = showString var
  showsPrec _ (Num num) = shows num
  showsPrec p (BinOp op lhs rhs) = 
    let prec = precedence op 
    in showParen (p > prec) $ showsPrec prec lhs . 
                              showChar ' ' .
                              shows op . 
                              showChar ' ' .
                              showsPrec prec rhs

-- Инструкции (statements)
data Stmt = Ignore Expr               -- Инструкция, которая является выражением (подразумевается, что значение выражения игнорируется)
          | If Expr Stmt (Maybe Stmt) -- Условное выражение. Первый операнд -- условие, второй -- ветка true, третий -- опциональная ветка else
          | While Expr Stmt           -- Цикл с предусловием. Первый операнд -- условие
          | Read Var                  -- Прочитать значение переменной
          | Write Expr                -- Напечатать значение выражения
          | Assign Var Expr           -- Присвоить значение выражения переменной
          | Seq [Stmt]                -- Последовательность инструкций

instance Show Stmt where
  showsPrec _ (Ignore expr) = showsPrec 0 expr
  showsPrec _ (If expr stmt Nothing) = showString "? " . 
                                       showsPrec 0 expr . 
                                       showString " {\n" .
                                       showsPrec 0 stmt .
                                       showString "\n} "
  showsPrec _ (If expr stmtT (Just stmtF)) = showString "? " . 
                                             showsPrec 0 expr . 
                                             showString " {\n" .
                                             showsPrec 0 stmtT .
                                             showString "\n} : {\n" .
                                             showsPrec 0 stmtF .
                                             showString "\n} "
  showsPrec _ (While expr stmt) = showString "@ " .
                                  showsPrec 0 expr .
                                  showString " {\n" .
                                  showsPrec 0 stmt .
                                  showString "\n}"
  showsPrec _ (Read var) = showString ">> " . 
                           showString var
  showsPrec _ (Write expr) = showString "<< " . 
                             showsPrec 0 expr
  showsPrec _ (Assign var expr) = showString var . 
                                  showString " { " . 
                                  showsPrec 0 expr .
                                  showString " }"
  showsPrec _ (Seq []) = id
  showsPrec _ (Seq (stmt:[])) = showsPrec 0 stmt
  showsPrec _ (Seq (stmt:stmts)) = showsPrec 0 stmt . 
                                   showChar '\n' . 
                                   showsPrec 0 (Seq stmts)

-- Абстрактное синтаксическое дерево программы
data Program = Program Stmt -- Программа является инструкцией

instance Show Program where
  showsPrec _ (Program stmt) = shows stmt . showChar '\n'

printer :: Program -> String
printer = show


-- Примеры программ для тестирования
program1 = Program $ Seq []
program2 = Program $ Ignore $ Num 100
program3 = Program $ Seq [ Read "x", While (BinOp Le (Ident "x") (Num 42)) $ Seq [Write (Ident "x"), Assign "x" (BinOp Plus (Ident "x") (Num 1))] ]
program4 = Program $ If (BinOp Neq (Num 0) (Num 1)) (Write (Ident "123ok")) (Just (Write (Ident "SOS")))