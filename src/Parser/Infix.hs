{-# LANGUAGE LambdaCase #-}
module Parser.Infix where

import Control.Applicative (many, (<|>))
import Expr (Operator (..),  Expr (..), toOp )
import Parser.Combinators ( Parser, eof, whitespaces, parseEither, symbol, word, satisfy )
import Parser.Common (Associativity (..), uberExpr, alpha, digit, number)

parse :: String -> Either String Expr
parse =
  parseEither (whitespaces *> parseExpr <* whitespaces <* eof)

underlying :: Parser String Char
underlying = satisfy (== '_')

ident :: Parser String String
ident = let parseWithoutNum = underlying <|> alpha in (:) <$> parseWithoutNum <*> many (parseWithoutNum <|> digit)


mult'  = toOp <$> word "*"
sum'  = toOp <$> word "+"
minus' = toOp <$> word "-"
div'  = toOp <$> word "/"
pow'  = toOp <$> word "^"

eq' = toOp <$> word "=="
neq' = toOp <$> word "/="
le' = toOp <$> word "<="
lt' = toOp <$> word "<"
ge' = toOp <$> word ">="
gt' = toOp <$> word ">"

aroundWhitespaces p =  whitespaces *> p <* whitespaces

parseExpr :: Parser String Expr
parseExpr = uberExpr [
    (eq' <|> neq' <|> le' <|> lt' <|> ge' <|> gt', NoAssoc)
  , (minus' <|> sum', LeftAssoc)
  , (mult' <|> div', LeftAssoc)
  , (pow', RightAssoc)
  ]
  (aroundWhitespaces (pE <|> symbol '(' *> parseExpr <* symbol ')'))
  BinOp
  where
    pE = aroundWhitespaces (Num <$> number <|> Ident <$> ident)