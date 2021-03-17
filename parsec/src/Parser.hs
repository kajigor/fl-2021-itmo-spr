module Parser where

import Common.Syntax

import Control.Monad.Combinators.Expr
    ( makeExprParser, Operator(InfixR,InfixL,InfixN) )
import Data.Void (Void(..))
import Text.Megaparsec
    ( (<|>),
      runParser,
      errorBundlePretty,
      notFollowedBy,
      between,
      many,
      Parsec,
      MonadParsec(try) )
import Text.Megaparsec.Char
    ( alphaNumChar, char, letterChar, space1, string )
import qualified Text.Megaparsec.Char.Lexer as L

type Parser = Parsec Void String

parser :: String -> Either String Program
parser = runBundlingParser progParser

runBundlingParser parser =
    mapLeft errorBundlePretty . runParser parser ""
  where
    mapLeft f = either (Left . f) Right

-- spaces & comments
sc :: Parser ()
sc = L.space space1 lineCmnt blockCmnt
  where
    lineCmnt  = L.skipLineComment "--"
    blockCmnt = L.skipBlockComment "{-" "-}"

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

symbol :: String -> Parser String
symbol = L.symbol sc

kw :: [String]
kw = ["if", "else", "while", "read", "write"]

-- keywords
kword :: String -> Parser ()
kword w = (lexeme . try) (string w *> notFollowedBy alphaNumChar)

-- identifiers
ident :: Parser String
ident = identParser letterChar

identParser fstLetter = (lexeme . try) (p >>= check)
  where
    p = (:) <$> fstLetter <*> many (char '_' <|> alphaNumChar)
    check x = if x `elem` kw
              then fail $ show x ++ " cannot be an identifier"
              else return x

-- brackets
roundBr :: Parser a -> Parser a
roundBr = between (symbol "(") (symbol ")")

curlyBr :: Parser a -> Parser a
curlyBr = between (symbol "{") (symbol "}")

maybeBr :: (Parser a -> Parser a) -> Parser a -> Parser a
maybeBr br p = br (maybeBr br p) <|> p

-- numbers
integer       = lexeme L.decimal
signedInteger = L.signed sc integer

exprParser :: Parser Expr
exprParser = 
    makeExprParser
        (roundBr exprParser <|> Ident <$> ident <|> Num <$> signedInteger)
        operatorTable
  where
    operatorTable =
      [ [ binary "^" Pow    ]
      , [ binary "*" Mult
        , binary "/" Div    ]
      , [ binary "+" Plus
        , binary "-" Minus  ]
      , [ binary "==" Eq
        , binary "!=" Neq
        , binary "<=" Le
        , binary "<" Lt
        , binary ">=" Ge
        , binary ">" Gt     ] ]
    binary name Pow = InfixR (BinOp Pow <$ symbol name)
    binary name Mult = InfixL (BinOp Mult <$ symbol name)
    binary name Plus = InfixL (BinOp Plus <$ symbol name)
    binary name Div = InfixL (BinOp Div <$ symbol name)
    binary name Minus = InfixL (BinOp Minus <$ symbol name)
    binary name f = InfixN (BinOp f <$ symbol name)

ignoreParser :: Parser Stmt
ignoreParser = do
  expr <- exprParser
  symbol ";"
  return $ Ignore expr

readParser :: Parser Stmt
readParser = do
    kword "read"
    var <- ident
    symbol ";"
    return $ Read var

writeParser :: Parser Stmt
writeParser = do
    kword "write"
    expr <- exprParser
    symbol ";"
    return $ Write expr

assignParser :: Parser Stmt
assignParser = do
    var <- ident
    symbol "="
    expr <- exprParser
    symbol ";"
    return $ Assign var expr

stmtParser :: Parser Stmt
stmtParser =
  assignParser  <|>
  readParser    <|>
  writeParser   <|>
  ignoreParser  <|>
  ifParser      <|>
  whileParser   <|>
  curlyBr (Seq <$> many stmtParser)

ifParser :: Parser Stmt
ifParser = try ifElseParse <|> ifWithoutElseParser

ifWithoutElseParser :: Parser Stmt
ifWithoutElseParser = do 
    kword "if"
    cond <- lexeme $ roundBr exprParser
    thn <- lexeme stmtParser
    return $ If cond thn Nothing

ifElseParse :: Parser Stmt
ifElseParse = do
    kword "if"
    cond <- lexeme $ roundBr exprParser
    thn <- lexeme stmtParser
    kword "else"
    els <- lexeme stmtParser
    return (If cond thn $ Just els)
    

whileParser :: Parser Stmt
whileParser = do
    kword "while"
    cond <- lexeme $ roundBr exprParser
    thn <- lexeme stmtParser
    return $ While cond thn

progParser :: Parser Program
progParser = Program <$> stmtParser
