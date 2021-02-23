module Parser.Infix where

import Parser.Common (parseOp, parseDigit, parserEof)
import Control.Applicative ((<|>))
import Data.Char (isDigit, digitToInt, isSpace)
import Expr (Expr (..), Operator (..))
import Text.Printf (printf)
import Lexer ( Token(..), lexer )

parse :: String -> Maybe Expr
parse = parserEof parseWithLexer

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
parseBinOp assoc op nextParser str =
    (binOp assoc op <$>) <$> go str
  where
    go :: [Token] -> Maybe ([Token], [Expr])
    go tokens = do
      first@(t, e) <- nextParser tokens
      if null t
      then return (t, [e])
      else
        ( do
          (Oper op' : t') <- Just t
          if op == op' then 
            ( do
                let rest = go t'
                ((e:) <$>) <$> rest
            )
          else 
            Nothing -- go next parser, maybe have same operator
        )
        <|>
        return (t, [e])

parseSum :: [Token] -> Maybe ([Token], Expr)
parseSum = parseBinOp AssocL Plus parseMult

parseMult :: [Token] -> Maybe ([Token], Expr)
parseMult = parseBinOp AssocL Mult parsePow

parsePow :: [Token] -> Maybe ([Token], Expr)
parsePow = parseBinOp AssocR Pow (\token -> parseNumber token <|> parseExprBr token)

parseNumber :: [Token] -> Maybe ([Token], Expr)
parseNumber (Number num : arr) = Just (arr, Num num)
parseNumber _ = Nothing 

parseExprBr :: [Token] -> Maybe ([Token], Expr)
parseExprBr (Lbr : t) = do 
  (Rbr : t', expr) <- parseSum t
  return (t', expr)
parseExprBr _ = Nothing

parseWithLexer :: String -> Maybe ([Token], Expr)
parseWithLexer str = do
  tokens <- lexer str
  parseSum tokens