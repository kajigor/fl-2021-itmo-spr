module Parser where

import Data.Void (Void(..))
import Text.Megaparsec
import qualified Text.Megaparsec.Char.Lexer as Lexer
import qualified Text.Megaparsec.Char as Char
import Control.Monad.Combinators.Expr (makeExprParser, Operator(InfixL, InfixR, InfixN))
import Lang

type Parser = Parsec Void String

parse :: String -> Either String Program 
parse = runBundlingParser progParser

progParser :: Parser Program
progParser = Program <$> blockExprParser <* eof

runBundlingParser parser =
    mapLeft errorBundlePretty . runParser parser ""
  where
    mapLeft f = either (Left . f) Right

space :: Parser ()
space = Lexer.space Char.space1 empty empty

lexeme :: Parser a -> Parser a
lexeme = Lexer.lexeme space

symbol :: String -> Parser String
symbol = Lexer.symbol space

keywords :: [String]
keywords = ["if", "else", "true", "false", "while", "read", "write"]

ident :: Parser String
ident = (lexeme . try) (p >>= check)
  where
    p = (:) <$> Char.letterChar <*> many (Char.char '_' <|> Char.alphaNumChar)
    check x = if x `elem` keywords
              then fail $ show x ++ " cannot be an identifier"
              else return x

num :: Parser Int
num = lexeme Lexer.decimal

basicExprParser :: Parser BasicExpr
basicExprParser = try $ do (Ident <$> ident) <|> (Tru <$ symbol "true") <|> (Fls <$ symbol "false") <|> (Num <$> num)

unOpParser :: Parser UnOp
unOpParser = try $ do (Not <$ symbol "!") <|> (Neg <$ symbol "-")

unExprParser :: Parser Expr
unExprParser = try $ do UnExpr <$> optional unOpParser <*> basicExprParser

binExprParser :: Parser Expr
binExprParser = try $ makeExprParser (assignParser <|> unExprParser <|> brackets exprParser) opTable
  where opTable = [ [leftAssoc "*" (BinExpr Mult), leftAssoc "/" (BinExpr Div), noAssoc "%" (BinExpr Mod)],
                    [leftAssoc "+" (BinExpr Plus), leftAssoc "-" (BinExpr Minus)],
                    [noAssoc "<=" (BinExpr Le), noAssoc "<" (BinExpr Lt), noAssoc ">=" (BinExpr Ge), noAssoc ">" (BinExpr Gt)],
                    [noAssoc "!=" (BinExpr Neq), noAssoc "==" (BinExpr Eq)],
                    [leftAssoc "&&" (BinExpr And)],
                    [leftAssoc "||" (BinExpr Or)]]
        leftAssoc name op = InfixL (op <$ symbol name)
        rightAssoc name op = InfixR (op <$ symbol name)
        noAssoc name op = InfixN (op <$ symbol name)

brackets :: Parser a -> Parser a
brackets = between (symbol "(") (symbol ")")

elseParser :: Parser BlockExpr
elseParser = try $ do
    symbol "else"
    blockExprParser

ifParser :: Parser Expr
ifParser = try $ do
    symbol "if"
    cond <- brackets exprParser
    body <- blockExprParser
    elseBlock <- optional elseParser 
    return $ IfStmt cond body elseBlock

whileParser :: Parser Expr
whileParser = try $ While <$ symbol "while" <*> brackets exprParser <*> blockExprParser

readParser :: Parser Expr
readParser = try $ Read <$ symbol "read" <*> brackets ident

writeParser :: Parser Expr
writeParser = try $ Write <$ symbol "write" <*> brackets exprParser

assignParser :: Parser Expr
assignParser = try $ do
    var <- ident
    symbol "="
    body <- blockExprParser
    return $ AssignStmt var body

exprParser :: Parser Expr
exprParser = try $ assignParser <|> binExprParser <|> readParser <|> writeParser <|> ifParser <|> whileParser <|> unExprParser 

blockExprParser :: Parser BlockExpr
blockExprParser = try $ do
    symbol "{"
    exprs <- sepBy1 exprParser (symbol ";")
    symbol "}"
    return $ BlockExpr exprs
