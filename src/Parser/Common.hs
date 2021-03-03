module Parser.Common where

import Data.Char (isDigit, isAlpha)
import Parser.Combinators ( Parser, satisfy, sepByWithInfo1)
import Control.Applicative (some)

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

uberExpr :: [(Parser i op, Associativity)]
         -> Parser i ast
         -> (op -> ast -> ast -> ast)
         -> Parser i ast 
uberExpr ps init func = foldr (foldParser func) init ps
    

foldParser :: (op -> ast -> ast -> ast) -> (Parser i op, Associativity) -> Parser i ast -> Parser i ast
foldParser func (p1,assoc) p2 = case assoc of
  LeftAssoc  -> do 
                  (op,tokens) <- sepByWithInfo1 p1 p2
                  return $ foldl1 (func op) tokens
  RightAssoc -> do 
                  (op,tokens) <- sepByWithInfo1 p1 p2
                  return $ foldr1 (func op) tokens
  NoAssoc    -> do
                  (op,tokens) <- sepByWithInfo1 p1 p2
                  if length tokens >= 2
                  then return $ func op (tokens !! 0) (tokens !! 1)
                  else return $ head tokens
