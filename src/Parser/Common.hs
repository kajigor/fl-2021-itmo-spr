module Parser.Common where

import Data.Char (isDigit, isAlpha)
import Parser.Combinators ( Parser, satisfy )
import Control.Applicative ( Alternative(..), liftA2 )

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

sepByOp :: Parser input op -> Parser input elem -> Parser input ([op], [elem])
sepByOp sep elem = do
  h <- elem
  t <- many (liftA2 (,) sep elem)
  return (map fst t, h : map snd t)

uberExpr :: [(Parser i op, Associativity)]
         -> Parser i ast
         -> (op -> ast -> ast -> ast)
         -> Parser i ast
uberExpr [] atom _ = atom
uberExpr ((op,LeftAssoc):ops) atom build = do
  (ops,atoms) <- sepByOp op (uberExpr ops atom build)
  let ini = head atoms
  let elems = tail atoms
  let fs = zipWith flip (map build ops) elems
  return $ foldl (flip (.)) id fs ini
uberExpr ((op,RightAssoc):ops) atom build = do
  (ops,atoms) <- sepByOp op (uberExpr ops atom build)
  let ini = last atoms
  let elems = init atoms
  let fs = zipWith ($) (map build ops) elems
  return $ foldr (.) id fs ini
uberExpr ((op,NoAssoc):ops) atom build = 
  let elem = uberExpr ops atom build in
  ( do
    lhs <- elem 
    o <- op 
    rhs <- elem 
    return $ build o lhs rhs
  ) <|>
  elem