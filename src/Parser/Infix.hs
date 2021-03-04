{-# LANGUAGE LambdaCase #-}
module Parser.Infix where

import Expr ( Expr(..), Operator, toOp )
import Parser.Combinators
import Parser.Common
import Control.Applicative (many, (<|>))

parse :: String -> Either String Expr
parse =
  parseEither (whitespaces *> parseExpr <* whitespaces <* eof)

parseSum :: Parser String Operator
parseSum = toOp <$> word "+"

parseSub :: Parser String Operator
parseSub = toOp <$> word "-"

parseMul :: Parser String Operator
parseMul = toOp <$> word "*"

parseDiv :: Parser String Operator
parseDiv = toOp <$> word "/"

parsePow :: Parser String Operator
parsePow = toOp <$> word "^"

parseComp :: Parser String Operator
parseComp = toOp <$> word ">=" <|> toOp <$> word "<=" <|> toOp <$> word ">" <|> toOp <$> word "<" <|> toOp <$> word "==" <|> toOp <$> word "/=" 

ident :: Parser String String
ident = do
  first <- alpha <|> symbol '_'
  rest <- many (alpha <|> digit <|> symbol '_')
  return (first : rest)

parseExprHelper = whitespaces *> 
                  (Num <$> number <|> Ident <$> ident <|> symbol '(' *> parseExpr <* symbol ')') 
                  <* whitespaces

parseExpr :: Parser String Expr
parseExpr = uberExpr [(parseComp, NoAssoc), (parseSum <|> parseSub, LeftAssoc), 
                      (parseMul <|> parseDiv, LeftAssoc), (parsePow, RightAssoc)]
                      (parseExprHelper) BinOp