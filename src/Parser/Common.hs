module Parser.Common where

import Data.Char (isDigit, digitToInt)
import Expr (Operator (..), Expr (..), toOp)
import Lexer (Token (..))

parseOp :: Token -> [Token] -> Maybe ([Token], Operator)
parseOp (Oper op') ((Oper op) : t) | op' == op = Just (t, op')
parseOp _ _ = Nothing

parseDigit :: String -> Maybe (String, Expr)
parseDigit (d : t) | isDigit d =
  Just (t, Num (digitToInt d))
parseDigit _ = Nothing

parserEof :: MonadFail m => (t -> m ([a], b)) -> t -> m b
parserEof parser str = do
  ([], r) <- parser str
  return r
