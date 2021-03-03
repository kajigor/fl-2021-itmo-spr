module Parser.Common where

import Data.Char (isDigit, isAlpha)
import Parser.Combinators ( Parser, satisfy )
import Control.Applicative (some, many, (<|>))

digit :: Parser String Char
digit = satisfy isDigit

digit' :: Parser String Char
digit' = satisfy (\x -> isDigit x && x /= '0')

alpha :: Parser String Char
alpha = satisfy isAlpha

-- number :: not empty, consists of digits
number :: Parser String Int
number = do
  num <- some digit
  return $ (read num :: Int)

validIdentChar :: Parser String Char
validIdentChar = satisfy (\x -> isDigit x || isAlpha x || x == '_')

identifier :: Parser String String
identifier = do
  startLetter <- alpha
  rest <- many validIdentChar
  return (startLetter:rest)


data Associativity = LeftAssoc  -- x `op` y `op` z == (x `op` y) `op` z
                   | RightAssoc -- x `op` y `op` z == x `op` (y `op` z)
                   | NoAssoc    -- non associative operation:
                                -- x `op` y -- ok
                                -- x `op` y `op` z -- not ok


zeroOrOne :: Parser input a -> Parser input [a]
zeroOrOne p = (do
  first <- p
  return [first]
  )
  <|>
  return []

uberExpr :: [(Parser i op, Associativity)]
         -> Parser i ast
         -> (op -> ast -> ast -> ast)
         -> Parser i ast

uberExpr [] elemParser func = do
  elemParser

uberExpr ((opp, NoAssoc):opps) elemParser func = do
  let lowerParser = uberExpr opps elemParser func
  firstOperand <- lowerParser
  opAndSecond <- zeroOrOne $ opp >>= \operat -> fmap (\x -> (operat, x)) lowerParser
  let secondOperand = map snd opAndSecond
  return $ foldr1 (func (fst (head opAndSecond))) (firstOperand:secondOperand)

uberExpr ((opp, assoc):opps) elemParser func =
  do { let lowerParser = uberExpr opps elemParser func
     ; fh <- lowerParser
     ; opsAndRest <- many $ opp >>= \operat -> fmap (\x -> (operat, x)) lowerParser;
     ; let rest = map snd opsAndRest
     ; let ops = map fst opsAndRest
     ; let act = zip ops (fh:rest)
     ; return $ case assoc of LeftAssoc -> foldl (\x y -> func (fst y) x (snd y)) fh opsAndRest
                              RightAssoc -> foldr (\x y -> func (fst x) (snd x) y) (last (fh:rest)) act
}
