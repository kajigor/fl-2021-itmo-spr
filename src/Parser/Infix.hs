module Parser.Infix where

import Parser.Common (parseOp, parseDigit, parserEof)
import Control.Applicative ((<|>))
import Data.Char (isDigit, digitToInt, isSpace)
import Expr (Expr (..), Operator (..))
import Text.Printf (printf)
import Lexer ( Token(..), lexer)

-- Наша строка сначала проходит через лексер, а только потом
-- идет в parseSum
parse :: String -> Maybe Expr
parse str = parserEof parseLexer str
     where parseLexer str = do 
                          tokens <- lexer str
                          parseSum tokens

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
parseBinOp assoc op parseOp nextParser tokens =
    (binOp assoc op <$>) <$> go tokens
  where
    go :: [Token] -> Maybe ([Token], [Expr])
    go tokens = do
      first@(t, e) <- nextParser tokens
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

parseSum :: [Token] -> Maybe ([Token], Expr)
parseSum = parseBinOp AssocL Plus (parseOp (Oper Plus)) parseMult

parseMult :: [Token] -> Maybe ([Token], Expr)
parseMult = parseBinOp AssocL Mult (parseOp (Oper Mult)) parsePow

parsePow :: [Token] -> Maybe ([Token], Expr)
parsePow = parseBinOp AssocR Pow (parseOp (Oper Pow)) (\tokens -> parseNumber tokens <|> parseExprBr tokens)

parseNumber :: [Token] -> Maybe ([Token], Expr)
parseNumber (Number n : t) = return (t, Num n)
parseNumber _ = Nothing 

-- Раз у нас теперь токены, то надо открывающую и закрывающую скобку как в токенах
parseExprBr :: [Token] -> Maybe ([Token], Expr)
parseExprBr (Lbr : t) = 
  case parseSum t of
      Just (Rbr : t', e) -> Just (t', e)
      _ -> Nothing
parseExprBr _ = Nothing


