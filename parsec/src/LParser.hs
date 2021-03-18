module LParser where

import Control.Monad.Combinators.Expr as CE
import Data.Void (Void(..))
import Text.Megaparsec
    ( (<|>),
      runParser,
      errorBundlePretty,
      between,
      many,
      optional,
      Parsec,
      MonadParsec(try) )
import Text.Megaparsec.Char
    ( alphaNumChar, char, letterChar, space1 )
import qualified Text.Megaparsec.Char.Lexer as L
import AstStmt

type Parser = Parsec Void String

parse :: String -> Either String Program
parse = runBundlingParser progParser

runBundlingParser parser =
    mapLeft errorBundlePretty . runParser parser ""
  where
    mapLeft f = either (Left . f) Right


progParser :: Parser Program
progParser = sc *> (Program <$> sequenceParser)  <* sc 

-- spaces & comments
sc :: Parser ()
sc = L.space space1 lineCmnt blockCmnt
  where
    lineCmnt  = L.skipLineComment "//"
    blockCmnt = L.skipBlockComment "/*" "*/"

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

symbol :: String -> Parser String
symbol = L.symbol sc

kw :: [String]
kw = ["if", "else", "true", "false", "while", "<<", ">>", "begin", "end"]

sequenceParser :: Parser Stmt
sequenceParser = Seq <$> many statementParser

statementParser :: Parser Stmt
statementParser = whileParser <|> ifParser <|> readParser <|> writeParser <|> assignParser <|> ignoreParser

whileParser :: Parser Stmt
whileParser = do
  symbol "while"
  symbol "("
  condition <- exprParser
  symbol ")"
  symbol "begin"
  body <- sequenceParser
  symbol "end"
  return (While condition body)

ifParser :: Parser Stmt
ifParser = do 
  symbol "if"
  symbol "("
  condition <- exprParser
  symbol ")"
  symbol "begin"
  body <- sequenceParser
  symbol "end"
  elseBody <- optional elseParser
  return (If condition body elseBody)

elseParser :: Parser Stmt
elseParser = do
  symbol "else"
  symbol "begin"
  body <- sequenceParser
  symbol "end"
  return body

readParser :: Parser Stmt 
readParser = do
  symbol ">>"
  var <- variableParser
  symbol ";"
  return (Read var)

writeParser :: Parser Stmt 
writeParser = do
  symbol "<<"
  expr <- exprParser
  symbol ";"
  return (Write expr)

assignParser :: Parser Stmt 
assignParser = do
  varName <- variableParser
  symbol "="
  varValue <- exprParser
  symbol ";"
  return (Assign varName varValue)

ignoreParser :: Parser Stmt 
ignoreParser = do
  expr <- exprParser
  symbol ";"
  return (Ignore expr)

operatorTable :: [[CE.Operator Parser Expr]]
operatorTable = [[rightAssoc "^" (BinOp Pow)],
                 [leftAssoc "*" (BinOp Mult), leftAssoc "/" (BinOp Div)],
                 [leftAssoc "+" (BinOp Plus), leftAssoc "-" (BinOp Minus)],
                 [noAssoc "<=" (BinOp Le), noAssoc "<" (BinOp Lt), noAssoc ">=" (BinOp Ge), noAssoc ">" (BinOp Gt)],
                 [noAssoc "!=" (BinOp Neq), noAssoc "==" (BinOp Eq)]]
              where leftAssoc name op = InfixL (op <$ symbol name)
                    rightAssoc name op = InfixR (op <$ symbol name)
                    noAssoc name op = InfixN (op <$ symbol name)


exprParser :: Parser Expr
exprParser = makeExprParser (brackets exprParser <|> (Num <$> numParser) <|> (Ident <$> variableParser)) operatorTable

brackets :: Parser a -> Parser a
brackets = between (symbol "(") (symbol ")")

variableParser :: Parser Var
variableParser = (lexeme . try) (p >>= check)
  where
    p = (:) <$> letterChar <*> many (char '_' <|> alphaNumChar)
    check x = if x `elem` kw
              then fail $ show x ++ " cannot be an identifier"
              else return x

numParser :: Parser Int
numParser = lexeme L.decimal