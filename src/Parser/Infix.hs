{-# LANGUAGE LambdaCase #-}
module Parser.Infix where

import Parser.Combinators ( Parser, eof, whitespaces, parseEither,brackets, word, symbol )
import Expr ( Expr, Expr (..), Operator, toOp )
import Parser.Common ( number, alpha, digit, uberExpr, Associativity (..) )
import Control.Applicative (many, (<|>))

parse :: String -> Either String Expr
parse =
  parseEither (whitespaces *> parseExpr <* whitespaces <* eof)

--Запишем все операции с низшим приоритетом
eq' :: Parser String Operator
eq' = toOp <$> word "=="
neq' :: Parser String Operator
neq' = toOp <$> word "/="
lt' :: Parser String Operator
lt' = toOp <$> word "<"
le' :: Parser String Operator
le' = toOp <$> word "<="
gt' :: Parser String Operator
gt' = toOp <$> word ">"
ge' :: Parser String Operator
ge' = toOp <$> word ">="

lowPriorOp :: (Parser String Operator, Associativity)
lowPriorOp =  (eq' <|> neq' <|> le' <|> lt' <|> ge' <|> gt', NoAssoc)

--Запишем все операции со средним приоритетом
sum' :: Parser String Operator
sum' = toOp <$> word "+"
minus' :: Parser String Operator
minus' = toOp <$> word "-"

middlePriorOp :: (Parser String Operator, Associativity)
middlePriorOp = (sum' <|> minus', LeftAssoc)

--Запишем все операции с высшим приоритетом
mult' :: Parser String Operator
mult' = toOp <$> word "*"
div' :: Parser String Operator
div' = toOp <$> word "/"

highPriorOp :: (Parser String Operator, Associativity)
highPriorOp = (mult' <|> div', LeftAssoc)

--Запишем операцию самым высоким приоритетом
pow' :: Parser String Operator
pow' = toOp <$> word "^"

powOp :: (Parser String Operator, Associativity)
powOp = (pow', RightAssoc)

ident = (:) <$> (alpha <|> symbol '_') <*> many (alpha <|> digit <|> symbol '_')

parseExpr :: Parser String Expr
parseExpr = uberExpr [ lowPriorOp, middlePriorOp, highPriorOp, powOp](whitespaces *> e <* whitespaces) BinOp where
    e = Num <$> number <|> Ident <$> ident <|> brackets (symbol '(') (symbol ')') parseExpr 
