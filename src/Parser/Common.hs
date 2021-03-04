module Parser.Common where

import Data.Char (isDigit, isAlpha)
import Parser.Combinators ( Parser, satisfy )
import Control.Applicative (some, many, (<|>))

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

uberExpr [] elemParser f = elemParser

uberExpr ((parser, NoAssoc):ps) elemParser f = parse <|> nextParser
    where nextParser = uberExpr ps elemParser f
          parse = do
            left <- nextParser
            x <- parser
            right <- nextParser
            return (f x left right)

uberExpr ((parser, LeftAssoc):ps) elemParser f = 
    let nextParser = uberExpr ps elemParser f in 
    do
      (ps, sepElems) <- sepBy'' parser nextParser
      let e:es = sepElems
      let rest = zipWith flip (map f ps) es
      return (foldl(\ l r -> r l) e rest)

uberExpr ((parser, RightAssoc):ps) elemParser f = 
    let nextParser = uberExpr ps elemParser f in 
    do
      (ps, sepElems) <- sepBy'' parser nextParser
      let e:es = reverse sepElems
      let rest = zipWith ($) (map f ps) (reverse es)
      return (foldr ($) e rest)


sepBy'' :: Parser input op -> Parser input elem -> Parser input ([op], [elem])
sepBy'' op elem = do
  h <- elem
  t <- many ( (,) <$> op <*> elem)
  return (map fst t, h : map snd t)
