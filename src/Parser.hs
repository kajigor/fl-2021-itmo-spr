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
parsePrefix (s : t) 
  | s == '+' || s == '*' || s == '^' =
    case parsePrefix t of
      Just (t', l) ->
        case parsePrefix t' of
          Just (t'', r) -> Just (t'', BinOp (toOp s) l r)
          Nothing -> Nothing
      Nothing -> Nothing
  | isDigit s = Just (t, Num (digitToInt s))
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

data Associativity = L | R;

binOp :: Operator -> Associativity -> [Expr] -> Expr
binOp op L = foldl1 (BinOp op)
binOp op R = foldr1 (BinOp op)

parseInfix :: String -> Maybe (String, Expr)
parseInfix = parseByOperation Plus

operatorMapInner :: Operator -> Maybe Operator
operatorMapInner Plus = Just Mult
operatorMapInner Mult = Just Pow
operatorMapInner Pow = Nothing 

operatorToParser :: Operator -> String -> Maybe (String, Operator)
operatorToParser Plus = parseStringOperator '+'
operatorToParser Mult = parseStringOperator '*'
operatorToParser Pow = parseStringOperator '^'

operatorAssociativity :: Operator -> Associativity
operatorAssociativity Plus = L
operatorAssociativity Mult = L
operatorAssociativity Pow = R 

parseByOperation :: Operator -> String -> Maybe (String, Expr)
parseByOperation operator str = 
    (binOp operator (operatorAssociativity operator) <$>) <$> go str operator
  where
    execOperation str operator = case operatorMapInner operator of 
          (Just subOp) -> parseByOperation subOp str
          Nothing -> parseDigit str <|> parseExprBr str
    go :: String -> Operator -> Maybe (String, [Expr])
    go str operator = 
      let first = execOperation str operator in 
        case first of 
          Nothing -> Nothing
          Just (t, e) ->
            if null t then 
              Just ("", [e])
            else
            case operatorToParser operator t of
              Just (t', _) ->
                let rest = go t' operator in
                  ((e:) <$>) <$> rest
              Nothing -> Just (t, [e])

parseExprBr :: String -> Maybe (String, Expr)
parseExprBr ('(' : t) =
  case parseInfix t of
    Just (')' : t', e) -> Just (t', e)
    _ -> Nothing
parseExprBr _ = Nothing

parseStringOperator :: Char -> String -> Maybe (String, Operator)
parseStringOperator op [] = Nothing 
parseStringOperator op (x : t) 
  | op == x = Just (t, toOp x)
  | otherwise = Nothing 

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
