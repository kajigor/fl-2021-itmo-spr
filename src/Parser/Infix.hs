{-# LANGUAGE LambdaCase #-}
module Parser.Infix where

import Expr ( Expr(..), Operator, toOp ) 
import Parser.Combinators ( Parser, eof, whitespaces, parseEither, word, symbol )
import Parser.Common
    ( Associativity(RightAssoc, NoAssoc, LeftAssoc),
      number,
      uberExpr,
      varName )
import Control.Applicative (Alternative((<|>)))

parse :: String -> Either String Expr
parse =
  parseEither (whitespaces *> parseExpr <* whitespaces <* eof)

parseCompare :: Parser String Operator
parseCompare = toOp <$> word "==" <|> toOp <$> word "/=" <|> toOp <$> word "<=" <|> toOp <$> word "<" <|> toOp <$> word ">=" <|> toOp <$> word ">"

parsePM :: Parser String Operator
parsePM = toOp <$> word "+" <|> toOp <$> word "-"

parseMD :: Parser String Operator
parseMD = toOp <$> word "*" <|> toOp <$> word "/"

parseP :: Parser String Operator
parseP = toOp <$> word "^"

parseDefault :: Parser String Expr
parseDefault = Ident <$> varName <|> Num <$> number <|> symbol '(' *> parseExpr <* symbol ')'

parserWhitespaces :: Parser String a -> Parser String a
parserWhitespaces parser = whitespaces *> parser <* whitespaces

parseExpr :: Parser String Expr
parseExpr = uberExpr [ 
  (parserWhitespaces parseCompare, NoAssoc),
  (parserWhitespaces parsePM, LeftAssoc),
  (parserWhitespaces parseMD, LeftAssoc),
  (parserWhitespaces parseP, RightAssoc)]
  (parserWhitespaces parseDefault)
  BinOp