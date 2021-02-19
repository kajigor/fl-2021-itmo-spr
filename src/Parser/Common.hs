module Parser.Common where

import Data.Char (isDigit, digitToInt)
import Expr (Operator (..), Expr (..), toOp)
import Lexer (Token (..)) 

parseOp :: Token -> [Token] -> Maybe ([Token], Operator)
parseOp tok@(Oper op) (h : t) | tok == h = Just (t, op)
parseOp _ _ = Nothing

parseDigit :: [Token] -> Maybe ([Token], Expr)
parseDigit ((Number n) : t) =
  Just (t, Num n)
parseDigit _ = Nothing

parserEof :: MonadFail m => (t -> m ([a], b)) -> t -> m b
parserEof parser str = do
  ([], r) <- parser str
  return r
