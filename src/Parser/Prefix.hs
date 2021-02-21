module Parser.Prefix where

import Parser.Common (parserEof)
import Expr (Expr (..))
import Data.Char ( isDigit, isSpace )
import Lexer (Token (..), lexer)

parse :: String -> Maybe Expr
parse = parserEof parsePrefix

-- lexer then parser
parsePrefix :: String -> Maybe ([Token], Expr)
parsePrefix str = do
    tokens <- lexer str
    go tokens
  where
    go (Oper op : t) = do
      (t', l) <- go t
      (t'', r) <- go t'
      return (t'', BinOp op l r)
    go (Number number : t) = do
      return (t, Num number)
    go _ = Nothing