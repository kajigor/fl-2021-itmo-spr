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

opChar :: Operator -> Char
opChar Plus = '+'
opChar Mult = '*'
opChar Pow = '^'

data Expr = BinOp Operator Expr Expr
          | Num Int
          deriving (Show, Eq)

eval :: Expr -> Int
eval (BinOp Plus l r) = eval l + eval r
eval (BinOp Mult l r) = eval l * eval r
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

fmap2 :: (Functor f1, Functor f2) => (a -> b) -> f1 (f2 a) -> f1 (f2 b)
fmap2 f x = (f <$>) <$> x

(<$$>) :: (Functor f1, Functor f2) => (a -> b) -> f1 (f2 a) -> f1 (f2 b)
(<$$>) = fmap2

binOp :: Operator -> [Expr] -> Expr
binOp op = foldl1 (BinOp op)

parseInfix :: String -> Maybe (String, Expr)
parseInfix = parseSum

parseSepBy :: (String -> Maybe (String, a)) -> (String -> Maybe (String, b)) -> String -> Maybe (String, [a])
parseSepBy item separator str = 
  let first = item str in
  case first of
    Nothing -> Nothing
    Just (t, e) ->
      if null t
      then Just ("", [e])
      else
        case separator t of
          Just (t', _) ->
            let rest = parseSepBy item separator t' in
            (e:) <$$> rest
          Nothing -> Just (t, [e])


parseSum :: String -> Maybe (String, Expr)
parseSum str =
    binOp Plus <$$> go str
  where
    go :: String -> Maybe (String, [Expr])
    go = parseSepBy parseMult (parseOp Plus)

parseMult :: String -> Maybe (String, Expr)
parseMult str =
    binOp Mult <$$> go str
  where
    go :: String -> Maybe (String, [Expr])
    go = parseSepBy parsePow (parseOp Mult)

parsePow :: String -> Maybe (String, Expr)
parsePow str =
    foldr1 (BinOp Pow) <$$> go str
  where
    go :: String -> Maybe (String, [Expr])
    go str = parseSepBy (\str -> parseDigit str <|> parseExprBr str) (parseOp Pow) str

parseExprBr :: String -> Maybe (String, Expr)
parseExprBr ('(' : t) =
  case parseSum t of
    Just (')' : t', e) -> Just (t', e)
    _ -> Nothing
parseExprBr _ = Nothing


parseChar :: Char -> String -> Maybe (String, Char)
parseChar c (x:xs)
    | c == x = Just (xs, c)
    | otherwise = Nothing

parseOp :: Operator -> String -> Maybe (String, Operator)
parseOp op s = const op <$$> parseChar (opChar op) s


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
