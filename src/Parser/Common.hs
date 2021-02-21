module Parser.Common where

import Data.Char (isDigit, digitToInt)
import Expr (Operator (..), Expr (..))
import Lexer (Token (..))

parseOp :: Token -> [Token] -> Maybe ([Token], Operator)
parseOp (Oper c) ((Oper h) : t) | c == h = Just (t, c)
parseOp _ _ = Nothing

parseDigit :: [Token] -> Maybe ([Token], Expr)
parseDigit ((Number d) : t)  =
  Just (t, Num d)
parseDigit _ = Nothing

parserEof :: MonadFail m => (t -> m ([a], b)) -> t -> m b
parserEof parser str = do
  ([], r) <- parser str
  return r
