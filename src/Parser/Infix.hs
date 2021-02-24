module Parser.Infix where

import Parser.Common (parseOp, parseDigit, parserEof)
import Lexer
import Control.Applicative ((<|>))
import Data.Char (isDigit, digitToInt, isSpace)
import Expr (Expr (..), Operator (..))
import Text.Printf (printf)

type TokParserOf a = [Token] -> Maybe ([Token], a)

parse :: String -> Maybe Expr
parse str = case lexer str of
              Just toks -> parserEof parseSum toks
              Nothing -> Nothing

-- Expr :: Expr + Expr
--       | Expr * Expr
--       | Expr ^ Expr
--       | Digit
--       | ( Expr )

-- Expr :: Слаг + Слаг + ... + Слаг
--       = Слаг (+ Слаг) (+ Слаг) .. (+ Слаг)
--       -> [Слаг] - fold ... -> BinOp Plus (BinOp Plus ...)...
-- Слаг :: Множ * Множ * ... * Множ
-- Множ :: Фактор ^ Фактор ^ ... ^ Фактор
-- Фактор :: Цифра | ( Expr )
-- [1,2,3] -> (1+2)+3

data Associativity = AssocL | AssocR

binOp :: Associativity -> Operator -> [Expr] -> Expr
binOp AssocL op = foldl1 (BinOp op)
binOp AssocR op = foldr1 (BinOp op)

parseBinOp :: Associativity -> Operator -> TokParserOf b -> TokParserOf Expr -> TokParserOf Expr
parseBinOp assoc op parseOp nextParser toks =
    (binOp assoc op <$>) <$> go toks
  where
    go :: TokParserOf [Expr]
    go toks = do
      first@(t, e) <- nextParser toks
      if null t
      then return (t, [e])
      else
        ( do
          (t', _) <- parseOp t
          let rest = go t'
          ((e:) <$>) <$> rest
        )
        <|>
        return (t, [e])

parseTok :: Token -> TokParserOf Token
parseTok tok (fst : rest) | tok == fst = Just (rest, tok)
                          | otherwise  = Nothing

parseTokNum :: TokParserOf Expr
parseTokNum (Number a : toks) = Just (toks, Num a)
parseTokNum _ = Nothing

parseSum :: TokParserOf Expr
parseSum = parseBinOp AssocL Plus (parseTok $ Oper Plus) parseMult

parseMult :: TokParserOf Expr
parseMult = parseBinOp AssocL Mult (parseTok $ Oper Mult) parsePow

parsePow :: TokParserOf Expr
parsePow = parseBinOp AssocR Pow (parseTok $ Oper Pow) (\toks -> parseTokNum toks <|> parseExprBr toks)

parseExprBr :: TokParserOf Expr
parseExprBr (Lbr : t) =
  case parseSum t of
    Just (Rbr : t', e) -> Just (t', e)
    _ -> Nothing
parseExprBr _ = Nothing
