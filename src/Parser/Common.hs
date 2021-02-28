{-# LANGUAGE RankNTypes #-}
module Parser.Common where

import Data.Char (isDigit, isAlpha, isAlphaNum)
import Parser.Combinators ( Parser, satisfy ) 
import Control.Applicative (some, Alternative((<|>), many))

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

-- number :: not empty, consists of digits
varName :: Parser String String
varName = do
  firstLetter <- alpha
  otherPart <- many $ satisfy (\char -> isAlphaNum char || char == '_')
  return $ firstLetter : otherPart

data Associativity = LeftAssoc  -- x `op` y `op` z == (x `op` y) `op` z
                   | RightAssoc -- x `op` y `op` z == x `op` (y `op` z)
                   | NoAssoc    -- non associative operation:
                                -- x `op` y -- ok
                                -- x `op` y `op` z -- not ok

uberExpr :: [(Parser i op, Associativity)]
         -> Parser i ast
         -> (op -> ast -> ast -> ast)
         -> Parser i ast
uberExpr [] parser _ = parser
uberExpr ((parser, assoc) : xs) defPars func = case assoc of 
  NoAssoc -> flip func <$> subParser <*> parser <*> subParser <|> subParser 
  LeftAssoc -> 
    do 
      (applyValue <$>) $ fmap (,) subParser <*> many (fmap (flip . func) parser <*> subParser)
  RightAssoc ->
    do 
      (applyValue <$>) $ fmap (\(s, a) -> (a, reverse s)) $ fmap (,) (many $fmap (flip func) subParser <*> parser) <*> subParser
  where 
    subParser = uberExpr xs defPars func
    applyValue (start, arr) = foldl (\l f -> f l) start arr
