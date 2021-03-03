{-# LANGUAGE LambdaCase #-}
module Parser.Infix where

import Expr ( Expr(..), toOp )
import Parser.Combinators ( Parser, eof, whitespaces, parseEither, word, symbol )
import Parser.Common (uberExpr, number, Associativity (LeftAssoc, RightAssoc, NoAssoc), identifier)
import Control.Applicative ( Alternative((<|>)) )


le = toOp <$> word "<="
lt = toOp <$> word "<"
ge = toOp <$> word ">="
gt = toOp <$> word ">"
eq = toOp <$> word "=="
ne = toOp <$> word "/="
sum'  = toOp <$> word "+"
minus = toOp <$> word "-"
mult  = toOp <$> word "*"
div'  = toOp <$> word "/"
pow = toOp <$> word "^"

parse :: String -> Either String Expr
parse =
  parseEither (whitespaces *> parseExpr <* whitespaces <* eof)

parseExpr :: Parser String Expr
parseExpr = uberExpr [
  (le <|> lt <|> eq <|> ge <|> gt <|> ne, NoAssoc),
  (sum' <|> minus, LeftAssoc),
  (mult <|> div', LeftAssoc),
  (pow, RightAssoc)]
  (whitespaces  *> ((Ident <$> identifier ) <|> (Num <$> number <|> symbol '(' *> parseExpr <* symbol ')')) <* whitespaces ) BinOp
