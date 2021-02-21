module Parser.Infix where

import Parser.Common (parserEof)
import Control.Applicative ((<|>))
import Expr (Expr (..), Operator (..))
import Lexer (Token (..), lexer)

parse :: String -> Maybe Expr
parse = parserEof parseInfix

-- Expr :: Expr + Expr
--       | Expr * Expr
--       | Expr ^ Expr
--       | Digit
--       | ( Expr )

-- Expr :: Слаг + Слаг + ... + Слаг
--       = Слаг (+ Слаг) (+ Слаг) .. (+ Слаг)
--       -> [Слаг] - fold ... -> BinOp Plus (BinOp Plus ...)...
-- Слаг :: Множ * Множ * ... * Множ
-- Множ :: Фактор ^ Фактор ^ ... ^ Фактор
-- Фактор :: Цифра | ( Expr )
-- [1,2,3] -> (1+2)+3

data Associativity = AssocL | AssocR

binOp :: Associativity -> Operator -> [Expr] -> Expr
binOp AssocL op = foldl1 (BinOp op)
binOp AssocR op = foldr1 (BinOp op)

parseBinOp :: Associativity -> Operator -> ([Token] -> Maybe ([Token], Expr)) -> [Token] -> Maybe ([Token], Expr)
parseBinOp assoc op nextParser tokens =
    (binOp assoc op <$>) <$> go op tokens
  where
    go :: Operator -> [Token] -> Maybe ([Token], [Expr])
    go op tokens = do
      first@(t, e) <- nextParser tokens
      if null t
      then return (t, [e])
      else
        ( do
          (Oper op':t') <- Just t
          True <- Just $ op' == op
          let rest = go op t'
          ((e:) <$>) <$> rest
        )
        <|>
        return (t, [e])

parseSum :: [Token] -> Maybe ([Token], Expr)
parseSum = parseBinOp AssocL Plus parseMult

parseMult :: [Token] -> Maybe ([Token], Expr)
parseMult = parseBinOp AssocL Mult parsePow

parsePow :: [Token] -> Maybe ([Token], Expr)
parsePow = parseBinOp AssocR Pow (\t -> parseNum t <|> parseExprBr t)

parseNum :: [Token] -> Maybe ([Token], Expr)
parseNum (Number number : t) = return (t, Num number)
parseNum _ = Nothing

parseExprBr :: [Token] -> Maybe ([Token], Expr)
parseExprBr (Lbr : t) = do 
  (Rbr : t', e) <- parseSum t
  return (t', e)
parseExprBr _ = Nothing

parseInfix :: String -> Maybe ([Token], Expr)
parseInfix str = do
  tokens <- lexer str
  parseSum tokens