module LParser.LParser where

import qualified Control.Monad.Combinators.Expr as CE
import Data.Void
import LParser.AstStmt
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L

type Parser = Parsec Void String

sc :: Parser ()
sc =
  L.space
    space1 -- (2)
    (L.skipLineComment "//") -- (3)
    (L.skipBlockComment "/*" "*/") -- (4)

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

symbol :: String -> Parser String
symbol = L.symbol sc

pVar :: Parser Var
pVar = lexeme ((:) <$> letterChar <*> many alphaNumChar <?> "variable")

pOperator :: Parser Operator
pOperator =
  choice
    [ Pow <$ chunk "^",
      Mult <$ chunk "*",
      Div <$ chunk "/",
      Plus <$ chunk "+",
      Minus <$ chunk "-",
      Eq <$ chunk "==",
      Neq <$ chunk "!=",
      Le <$ chunk "<=",
      Lt <$ chunk "<",
      Ge <$ chunk ">=",
      Gt <$ chunk ">"
    ]

pInteger :: Parser Expr
pInteger = Num <$> lexeme L.decimal

parens :: Parser a -> Parser a
parens = between (symbol "(") (symbol ")")

pTerm :: Parser Expr
pTerm = choice [parens pExpr, pInteger, Ident <$> pVar]

pExpr :: Parser Expr
pExpr = CE.makeExprParser pTerm operatorTable

operatorTable :: [[CE.Operator Parser Expr]]
operatorTable =
  [ [binary "^" $ BinOp Pow],
    [binary "*" $ BinOp Mult, binary "/" $ BinOp Div],
    [ binary "+" $ BinOp Plus,
      binary "-" $ BinOp Minus
    ],
    [ binary "==" $ BinOp Eq,
      binary "!=" $ BinOp Neq,
      binary "<=" $ BinOp Le,
      binary "<" $ BinOp Lt,
      binary ">=" $ BinOp Ge,
      binary ">" $ BinOp Gt
    ]
  ]

binary :: String -> (Expr -> Expr -> Expr) -> CE.Operator Parser Expr
binary name f = CE.InfixL (f <$ symbol name)

semicolon :: Parser String
semicolon = symbol ";"

pIf :: Parser Stmt
pIf = do
  _ <- symbol "if"
  _ <- symbol "("
  e <- pExpr
  _ <- symbol ")"
  _ <- symbol "{"
  doBlock <- pSeq
  _ <- symbol "}"
  elseBlock <- optional $ do
    _ <- symbol "else"
    _ <- symbol "{"
    stmts <- pSeq
    _ <- symbol "}"
    return stmts
  return $ If e doBlock elseBlock

pWhile :: Parser Stmt
pWhile = do
  _ <- symbol "while"
  _ <- symbol "("
  e <- pExpr
  _ <- symbol ")"
  _ <- symbol "{"
  doBlock <- pSeq
  _ <- symbol "}"
  return $ While e doBlock

pIgnore :: Parser Stmt 
pIgnore = do
  e <- pExpr
  _ <- semicolon
  return $ Ignore e

pDecl :: Parser Stmt 
pDecl = do
  _ <- symbol "var"
  name <- pVar
  _ <- semicolon
  return $ Decl name

pStmt :: Parser Stmt
pStmt =
  choice
    [ pWhile,
      pIf,
      pRead,
      pWrite,
      pDecl,
      try pAssign,
      pIgnore
    ]

pAssign :: Parser Stmt 
pAssign = do
  name <- pVar
  _ <- symbol "="
  val <- pExpr
  _ <- semicolon
  return $ Assign name val

pRead :: Parser Stmt 
pRead = do
  _ <- symbol "read"
  _ <- symbol "("
  name <- pVar
  _ <- symbol ")"
  _ <- semicolon
  return $ Read name

pWrite :: Parser Stmt 
pWrite = do
  _ <- symbol "print"
  _ <- symbol "("
  e <- pExpr
  _ <- symbol ")"
  _ <- semicolon
  return $ Write e

pSeq :: Parser Stmt
pSeq = Seq <$> many pStmt

pProgram :: Parser Program 
pProgram = Program <$> pSeq