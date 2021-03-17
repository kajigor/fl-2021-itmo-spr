module Megaparsec.Parser where


import qualified Control.Monad.Combinators.Expr as E
    ( makeExprParser, Operator(InfixR, InfixL, InfixN) )
import Data.Void (Void(..))
import Text.Megaparsec
    ( (<|>),
      runParser,
      errorBundlePretty,
      between,
      many,
      some,
      Parsec,
      MonadParsec(try) )
import Text.Megaparsec.Char
    ( alphaNumChar, letterChar, digitChar, space, space1, newline, string )
import qualified Text.Megaparsec.Char.Lexer as L
import Data.Functor (void)
import AstStmt ( Program(..), Stmt(..), Expr(..), Operator(..), Fixity(..), fixity )

type Parser = Parsec Void String

parse :: String -> Either String Program
parse = runBundlingParser programParser

runBundlingParser parser =
    mapLeft errorBundlePretty . runParser parser ""
  where
    mapLeft f = either (Left . f) Right

programParser :: Parser Program
programParser = Program <$> statementParser 

-- Statements --

statementParser :: Parser Stmt
statementParser = seqParser

singleStatementParser :: Parser Stmt
singleStatementParser = 
  space *> (
    try ignoreExprParser <|>
    try ifParser <|>
    try whileParser <|>
    try readParser <|>
    try writeParser <|>
    try assignParser 
  ) <* whitespace

ignoreExprParser :: Parser Stmt 
ignoreExprParser = Ignore <$> try exprParser

ifParser :: Parser Stmt 
ifParser = do 
  symbol "?"
  condition <- exprParser
  symbol "{"
  body <- statementParser
  symbol "}"
  return $ If condition body Nothing 

whileParser :: Parser Stmt 
whileParser = do 
  symbol "@"
  condition <- exprParser
  symbol "{"
  body <- statementParser
  symbol "}"
  return $ While condition body 

readParser :: Parser Stmt 
readParser = do 
  symbol ">>"
  id <- identParser
  return $ Read id

writeParser :: Parser Stmt 
writeParser = do 
  symbol "<<"
  expr <- exprParser
  return $ Write expr

assignParser :: Parser Stmt 
assignParser = do
  id <- identParser
  symbol "{"
  expr <- exprParser
  symbol "}"
  return $ Assign id expr

seqParser :: Parser Stmt
seqParser = Seq <$> many (singleStatementParser <* newline <* space)

-- Expressions --

exprParser :: Parser Expr 
exprParser = 
  E.makeExprParser 
    (roundBr exprParser <|> termParser)
    operatorTable
  where
    termParser :: Parser Expr
    termParser = try (Ident <$> identParser) 
             <|> try (Num <$> numberParser)

    operatorTable = (map . map) opParser operations

    operations :: [[Operator]]
    operations = [
      [Pow], 
      [Mult, Div], 
      [Plus, Minus], 
      [Le, Lt, Ge, Gt], 
      [Eq, Neq]
      ]

    opParser op = (fixity' $ fixity op) 
                  (BinOp op <$ try (symbol (show op)))

    fixity' R = E.InfixR
    fixity' L = E.InfixL
    fixity' N = E.InfixN


-- Lexing -- 

whitespace :: Parser ()
whitespace = void $ many (string " " <|> string "\t")

whitespace1 :: Parser ()
whitespace1 = void $ some (string " " <|> string "\t")

symbol :: String -> Parser String
symbol = L.symbol space1

lexeme :: Parser a -> Parser a
lexeme = L.lexeme whitespace1 

identParser :: Parser String
identParser = (lexeme . try) ident where
  ident = do
    leadingDigits <- many digitChar
    letter <- letterChar
    rest <- many alphaNumChar
    return $ leadingDigits ++ letter : rest

numberParser :: Parser Int 
numberParser = (lexeme . try) number where 
  number = plus <|> minus <|> digits

  plus = string "+" *> number
  minus = string "-" *> (negate <$> number)
  digits = L.decimal 

roundBr :: Parser a -> Parser a
roundBr = between (symbol "(") (symbol ")")
