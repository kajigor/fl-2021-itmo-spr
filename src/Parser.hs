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

parseSum :: String -> Maybe (String, Expr)
parseSum str =
    binOp Plus <$$> go str
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
                (e:) <$$> rest
              Nothing -> Just (t, [e])

parseMult :: String -> Maybe (String, Expr)
parseMult str =
    binOp Mult <$$> go str
  where
    go :: String -> Maybe (String, [Expr])
    go str =
      let first = parsePow str in
      case first of
        Nothing -> Nothing
        Just (t, e) ->
          if null t
          then Just ("", [e])
          else
            case parseStar t of
              Just (t', _) ->
                let rest = go t' in
                (e:) <$$> rest
              Nothing -> Just (t, [e])

parsePow :: String -> Maybe (String, Expr)
parsePow str =
    foldr1 (BinOp Pow) <$$> go str
  where
    go :: String -> Maybe (String, [Expr])
    go str =
      let first = parseDigit str <|> parseExprBr str in
      case first of
          Nothing -> Nothing
          Just (t, e) ->
              if null t
              then Just ("", [e])
              else
                case parseHat t of
                  Just (t', _) ->
                    let rest = go t' in
                    (e:) <$$> rest
                  Nothing -> Just (t, [e])

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

parsePlus :: String -> Maybe (String, Operator)
parsePlus s = const Plus <$$> parseChar '+' s

parseStar :: String -> Maybe (String, Operator)
parseStar s = const Mult <$$> parseChar '*' s

parseHat :: String -> Maybe (String, Operator)
parseHat s = const Pow <$$> parseChar '^' s

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
