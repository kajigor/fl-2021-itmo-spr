module Parser.Common where

import Data.Char (isDigit, isAlpha)
import Parser.Combinators ( Parser, satisfy )
import Control.Applicative 

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

data Associativity = LeftAssoc  -- x `op` y `op` z == (x `op` y) `op` z
                   | RightAssoc -- x `op` y `op` z == x `op` (y `op` z)
                   | NoAssoc    -- non associative operation:
                                -- x `op` y -- ok
                                -- x `op` y `op` z -- not ok

uberExpr :: [(Parser i op, Associativity)]
         -> Parser i ast
         -> (op -> ast -> ast -> ast)
         -> Parser i ast

uberExpr ((parserOp, assoc):listParserOp) elementaryParser builderTree = case assoc of

  NoAssoc -> ( do
          ast1 <- nextParserOp
          op' <- parserOp
          builderTree op' ast1 <$> nextParserOp
         ) <|>
         nextParserOp 
         where nextParserOp = uberExpr listParserOp elementaryParser builderTree 

  LeftAssoc -> do 
         (ops, elems) <- nextParser
         let rest = foo flip (map builderTree ops) (tail elems)
         return $ foldl (\ f r -> r f) (head elems) rest 
         where nextParser = do
                          let nextParserOp = uberExpr listParserOp elementaryParser builderTree
                          t <- nextParserOp
                          p <- many ( liftA2 (,) parserOp  nextParserOp)
                          return (map fst p, t : map snd p)
  RightAssoc -> do
         (ops, elems) <- nextParser
         let rest = foo ($) (map builderTree ops) (init elems)
         return $ foldr ($)  (last elems) rest
         where nextParser = do
                          let nextParserOp = uberExpr listParserOp elementaryParser builderTree
                          t <- nextParserOp
                          p <- many ( liftA2 (,) parserOp nextParserOp)
                          return (map fst p, t : map snd p)

uberExpr [] elementaryParser _ = elementaryParser

foo :: (a1 -> a2 -> a3) -> [a1] -> [a2] -> [a3]
foo fs xs ys = getZipList $ fs <$> ZipList xs <*> ZipList ys