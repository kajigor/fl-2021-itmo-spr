module Parser.Infix where

import Parser.Common (parseOp, parseDigit, parserEof)
import Control.Applicative ((<|>))
import Data.Char (isDigit, digitToInt, isSpace)
import Expr (Expr (..), Operator (..))
import Text.Printf (printf)
import Lexer (Token (..), lexer)

parseOld :: String -> Maybe Expr
parseOld = parserEof parseSum

parse :: String -> Maybe Expr
parse str = do
  tokens <- lexer str
  ([], expr) <- parseSumTokens tokens
  return expr

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

parseBinOp :: Associativity -> Operator -> (String -> Maybe (String, b)) -> (String -> Maybe (String, Expr)) -> String -> Maybe (String, Expr)
parseBinOp assoc op parseOp nextParser str =
    (binOp assoc op <$>) <$> go str
  where
    go :: String -> Maybe (String, [Expr])
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

parseBinOpTokens :: Associativity -> Operator -> ([Token] -> Maybe ([Token], Expr)) -> [Token] -> Maybe ([Token], Expr)
parseBinOpTokens assoc op nextParser tokens =
    (binOp assoc op <$>) <$> go tokens
  where
    go :: [Token] -> Maybe ([Token], [Expr])
    go tokens = do
      first@(t, e) <- nextParser tokens
      if null t
      then return (t, [e])
      else
        if head t == Oper op
        then ((e:) <$>) <$> go (tail t)
        else  return (t, [e])

parseSum :: String -> Maybe (String, Expr)
parseSum = parseBinOp AssocL Plus (parseOp '+') parseMult

parseSumTokens :: [Token] -> Maybe ([Token], Expr)
parseSumTokens = parseBinOpTokens AssocL Plus parseMultTokens

parseMult :: String -> Maybe (String, Expr)
parseMult = parseBinOp AssocL Mult (parseOp '*') parsePow

parseMultTokens :: [Token] -> Maybe ([Token], Expr)
parseMultTokens = parseBinOpTokens AssocL Mult parsePowTokens

parsePow :: String -> Maybe (String, Expr)
parsePow = parseBinOp AssocR Pow (parseOp '^') (\str -> parseDigit str <|> parseExprBr str)

parsePowTokens :: [Token] -> Maybe ([Token], Expr)
parsePowTokens = parseBinOpTokens AssocR Pow (\tokens -> parseDigitTokens tokens <|> parseExprBrTokens tokens)

parseDigitTokens :: [Token] -> Maybe ([Token], Expr)
parseDigitTokens (Number n:t) = Just (t, Num n)
parseDigitTokens _ = Nothing

parseExprBrTokens :: [Token] -> Maybe ([Token], Expr)
parseExprBrTokens (Lbr : t) =
    case parseSumTokens t of
      Just (Rbr : t', e) -> Just (t', e)
      _ -> Nothing
parseExprBrTokens _ = Nothing

parseExprBr :: String -> Maybe (String, Expr)
parseExprBr ('(' : t) =
  case parseSum t of
    Just (')' : t', e) -> Just (t', e)
    _ -> Nothing
parseExprBr _ = Nothing
