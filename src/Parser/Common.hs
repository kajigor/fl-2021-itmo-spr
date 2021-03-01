module Parser.Common where

import Data.Char (isDigit, isAlpha)
import Parser.Combinators ( Parser (..), Result (..), satisfy, runParser, eof, sepBy )
import Control.Applicative (some, many, Alternative((<|>)) )

digit :: Parser String Char
digit = satisfy isDigit

digit' :: Parser String Char
digit' = satisfy (\x -> isDigit x && x /= '0')

alpha :: Parser String Char
alpha = satisfy isAlpha

-- number :: not empty, consists of digits
number :: Parser String Int
number = do
  num <- some digit
  return $ (read num :: Int)

data Associativity = LeftAssoc  -- x `op` y `op` z == (x `op` y) `op` z
                   | RightAssoc -- x `op` y `op` z == x `op` (y `op` z)
                   | NoAssoc    -- non associative operation:
                                -- x `op` y -- ok
                                -- x `op` y `op` z -- not ok
{-
uberExpr :: [(Parser i op, Associativity)]  -- список парсеров бинарных операторов с ассоциативностями в порядке повышения приоритета
         -> Parser i ast -- парсер для элементарного выражения
         -> (op -> ast -> ast -> ast) -- функция для создания абстрактного синтаксического дерева для бинарного оператора.
         -> Parser i ast -- результирующий парсер
uberExpr ((opPr, assoc): ps) exprPr fOp = do
    exprs <- sepBy opPr exprPr
    let 
      ff = \x
      resExpr = case assoc of
        LeftAssoc -> foldl1 fOp
        RightAssoc -> foldr1 fOp
        NoAssoc -> foldl1 fOp -- todo
-}

-- binOp :: Associativity -> Operator -> [Expr] -> Expr
helper'' LeftAssoc fOp op  = foldl1 (fOp op)
helper'' RightAssoc fOp op = foldr1 (fOp op)
helper'' NoAssoc fOp op = foldr1 (fOp op)

uberExpr :: [(Parser i op, Associativity)]  -- список парсеров бинарных операторов с ассоциативностями в порядке повышения приоритета
         -> Parser i ast -- парсер для элементарного выражения
         -> (op -> ast -> ast -> ast) -- функция для создания абстрактного синтаксического дерева для бинарного оператора.
         -> Parser i ast -- результирующий парсер
uberExpr [] exprPr f = exprPr


uberExpr ((parseOp, assoc): ps) exprPr fOp = do
  tmp <|> do {nextParser}
    where
      nextParser = uberExpr ps exprPr fOp
      tmp = do
        expr1 <- nextParser
        case assoc of
            NoAssoc -> do
              op <- parseOp
              expr2 <- nextParser
              return $ fOp op expr1 expr2 
            _ -> do
              op_expr <- some ((,) <$> parseOp <*> nextParser)
              case assoc of
                LeftAssoc -> return $ foldl (\xx el -> fOp (fst el) xx (snd el)) expr1 op_expr
                RightAssoc -> return $ helper expr1 op_expr
                  where
                    helper e [] = e
                    helper e1 ((op, e2): o_es) = fOp op e1 (helper e2 o_es)
