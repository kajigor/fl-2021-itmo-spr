module Parser (
    Operator (..), 
    Expr (..), 
    ParserType (..), 
    eval,
    parse,
    plus,
    mult,
    pow
) where

import Control.Applicative ((<|>))
import Data.Char (isDigit, digitToInt)
import Text.Printf (printf)

data Operator = Plus
              | Mult
              | Pow
              deriving (Show, Eq)

toOp :: Char -> Operator
toOp '+' = Plus
toOp '*' = Mult
toOp '^' = Pow
toOp c = error $ printf "Unsupported operator: %c" c

data Expr = BinOp Operator Expr Expr
          | Num Int
          deriving (Show, Eq)

eval :: Expr -> Int
eval (BinOp Plus l r) = eval l + eval r
eval (BinOp Mult l r) = eval l * eval r
eval (BinOp Pow l r)  = eval l ^ eval r
eval (Num x) = x

data ParserType = Prefix | Infix deriving (Show)

parse :: ParserType -> String -> Maybe Expr
parse pType str =
    case go pType str of
      Just ("", e) -> Just e
      _ -> Nothing
  where
    go Prefix = parsePrefix
    go Infix  = parseInfix

type Parser a = String -> Maybe (String, a)

-- Expr :: + Expr Expr
--       | * Expr Expr
--       | ^ Expr Expr
--       | Digit

parsePrefix :: Parser Expr
parsePrefix (op : t) | op == '+' || op == '*' || op == '^' =
  case parsePrefix t of
    Just (t', l) ->
      case parsePrefix t' of
        Just (t'', r) -> Just (t'', BinOp (toOp op) l r)
        Nothing -> Nothing
    Nothing -> Nothing
parsePrefix (d : t) | isDigit d =
  Just (t, Num (digitToInt d))
parsePrefix _ = Nothing

-- Expr :: Expr + Expr
--       | Expr * Expr
--       | Expr ^ Expr
--       | Digit
--       | ( Expr )

-- Expr :: Слаг + Слаг + ... + Слаг
--       = Слаг (+ Слаг) (+ Слаг) .. (+ Слаг)
--       -> [Слаг] - fold ... -> BinOp Plus (BinOp Plus ...)...
-- Слаг :: Множ * Множ * ... * Множ
-- Множ :: Опер ^ Опер ^ ... ^ Опер
-- Опер :: Цифра | ( Expr )
-- [1,2,3] -> (1+2)+3

data Associativity = L | R

binOp :: Operator -> Associativity -> [Expr] -> Expr
binOp op L = foldl1 (BinOp op)
binOp op R = foldr1 (BinOp op)

parseInfix :: Parser Expr
parseInfix = parseSum

parseMany1 :: Parser Expr -> Char -> Parser [Expr]
parseMany1 parseOne delimiter str = 
  let first = parseOne str in
  case first of
    Nothing -> Nothing
    Just (t, e) ->
      if null t
      then Just ("", [e])
      else
        case parseDelimiter delimiter t of
          Just (t', _) ->
            let rest = parseMany1 parseOne delimiter t' in
            ((e:) <$>) <$> rest
          Nothing -> Just (t, [e])

parseSum :: Parser Expr
parseSum str = (binOp Plus L <$>) <$> parseMany1 parseMult '+' str

parseMult :: Parser Expr
parseMult str = (binOp Mult L <$>) <$> parseMany1 parsePow '*' str

parsePow :: Parser Expr
parsePow str = (binOp Pow R <$>) <$> parseMany1 (\s -> parseDigit s <|> parseExprBr s) '^' str

parseExprBr :: Parser Expr
parseExprBr ('(' : t) =
  case parseSum t of
    Just ((')' : t'), e) -> Just (t', e)
    _ -> Nothing
parseExprBr _ = Nothing

parseDelimiter :: Char -> Parser Operator
parseDelimiter d (c : t) | c == d = Just (t, toOp c)
parseDelimiter _ _ = Nothing

parseDigit :: Parser Expr
parseDigit (d : t) | isDigit d =
  Just (t, Num (digitToInt d))
parseDigit _ = Nothing

plus :: Expr -> Expr -> Expr
plus = BinOp Plus

mult :: Expr -> Expr -> Expr
mult = BinOp Mult

pow :: Expr -> Expr -> Expr
pow = BinOp Pow
