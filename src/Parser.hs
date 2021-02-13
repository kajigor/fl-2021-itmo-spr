module Parser where

import           Control.Applicative            ( (<|>) )
import           Data.Char                      ( isDigit
                                                , digitToInt
                                                )
import           Text.Printf                    ( printf )

data Operator = Plus
              | Mult
              | Pow
              deriving (Show, Eq)

toOp :: Char -> Operator
toOp '+' = Plus
toOp '*' = Mult
toOp '^' = Pow
toOp c   = error $ printf "Unsupported operator: %c" c

data Expr = BinOp Operator Expr Expr
          | Num Int
          deriving (Show, Eq)

eval :: Expr -> Int
eval (BinOp Plus l r) = eval l + eval r
eval (BinOp Mult l r) = eval l * eval r
eval (BinOp Pow  l r) = eval l ^ eval r
eval (Num x         ) = x

data ParserType = Prefix | Infix deriving (Show)

parse :: ParserType -> String -> Maybe Expr
parse pType str = case go pType str of
  Just ("", e) -> Just e
  _            -> Nothing
 where
  go Prefix = parsePrefix
  go Infix  = parseInfix

-- Expr :: + Expr Expr
--       | * Expr Expr
--       | Digit
parsePrefix :: String -> Maybe (String, Expr)
parsePrefix (op : t) | op == '+' || op == '*' || op == '^' =
  case parsePrefix t of
    Just (t', l) -> case parsePrefix t' of
      Just (t'', r) -> Just (t'', BinOp (toOp op) l r)
      Nothing       -> Nothing
    Nothing -> Nothing
parsePrefix (d : t) | isDigit d = Just (t, Num (digitToInt d))
parsePrefix _                   = Nothing

-- Expr :: Expr + Expr
--       | Expr * Expr
--       | Digit
--       | ( Expr )

-- Expr :: Слаг + Слаг + ... + Слаг
--       = Слаг (+ Слаг) (+ Слаг) .. (+ Слаг)
--       -> [Слаг] - fold ... -> BinOp Plus (BinOp Plus ...)...
-- Слаг :: Factor * Factor * ... * Factor
-- Factor :: Множ ^ Factor | Множ 
-- Множ :: Цифра | ( Expr )
-- [1,2,3] -> (1+2)+3

data Associativity = LeftA | RightA
binOp :: (Expr -> Expr -> Expr) -> Associativity -> [Expr] -> Expr
binOp appOp LeftA  = foldl1 appOp
binOp appOp RightA = foldr1 appOp

parseInfix :: String -> Maybe (String, Expr)
parseInfix = parseSum

parseSum :: String -> Maybe (String, Expr)
parseSum = parseAny (binOp plus LeftA) parseMult parsePlus

parseMult :: String -> Maybe (String, Expr)
parseMult = parseAny (binOp mult LeftA) parsePow parseStar

parsePow :: String -> Maybe (String, Expr)
parsePow = parseAny (binOp pow RightA)
                    (\str -> parseDigit str <|> parseExprBr str)
                    parseHat

parseAny
  :: ([Expr] -> Expr)
  -> -- binApp
     (String -> Maybe (String, Expr))
  -> -- firstFun
     (String -> Maybe (String, Operator))
  -> --parseSign
     String
  -> Maybe (String, Expr)
parseAny binApp firstFun parseSign str = (binApp <$>) <$> go str
 where
  go :: String -> Maybe (String, [Expr])
  go str =
    let first = firstFun str
    in  case first of
          Nothing     -> Nothing
          Just (t, e) -> if null t
            then Just ("", [e])
            else case parseSign t of
              Just (t', _) -> let rest = go t' in ((e :) <$>) <$> rest
              Nothing      -> Just (t, [e])


parseExprBr :: String -> Maybe (String, Expr)
parseExprBr ('(' : t) = case parseSum t of
  Just (')' : t', e) -> Just (t', e)
  _                  -> Nothing
parseExprBr _ = Nothing

parseOperator :: Char -> String -> Maybe (String, Operator)
parseOperator op (t : ts) | op == t = Just (ts, toOp op)
parseOperator _ _                   = Nothing

parsePlus :: String -> Maybe (String, Operator)
parsePlus = parseOperator '+'

parseStar :: String -> Maybe (String, Operator)
parseStar = parseOperator '*'

parseHat :: String -> Maybe (String, Operator)
parseHat = parseOperator '^'

parseDigit :: String -> Maybe (String, Expr)
parseDigit (d : t) | isDigit d = Just (t, Num (digitToInt d))
parseDigit _                   = Nothing

plus :: Expr -> Expr -> Expr
plus = BinOp Plus

mult :: Expr -> Expr -> Expr
mult = BinOp Mult

pow :: Expr -> Expr -> Expr
pow = BinOp Pow
