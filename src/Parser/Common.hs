module Parser.Common where

import Data.Char (isDigit, digitToInt)
import Expr (Operator (..), Expr (..), toOp)

type StrParserOf a = String -> Maybe (String, a)

parseOp :: Char -> StrParserOf Operator
parseOp c (h : t) | c == h = Just (t, toOp c)
parseOp _ _ = Nothing

parseDigit :: StrParserOf Expr
parseDigit (d : t) | isDigit d =
  Just (t, Num (digitToInt d))
parseDigit _ = Nothing

parserEof :: MonadFail m => (t -> m ([a], b)) -> t -> m b
parserEof parser str = do
  ([], r) <- parser str
  return r
