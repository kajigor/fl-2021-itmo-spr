{-# LANGUAGE LambdaCase #-}
module Parser.Infix where

import Control.Applicative ((<|>), many)
import Parser.Combinators ( Parser, eof, whitespaces, parseEither, word, symbol )
import Parser.Common ( Associativity (..), uberExpr, number, alpha, digit )
import Expr ( Operator(..), Expr (..), toOp )

parse :: String -> Either String Expr
parse =
  parseEither (whitespaces *> parseExpr <* whitespaces <* eof)

mult, sum', minus, div', pow :: Parser String Operator
mult  = toOp <$> word "*"
sum'  = toOp <$> word "+"
minus = toOp <$> word "-"
div'  = toOp <$> word "/"
pow   = toOp <$> word "^"

eq', neq, ge, gt, le, lt :: Parser String Operator
eq'   = toOp <$> word "=="
neq   = toOp <$> word "/="
ge    = toOp <$> word ">="
gt    = toOp <$> word ">"
le    = toOp <$> word "<="
lt    = toOp <$> word "<"

ident :: Parser String String
ident = do
  first <- alpha <|> symbol '_'
  rest <- many (alpha <|> digit <|> symbol '_')
  return (first : rest)

parseExpr :: Parser String Expr
parseExpr = 
  uberExpr [ (eq' <|> neq <|> ge <|> gt <|> le <|> lt, NoAssoc)
           , (sum' <|> minus, LeftAssoc)
           , (mult <|> div', LeftAssoc)
           , (pow, RightAssoc)
           ]
           ( whitespaces *> 
             (
                 Num <$> number
             <|> Ident <$> ident
             <|> symbol '(' *> parseExpr <* symbol ')'
             ) 
             <* whitespaces
           )
           BinOp