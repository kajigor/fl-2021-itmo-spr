module Parser.Common where

import Data.Char (isDigit, isAlpha)
import Parser.Combinators ( Parser, satisfy, sepByWithInfo1)
import Control.Applicative (some)
import Control.Applicative ((<|>))

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
uberExpr ps init func = foldr (foldParsers func) init ps

foldParsers :: (op -> ast -> ast -> ast) -> (Parser i op, Associativity) -> Parser i ast -> Parser i ast
foldParsers func (p1,assoc) p2 = case assoc of
  LeftAssoc  -> do 
                  (h,t) <- sepByWithInfo1 p1 p2
                  return $ foldlTokens func h t
  RightAssoc -> do 
                  (h,t) <- sepByWithInfo1 p1 p2
                  return $ foldrTokens func h t
  NoAssoc    -> do
                  operand1 <- p2
                  ( do 
                      operator <- p1
                      operand2 <- p2
                      return $ func operator operand1 operand2
                      ) 
                      <|> return operand1

foldlTokens :: (op -> ast -> ast -> ast) -> ast -> [(op, ast)] -> ast
foldlTokens func x xs = foldl (\y (op,z) -> func op y z) x xs

foldrTokens :: (op -> ast -> ast -> ast) -> ast-> [(op, ast)] -> ast
foldrTokens func ini xs = 
  let r = foldr mf Nothing xs
      mf x m = Just (case m of
                       Nothing -> x
                       Just (op,y) -> (fst x,func op (snd x) y))
  in case r of
    Nothing -> ini
    Just (op',res) -> func op' ini res
