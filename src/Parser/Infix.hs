{-# LANGUAGE LambdaCase #-}
module Parser.Infix where

import Expr (Operator (..), Expr (..), toOp)
import Parser.Combinators ( Parser, eof, whitespaces, parseEither, word, symbol)
import Parser.Common (Associativity (..), uberExpr, number, alpha, digit)
import Control.Applicative ( Alternative(..))

parse :: String -> Either String Expr
parse =
  parseEither (whitespaces *> parseExpr <* whitespaces <* eof)

parseExpr :: Parser String Expr
parseExpr = uberExpr parseList 
  (whitespaces *> 
    (Num <$> number <|> Ident <$> parserIdent <|> symbol '(' *> parseExpr <* symbol ')') 
      <* whitespaces) BinOp

parserPow = toOp <$> word "^"
parserMult = toOp <$> word "*"
parserDiv = toOp <$> word "/"
parserSum = toOp <$> word "+"
parserMinus = toOp <$> word "-"
parserEq = toOp <$> word "=="
parserNeq = toOp <$> word "/="
parserLeq = toOp <$> word "<="
parserLe = toOp <$> word "<"
parserGeq = toOp <$> word ">="
parserGe = toOp <$> word ">"

parseList :: [(Parser String Operator, Associativity)]
parseList =
        [ (parserEq <|> parserNeq <|> parserLeq 
            <|> parserLe <|> parserGeq <|> parserGe, NoAssoc)
        , (parserSum <|> parserMinus, LeftAssoc)
        , (parserMult <|> parserDiv, LeftAssoc)
        , (parserPow, RightAssoc)
        ]

parserIdent :: Parser String String
parserIdent = do
  h <- alpha <|> symbol '_'
  t <- many (digit <|> alpha <|> symbol '_')
  return (h:t)

