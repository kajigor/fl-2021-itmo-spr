{-# LANGUAGE LambdaCase #-}
module Parser.Infix where

import Control.Applicative (many, (<|>))
import Expr (Expr (..), Operator, toOp)
import Parser.Combinators (Parser, eof, parseEither, symbol, whitespaces, word)
import Parser.Common (Associativity (..), alpha, digit, number, uberExpr)

mult :: Parser String Operator
mult = toOp <$> word "*"

div' :: Parser String Operator
div' = toOp <$> word "/"

plus :: Parser String Operator
plus = toOp <$> word "+"

minus :: Parser String Operator
minus = toOp <$> word "-"

pow :: Parser String Operator
pow = toOp <$> word "^"

eq :: Parser String Operator
eq = toOp <$> word "=="

neq' :: Parser String Operator
neq' = toOp <$> word "/="

less :: Parser String Operator
less = toOp <$> word "<"

more :: Parser String Operator
more = toOp <$> word ">"

leq :: Parser String Operator
leq = toOp <$> word "<="

geq :: Parser String Operator
geq = toOp <$> word ">="

ident = do
  head <- alpha <|> symbol '_'
  tail <- many (alpha <|> digit <|> symbol '_')
  return (head : tail)

parse :: String -> Either String Expr
parse =
  parseEither (whitespaces *> parseExpr <* whitespaces <* eof)

put = Num <$> number <|> Ident <$> ident <|> symbol '(' *> parseExpr <* symbol ')'

parseExpr :: Parser String Expr
parseExpr =
  uberExpr
    [(eq <|> neq' <|> leq <|> less <|> geq <|> more, NoAssoc), (plus <|> minus, LeftAssoc), (mult <|> div', LeftAssoc), (pow, RightAssoc)]
    (whitespaces *> put <* whitespaces)
    BinOp