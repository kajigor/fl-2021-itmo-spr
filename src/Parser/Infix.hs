module Parser.Infix where

import Lexer (Token (..), lexer)
import Parser.Common (parseOp, parseDigit, parserEof)
import Control.Applicative ((<|>))
import Data.Char (isDigit, digitToInt, isSpace)
import Expr (Expr (..), Operator (..))
import Text.Printf (printf)

parse :: String -> Maybe Expr
parse str = do
  tokens <- lexer str
  parserEof parseSum tokens 

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

parseBinOp :: Associativity -> Operator -> ([Token] -> Maybe ([Token], b)) -> ([Token] -> Maybe ([Token], Expr)) -> [Token] -> Maybe ([Token], Expr)
parseBinOp assoc op parseOp nextParser tokens = do
    (binOp assoc op <$>) <$> go tokens
  where
    go :: [Token] -> Maybe ([Token], [Expr])
    go str = do
      first@(t, e) <- nextParser str
      if null t
      then return (t, [e])
      else
        ( do
          (t', _) <- parseOp t
          let rest = go t'
          ((e:) <$>) <$> rest
        )
        <|>
        return (t, [e])



parseOp' :: Char -> [Token] -> Maybe ([Token], Operator)
parseOp' '+' ((Oper Plus): t) = Just (t, Plus)
parseOp' '*' ((Oper Mult): t) = Just (t, Mult)
parseOp' '^' ((Oper Pow): t) = Just (t, Pow)
parseOp' _ _ = Nothing

parseDigit' :: [Token] -> Maybe ([Token], Expr)
parseDigit' ((Number a): t) = Just (t, Num a)
parseDigit' _ = Nothing

parseSum :: [Token] -> Maybe ([Token], Expr)
parseSum = parseBinOp AssocL Plus (parseOp' '+') parseMult

parseMult :: [Token] -> Maybe ([Token], Expr)
parseMult = parseBinOp AssocL Mult (parseOp' '*') parsePow

parsePow :: [Token] -> Maybe ([Token], Expr)
parsePow = parseBinOp AssocR Pow (parseOp' '^') (\tokens -> parseDigit' tokens <|> parseExprBr tokens)

parseExprBr :: [Token] -> Maybe ([Token], Expr)
parseExprBr (Lbr : t) =
  case parseSum t of
    Just (Rbr : t', e) -> Just (t', e)
    _ -> Nothing
parseExprBr _ = Nothing

