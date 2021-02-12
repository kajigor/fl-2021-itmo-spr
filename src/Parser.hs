module Parser where

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
eval (BinOp Pow l r) = eval l ^ eval r
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

-- Expr :: + Expr Expr
--       | * Expr Expr
--       | Digit
parsePrefix :: String -> Maybe (String, Expr)
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
--       | Digit
--       | ( Expr )

-- Expr :: Слаг + Слаг + ... + Слаг
--       = Слаг (+ Слаг) (+ Слаг) .. (+ Слаг)
--       -> [Слаг] - fold ... -> BinOp Plus (BinOp Plus ...)...
-- Слаг :: Множ * Множ * ... * Множ
-- Множ :: Цифра | ( Expr )
-- [1,2,3] -> (1+2)+3

binOp :: Operator -> [Expr] -> Expr
binOp op = foldl1 (BinOp op)

binOpR :: Operator -> [Expr] -> Expr
binOpR op = foldr1 (BinOp op)

parseInfix :: String -> Maybe (String, Expr)
parseInfix = parseSum

data Associativity = Rght | Lft deriving (Show, Eq)

parseOp :: Associativity -> (String-> Maybe (String, Expr)) -> String -> Maybe (String, Expr)
parseOp ass next str = let op = if ass == Rght then binOpR else binOp in
    (op Plus <$>) <$> go str
  where
    go :: String -> Maybe (String, [Expr])
    go str =
      let first = parseMult str in
      case first of
        Nothing -> Nothing
        Just (t, e) ->
          if null t
          then Just ("", [e])
          else
            case parsePlus t of
              Just (t', _) ->
                let rest = go t' in
                ((e:) <$>) <$> rest
              Nothing -> Just (t, [e])

parseSum :: String -> Maybe (String, Expr)
parseSum = parseOp Lft parseMult

parseMult :: String -> Maybe (String, Expr)
parseMult = parseOp Lft parseMult

parsePow :: String -> Maybe (String, Expr)
parsePow = parseOp Rght (\str -> parseDigit str <|> parseExprBr str)

parseExprBr :: String -> Maybe (String, Expr)
parseExprBr ('(' : t) =
  case parseSum t of
    Just ((')' : t'), e) -> Just (t', e)
    _ -> Nothing
parseExprBr _ = Nothing

parsePlus :: String -> Maybe (String, Operator)
parsePlus ('+' : t) = Just (t, Plus)
parsePlus _ = Nothing

parseStar :: String -> Maybe (String, Operator)
parseStar ('*' : t) = Just (t, Mult)
parseStar _ = Nothing

parseHat :: String -> Maybe (String, Operator)
parseHat ('^' : t) = Just (t, Pow)
parseHat _ = Nothing

parseDigit :: String -> Maybe (String, Expr)
parseDigit (d : t) | isDigit d =
  Just (t, Num (digitToInt d))
parseDigit _ = Nothing

plus :: Expr -> Expr -> Expr
plus = BinOp Plus

mult :: Expr -> Expr -> Expr
mult = BinOp Mult

pow :: Expr -> Expr -> Expr
pow = BinOp Pow
